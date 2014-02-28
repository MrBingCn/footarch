package com.footarch.biz.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footarch.biz.entity.OrderItems;
import com.footarch.biz.entity.OrderItemsSO;
import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;


@Service("orderItemBO")
@Scope("prototype")
@Transactional
public class OrderItemsBO extends BaseServiceImpl {
	private OrderBO orderBO;
	
	public OrderItems create(OrderItems orderItems) {
		if (orderItems.getOrder_id() == null || orderItems.getCatentry_id() == null || orderItems.getQuantity() == null) {
			return null;
		}
		orderItems = (OrderItems) jdbcDao.insert(orderItems);
		orderBO.refreshTotal(orderItems.getOrder_id());
		return orderItems;
	}
	
	public void update(OrderItems orderItems) {
		jdbcDao.update(orderItems);
		orderBO.refreshTotal(orderItems.getOrder_id());
	}
	
	public void delete(OrderItems orderItems) {
		jdbcDao.delete(orderItems);
		orderBO.refreshTotal(orderItems.getOrder_id());
	}

    public ArrayPageList<OrderItems> query(
    		OrderItemsSO orderItemsSO) {
        return (ArrayPageList<OrderItems>)jdbcDao.query(orderItemsSO, OrderItems.class);
    }
    
	public OrderBO getOrderBO() {
		return orderBO;
	}

	public void setOrderBO(OrderBO orderBO) {
		this.orderBO = orderBO;
	}
}
