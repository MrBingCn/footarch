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
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;

@Service("orderItemsBO")
@Scope("prototype")
@Transactional
public class OrderItemsBO extends BaseServiceImpl {
	public Order create(OrderItems orderItems) {
		Product product = getProductBO().get(orderItems.getCatentry_id());
		if (product == null) {
			throw new BusinessException("product is not found for product_id:" + orderItems.getCatentry_id().longValue()) ;
		}
		orderItems.setName(product.getName_cn());
		orderItems.setList_price(product.getMarket_price());
		orderItems.setPrice(product.getSelling_price());
		orderItems = (OrderItems) jdbcDao.insert(orderItems);
		
		Order order = getOrderBO().get(orderItems.getOrder_id());
		getPromotionBO().caculate(order);
		getOrderBO().refreshTotal(order);
		return order;
	}
	
	public void update(OrderItems orderItems) {
		jdbcDao.update(orderItems);
		getPromotionBO().caculate(orderItems.getOrder());
		getOrderBO().refreshTotal(orderItems.getOrder());
	}
	
	public void delete(OrderItems orderItems) {
		jdbcDao.delete(orderItems);
		ArrayPageList<OrderItems> items = getItemsByOrderId(orderItems.getOrder_id());
		if (items.size() == 0) {
			getOrderBO().delete(orderItems.getOrder(), false);
		}
		else {
			getPromotionBO().caculate(orderItems.getOrder());
			getOrderBO().refreshTotal(orderItems.getOrder());
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
    		orderItems.setOrder(getOrderBO().get(orderItems.getOrder_id()));
    	}
    }
    
	public OrderBO getOrderBO() {
		return (OrderBO)CodeHelper.getAppContext().getBean("orderBO");
	}
	
	public PromotionBO getPromotionBO() {
		return (PromotionBO)CodeHelper.getAppContext().getBean("promotionBO");
	}
	
	public ProductBO getProductBO() {
		return (ProductBO)CodeHelper.getAppContext().getBean("productBO");
	}
}
