package com.footarch.biz.service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
//import java.text.SimpleDateFormat;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footarch.biz.entity.Order;
import com.footarch.biz.entity.OrderItems;
import com.footarch.biz.entity.OrderItemsSO;
import com.footarch.biz.entity.OrderSO;
import com.footarch.biz.entity.Payment;
import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
//import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;
import com.globalwave.system.entity.SessionUser;

@Service("orderBO")
@Scope("prototype")
@Transactional
public class OrderBO extends BaseServiceImpl {
	//public static SimpleDateFormat outFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private OrderItemsBO orderItemsBO;
	
	public Order create(Order order) {
		return (Order) jdbcDao.insert(order);
	}
	
	public void update(Order order) {
		jdbcDao.update(order);
	}
	
	public void delete(Order order) {
		order.setStatus("X");
		order.addInclusions("status");
		update(order);
	}

	public void delete(Order order, boolean logic) {
		if (logic) {
			delete(order);
		}
		else {
			jdbcDao.delete(order);
		}
	}
	
    public ArrayPageList<Order> query(
    		OrderSO orderSO) {
        return (ArrayPageList<Order>)jdbcDao.query(orderSO, Order.class);
    }
	
    public Order get(Long id) { 
    	if (id == null) {// id is require
    		throw new BusinessException("order id is required") ;
    	}
    	Order order = new Order() ;
    	order.setId(id) ;
        return (Order) jdbcDao.get(order) ;
    }
    
    public Order getShopCar(Long userId) { 
    	OrderSO orderSO = new OrderSO();
    	orderSO.setStatus("T");
    	orderSO.setUser_id(userId);
    	orderSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE);
    	ArrayPageList<Order> orders = query(orderSO);
    	if (orders != null && orders.size() > 0) {
    		return orders.get(0);
    	}
    	return null;
    }
    
	//重新计算总金额
	public void refreshTotal(Order order) {
		if (order == null) {
			return;
		}
		ArrayPageList<OrderItems> items = orderItemsBO.getItemsByOrderId(order.getId());
		BigDecimal total_product = new BigDecimal(0);
		BigDecimal adjustment_product = new BigDecimal(0);
		for (OrderItems item : items) {
			BigDecimal price = new BigDecimal(Double.toString(item.getPrice().doubleValue()));
			BigDecimal quantity = new BigDecimal(String.valueOf(item.getQuantity().intValue()));
			BigDecimal adjustment = new BigDecimal(Double.toString(item.getAdjustment().doubleValue()));
			total_product = total_product.add(price.multiply(quantity));
			adjustment_product = adjustment_product.add(adjustment);
		}
		
		order.setTotal_product(new Double(total_product.doubleValue()));
		order.setAdjustment_product(new Double(adjustment_product.doubleValue()));
		
		BigDecimal ship = new BigDecimal(Double.toString(order.getShip().doubleValue()));
		BigDecimal adjustment_ship = new BigDecimal(Double.toString(order.getAdjustment_ship().doubleValue()));
		BigDecimal adjustment_order = new BigDecimal(Double.toString(order.getAdjustment_order().doubleValue()));
		BigDecimal adjustment_manual = new BigDecimal(Double.toString(order.getAdjustment_manual().doubleValue()));
		
		order.setTotal(new Double(total_product.add(ship).add(adjustment_product).add(adjustment_ship).add(adjustment_order).add(adjustment_manual).doubleValue()));
		update(order);
	}

	/**
	 * 计算汇总订单各级代理的Ar和Commission
	 * 
	 * @param order
	 */
	public void sumArAndCommission(Order order) {
	    SessionUser user = SessionUser.get() ;
	    
	    long[] orgIds = user.getOrganization_ids() ;
	    
	    order.setOrder_agent_level(orgIds.length) ;

	    double total = order.getTotal() ;
	    
	    for (int i = orgIds.length - 1 ; i >= 0  ; i --) {
	    	long orgId = orgIds[i];
	    	double ar = total * CodeHelper.getAsDouble("Organization", "ar_rate", orgId) ;
	    	
	    	if (i == 0) {
		    	order.setAr_amount_0(ar) ;
	    	} else if (i == 1) {
		    	order.setAgent_id_1(orgId) ;
		    	order.setAr_amount_1(ar);
	    	} else if (i == 2) {
		    	order.setAgent_id_2(orgId) ;
		    	order.setAr_amount_2(ar);
	    	} else if (i == 3) {
		    	order.setAgent_id_3(orgId) ;
		    	order.setAr_amount_3(ar);
	    	} else if (i == 4) {
		    	order.setAgent_id_4(orgId) ;
		    	order.setAr_amount_4(ar);
	    	} else if (i == 5) {
		    	order.setAgent_id_5(orgId) ;
		    	order.setAr_amount_5(ar);
	    	}
	    }
	    
    	order.setCommission(total * CodeHelper.getAsDouble("Organization", "commission_rate", orgIds[orgIds.length - 1])) ;
	}
	
	public void notifyPay(Long pid) {
		Payment payment = getPaymentBO().get(pid);
		if (payment != null) {
			Order order = get(payment.getOrder_id()) ;
			if (order.getStatus().equals("M")) {
				Timestamp current = new Timestamp(System.currentTimeMillis());
				order.setStatus("C");
				order.setTime_pay(current);
				order.setStatus_payment("1");
				update(order);
				
				payment.setApproved_amount(order.getTotal());
				payment.setApproving_amount(new Double(0));
				payment.setStatus("1");
				payment.setTime_pay(current);
				getPaymentBO().update(payment);
			}
		}
	}
	
	public ArrayPageList<Map<String, Object>> getOrder(OrderSO orderSO, String sqlName) {
		if (orderSO.getOrderby() == null) {
			orderSO.setOrderby("order by id desc");
		}
		return (ArrayPageList<Map<String, Object>>) jdbcDao.queryName(sqlName, orderSO, HashMap.class);
	}
	
	public OrderItemsBO getOrderItemsBO() {
		return orderItemsBO;
	}

	public void setOrderItemsBO(OrderItemsBO orderItemsBO) {
		this.orderItemsBO = orderItemsBO;
	}
	
	public PaymentBO getPaymentBO() {
		return (PaymentBO)CodeHelper.getAppContext().getBean("paymentBO");
	}
}
