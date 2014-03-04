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
	
    public OrderItems get(Long id) { 
    	if (id == null) {// id is require
    		throw new BusinessException("orderItems id is required") ;
    	}
    	OrderItems orderItems = new OrderItems() ;
    	orderItems.setId(id) ;
    	orderItems = (OrderItems) jdbcDao.get(orderItems) ;
    	initOrder(orderItems);
    	return orderItems;
    }
	
	public OrderItems create(OrderItems orderItems) {
		Product product = productBO.get(orderItems.getCatentry_id());
		if (product == null) {
			throw new BusinessException("product is not found for product_id:" + orderItems.getCatentry_id().longValue()) ;
		}
		orderItems.setName(product.getName_cn());
		orderItems.setList_price(product.getMarket_price());
		orderItems.setPrice(product.getSelling_price());

		orderItems = (OrderItems) jdbcDao.insert(orderItems);
		orderBO.refreshTotal(orderItems.getOrder());
		return orderItems;
	}
	
	public void update(OrderItems orderItems) {
		jdbcDao.update(orderItems);
		orderBO.refreshTotal(orderItems.getOrder());
	}
	
	public void delete(OrderItems orderItems) {
		jdbcDao.delete(orderItems);
		ArrayPageList<OrderItems> items = getItemsByOrderId(orderItems.getOrder_id());
		if (items.size() == 0) {
			orderBO.delete(orderItems.getOrder(), false);
		}
		else {
			orderBO.refreshTotal(orderItems.getOrder());
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
    
    public void initOrder(OrderItems orderItems) {
    	if (orderItems.getOrder() == null && orderItems.getOrder_id() != null) {
    		orderItems.setOrder(orderBO.get(orderItems.getOrder_id()));
    	}
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
