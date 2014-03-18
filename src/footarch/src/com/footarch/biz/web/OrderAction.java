package com.footarch.biz.web;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.footarch.biz.entity.Address;
import com.footarch.biz.entity.Order;
import com.footarch.biz.entity.OrderItems;
import com.footarch.biz.entity.OrderSO;
import com.footarch.biz.entity.Payment;
import com.footarch.biz.entity.PaymentSO;
import com.footarch.biz.service.AddressBO;
import com.footarch.biz.service.OrderBO;
import com.footarch.biz.service.OrderItemsBO;
import com.footarch.biz.service.PaymentBO;
import com.globalwave.base.BaseAction;
import com.globalwave.base.web.ResponseMessage;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;
import com.globalwave.system.entity.SessionUser;
import com.globalwave.util.GsonUtil;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.opensymphony.xwork2.Preparable;

@Service("biz_orderAction")
@Scope("prototype")
public class OrderAction extends BaseAction implements Preparable {
	private OrderBO orderBO;
	private OrderItemsBO orderItemsBO;
	private Order order;
	private OrderItems orderItems;
	
	//查询购物车
	//http://www.footarch.com:8080/biz/order_getShopCar.action
	public String getShopCar() throws Exception {
		Long userId = SessionUser.get().getUser().getId();
		//查找购物车
		Order order = orderBO.getShopCar(userId);
		renderObject(order, ResponseMessage.KEY_OPERATE_OK);
		return null;
	}
	
	//添加到购物车
	//http://www.footarch.com:8080/biz/order_addToShopCar.action?orderItems.catentry_id=1&orderItems.quantity=1
	public String addToShopCar() throws Exception {
		if (orderItems.getCatentry_id() == null || orderItems.getQuantity() == null) {
			throw new BusinessException("product id or quantity is required") ;
		}
		
		Long userId = SessionUser.get().getUser().getId();
		//查找购物车
		Order order = orderBO.getShopCar(userId);
		if (order == null) {
			order = new Order();
			order.setStatus("T");
			order.setUser_id(userId);
			order = orderBO.create(order);
		}
		orderItems.setOrder_id(order.getId());
		order = orderItemsBO.create(orderItems);
		
		renderObject(order, ResponseMessage.KEY_CREATE_OK);
		return null;
	}
	
	//修改购物车中商品数量
	//http://www.footarch.com:8080/biz/order_updateQuantity.action?orderItems.order_id=1&orderItems.id=12&orderItems.quantity=3
	public String updateQuantity() throws Exception {
		if (orderItems.getOrder_id() == null || orderItems.getId() == null || orderItems.getQuantity() == null) {
			throw new BusinessException("order id or item id or quantity is required") ;
		}
		Order order = orderBO.get(orderItems.getOrder_id());
		checkMyOrder(order);
		checkCanModify(order);
		for (OrderItems item : order.getItems()) {
			if (item.getId().longValue() == orderItems.getId().longValue()) {
				item.setQuantity(orderItems.getQuantity());
				item.setOrder(order);
				orderItemsBO.update(item);
				break;
			}
		}
		
		renderObject(order, ResponseMessage.KEY_UPDATE_OK);
		return null;
	}
	
	//删除购物车中的商品
	//http://www.footarch.com:8080/biz/order_deleteOrderItem.action?orderItems.order_id=1&orderItems.id=12
	public String deleteOrderItem() throws Exception {
		if (orderItems.getOrder_id() == null || orderItems.getId() == null) {
			throw new BusinessException("order id or item id is required") ;
		}
		Order order = orderBO.get(orderItems.getOrder_id());
		//OrderItems item = orderItemsBO.get(orderItems.getId());
		checkMyOrder(order);
		checkCanModify(order);
		OrderItems oi = null;
		for (OrderItems item : order.getItems()) {
			if (item.getId().longValue() == orderItems.getId().longValue()) {
				oi = item;
				break;
			}
		}
		if (oi != null) {
			oi.setOrder(order);
			order.getItems().remove(oi);
			orderItemsBO.delete(oi);
		}
		
		renderObject(order, ResponseMessage.KEY_DELETE_OK);
		return null;
	}
	
	//提交订单
	//http://www.footarch.com:8080/biz/order_submitOrder.action?id=1&address_id=1&pay_system_name=AliPay
	public String submitOrder() throws Exception {
		Order order = orderBO.get(this.id) ;
		checkMyOrder(order);
		if (order.getStatus().equals("T")) {
			order.setTime_place(new Timestamp(System.currentTimeMillis()));
			String addressId = this.getRequest().getParameter("address_id");
			String paySystemName = this.getRequest().getParameter("pay_system_name");
			if (addressId == null || paySystemName == null) {
				throw new BusinessException("address_id or pay_system_name is invalid") ;
			}
			Address address = getAddressBO().get(new Long(addressId));
			Long userId = SessionUser.get().getUser().getId();
			if (address == null || address.getUser_id().longValue() != userId.longValue()) {
				throw new BusinessException("address_id is invalid") ;
			}
			order.setAddress_id(address.getId());
			
			if (paySystemName.equals("AliPay")) {
				order.setPayment_type("-1");
				order.setStatus("M");
			}
			else if (paySystemName.equals("COD")) {
				order.setPayment_type("1");
				order.setStatus("C");
				order.setStatus_payment("1");
			}
			else {
				throw new BusinessException("pay_system_name is invalid") ;
			}
			order.setPay_system_name(paySystemName);
			
			orderBO.update(order);
		}
		else {
			throw new BusinessException("order state is invalid") ;
		}
		
		renderObject(order, ResponseMessage.KEY_UPDATE_OK);
		return null;
	}
	
	//订单支付,跳到银行页面
	public String payOrder() throws Exception {
		Order order = orderBO.get(this.id) ;
		checkMyOrder(order);
		checkCanPay(order);
		
		Payment payment = new Payment();
		payment.setOrder_id(order.getId());
		payment.setExpected_amount(order.getTotal());
		payment.setApproving_amount(order.getTotal());
		payment.setPay_system_name(order.getPay_system_name());
		getPaymentBO().create(payment);

			//todo
			//jump to bank

		renderObject(order, ResponseMessage.KEY_UPDATE_OK);
		return null;
	}
	
	//订单支付通知
	public String notifyPay() throws Exception {
		//todo
		if (true) {
			String paymentId = this.getRequest().getParameter("pid");
			orderBO.notifyPay(new Long(paymentId));
		}
		renderObject(order, ResponseMessage.KEY_UPDATE_OK);
		return null;
	}
	
	//取消订单
	//http://www.footarch.com:8080/biz/order_cancleOrder.action?id=1
	public String cancleOrder() throws Exception {
		Order order = orderBO.get(this.id) ;
		checkMyOrder(order);
		if (order.getStatus().equals("M")) {
			order.setStatus("X");
			orderBO.update(order);
		}
		else {
			throw new BusinessException("order state is invalid") ;
		}
		
		renderObject(order, ResponseMessage.KEY_UPDATE_OK);
		return null;
	}
	
	//我的订单列表
	public String myOrderList() throws Exception {
		Long userId = SessionUser.get().getUser().getId();
		OrderSO orderSO = new OrderSO();
		orderSO.setUser_id(userId);
		Set<String> status = new HashSet<String>();
		status.add("T");
		orderSO.setNotInStatus(status);
		
		ArrayPageList<Map<String, Object>> pageList = orderBO.getOrder(orderSO, "bizSQLs:orders");
		renderList(pageList) ; 
        return null ;
	}
	
	//订单明细
	public String myOrderDetail() throws Exception {  
		Order order = orderBO.get(this.id) ;
		checkMyOrder(order);
		
        renderJson(getOrderDetail(order)) ;
        return null ;  
	}
	
	private String getOrderDetail(Order order) {
		Gson gson = GsonUtil.getGson();
		JsonObject jsonObject = new JsonObject(); 
        jsonObject.add("order", gson.toJsonTree(order));
        if (order.getAddress_id() != null) {
        	jsonObject.add("address", gson.toJsonTree(getAddressBO().get(order.getAddress_id())));
        }
        if (order.getStatus_payment().equals("1") && order.getPayment_type().equals("-1")) {
        	PaymentSO paymentSO = new PaymentSO();
        	paymentSO.setOrder_id(order.getId());
        	paymentSO.setStatus("1");
        	jsonObject.add("payments", gson.toJsonTree(getPaymentBO().query(paymentSO)));
        }
        return gson.toJson(jsonObject);
	}
	
	//确保是当前用户的订单
	private void checkMyOrder(Order order) {
		checkOrder(order);
		Long userId = SessionUser.get().getUser().getId();
		if (order.getUser_id().longValue() != userId) {
			throw new BusinessException("user id[" +userId.longValue() + "] of order[" + order.getId().longValue() + "] is not match!") ;
		}
	}
	
	//确保是当前用户的商品
	private void checkMyOrderItems(OrderItems orderItems) {
		if (orderItems.getOrder() == null) {
			orderItemsBO.initOrder(orderItems);
		}
		checkMyOrder(orderItems.getOrder());
	}
	
	private void checkOrder(Order order) {
		if (order == null) {
			throw new BusinessException("order is required!") ;
		}
	}
	
	//确保订单可被当前用户修改
	private void checkCanModify(Order order) {
		if(!(order.getStatus().equals("T"))) {
			throw new BusinessException("order[" + order.getId().longValue() + "] status is " + order.getStatus() + ", can not modify!") ;
		}
	}

	//确保订单可被支付
	private void checkCanPay(Order order) {
		if (!(order.getStatus().equals("M"))) {
			throw new BusinessException("order[" + order.getId().longValue() + "] status is " + order.getStatus() + ", can not pay!") ;
		}
		if (order.getPay_system_name() == null) {
			throw new BusinessException("order[" + order.getId().longValue() + "] pay system name is required, can not pay!") ;
		}
	}

	public OrderBO getOrderBO() {
		return orderBO;
	}

	public void setOrderBO(OrderBO orderBO) {
		this.orderBO = orderBO;
	}

	public OrderItemsBO getOrderItemsBO() {
		return orderItemsBO;
	}

	public void setOrderItemsBO(OrderItemsBO orderItemsBO) {
		this.orderItemsBO = orderItemsBO;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public OrderItems getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(OrderItems orderItems) {
		this.orderItems = orderItems;
	}
	
	public AddressBO getAddressBO() {
		return (AddressBO)CodeHelper.getAppContext().getBean("addressBO");
	}
	
	public PaymentBO getPaymentBO() {
		return (PaymentBO)CodeHelper.getAppContext().getBean("paymentBO");
	}
}
