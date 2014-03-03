package com.footarch.biz.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footarch.biz.entity.Order;
import com.footarch.biz.entity.OrderItems;
import com.footarch.biz.entity.OrderItemsSO;
import com.footarch.biz.entity.Product;
import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.SessionUser;


@Service("orderItemBO")
@Scope("prototype")
@Transactional
public class OrderItemsBO extends BaseServiceImpl {
	private OrderBO orderBO;
	private ProductBO productBO;
	
	public OrderItems create(OrderItems orderItems) {
		if (orderItems.getCatentry_id() == null || orderItems.getQuantity() == null) {
			return null;
		}
		
		Product product = productBO.get(orderItems.getCatentry_id());
		if (product == null) {
			return null;
		}
		orderItems.setName(product.getName_cn());
		orderItems.setList_price(product.getMarket_price());
		orderItems.setPrice(product.getSelling_price());
		
		if (orderItems.getOrder_id() == null) {
			//查找购物车
			SessionUser su = SessionUser.get();
			Order order = orderBO.getShopCar(su.getUser().getId());
			if (order == null) {
				order = new Order();
				order.setStatus("P");
				order.setUser_id(su.getUser().getId());
				order = orderBO.create(order);
				orderItems.setOrder_id(order.getId());
			}
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

	public ProductBO getProductBO() {
		return productBO;
	}

	public void setProductBO(ProductBO productBO) {
		this.productBO = productBO;
	}
}
