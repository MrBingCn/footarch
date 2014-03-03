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
import com.globalwave.common.exception.BusinessException;

@Service("orderItemBO")
@Scope("prototype")
@Transactional
public class OrderItemsBO extends BaseServiceImpl {
	private OrderBO orderBO;
	private ProductBO productBO;
	
	public OrderItems create(OrderItems orderItems, Long userId) {
		if (orderItems.getCatentry_id() == null || orderItems.getQuantity() == null) {
			throw new BusinessException("product id or quantity is required") ;
		}
		if (userId == null || userId.longValue() == 0l) {
			throw new BusinessException("userId is required") ;
		}
		Product product = productBO.get(orderItems.getCatentry_id());
		if (product == null) {
			throw new BusinessException("product is not found for product_id:" + orderItems.getCatentry_id().longValue()) ;
		}
		orderItems.setName(product.getName_cn());
		orderItems.setList_price(product.getMarket_price());
		orderItems.setPrice(product.getSelling_price());
		
		if (orderItems.getOrder_id() == null) {
			//查找购物车
			Order order = orderBO.getShopCar(userId);
			if (order == null) {
				order = new Order();
				order.setStatus("P");
				order.setUser_id(userId);
				order = orderBO.create(order);
				orderItems.setOrder_id(order.getId());
			}
		}
		else {
			//确保操作的是当前用户
			Order order = orderBO.get(orderItems.getOrder_id());
			if (order == null) {
				throw new BusinessException("order is not found for order_id:" + orderItems.getOrder_id().longValue()) ;
			}
			if (order.getUser_id().longValue() != userId) {
				throw new BusinessException("user id of order is not match!") ;
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
	
	public void delete(OrderItems orderItems, Long userId) {
		Order order = orderBO.get(orderItems.getOrder_id());
		if (order == null) {
			throw new BusinessException("order is required") ;
		}
		if (order.getUser_id().longValue() != userId) {
			throw new BusinessException("user id of order is not match!") ;
		}
		if(order.getStatus().equals("P") || order.getStatus().equals("M")) {
			jdbcDao.delete(orderItems);
			ArrayPageList<OrderItems> items = getItemsByOrderId(order.getId());
			if (items.size() == 0) {
				orderBO.delete(order, false);
			}
			else {
				orderBO.refreshTotal(orderItems.getOrder_id());
			}
		}
		else {
			throw new BusinessException("order items can't delete for status:" + order.getStatus()) ;
		}
	}
	
	public ArrayPageList<OrderItems> getItemsByOrderId(Long orderId) {
		OrderItemsSO orderItemsSO = new OrderItemsSO();
		orderItemsSO.setOrder_id(orderId);
		orderItemsSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE);
		return query(orderItemsSO);
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
