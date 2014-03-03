package com.footarch.biz.service;

import java.math.BigDecimal;
//import java.text.SimpleDateFormat;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footarch.biz.entity.Order;
import com.footarch.biz.entity.OrderItems;
import com.footarch.biz.entity.OrderItemsSO;
import com.footarch.biz.entity.OrderSO;
import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
//import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;

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
    	orderSO.setStatus("P");
    	orderSO.setUser_id(userId);
    	orderSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE);
    	ArrayPageList<Order> orders = query(orderSO);
    	if (orders != null && orders.size() > 0) {
    		return orders.get(0);
    	}
    	return null;
    }
    
	//重新计算总金额
	public void refreshTotal(Long orderId) {
		if (orderId == null) {
			return;
		}
		Order order  = get(orderId);
		if (order == null) {
			return;
		}
		OrderItemsSO orderItemsSO = new OrderItemsSO();
		orderItemsSO.setOrder_id(orderId);
		ArrayPageList<OrderItems> items = orderItemsBO.query(orderItemsSO);
		BigDecimal total = new BigDecimal(0);
		BigDecimal totalAdjustment = new BigDecimal(0);
		for (OrderItems item : items) {
			BigDecimal price = new BigDecimal(Double.toString(item.getPrice().doubleValue()));
			BigDecimal quantity = new BigDecimal(String.valueOf(item.getQuantity().intValue()));
			BigDecimal adjustment = new BigDecimal(Double.toString(item.getAdjustment().doubleValue()));
			total.add(price.multiply(quantity));
			totalAdjustment.add(adjustment);
		}
		
		order.setTotal_product(new Double(total.doubleValue()));
		order.setTotal_adjustment(new Double(totalAdjustment.doubleValue()));
		BigDecimal ship = new BigDecimal(Double.toString(order.getTotal_shipping().doubleValue()));
		order.setTotal(new Double(total.add(ship).subtract(totalAdjustment).doubleValue()));
		update(order);
	}

	public OrderItemsBO getOrderItemsBO() {
		return orderItemsBO;
	}

	public void setOrderItemsBO(OrderItemsBO orderItemsBO) {
		this.orderItemsBO = orderItemsBO;
	}
}
