package com.footarch.biz.service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footarch.biz.entity.Order;
import com.footarch.biz.entity.OrderItems;
import com.footarch.biz.entity.OrderSO;
import com.footarch.biz.entity.Promotion;
import com.footarch.biz.entity.PromotionSO;
import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;

@Service("promotionBO")
@Scope("prototype")
@Transactional
public class PromotionBO extends BaseServiceImpl {
	public Promotion create(Promotion promotion) {
		return (Promotion) jdbcDao.insert(promotion);
	}
	
	public void update(Promotion promotion) {
		jdbcDao.update(promotion);
	}
	
//	public void delete(Promotion promotion) {
//		promotion.setStatus("2");
//		promotion.addInclusions("status");
//		update(promotion);
//	}
	
    public Promotion get(Long id) { 
    	if (id == null) {
    		throw new BusinessException("promotion id is required") ;
    	}
    	Promotion promotion = new Promotion() ;
    	promotion.setId(id) ;
        return (Promotion) jdbcDao.get(promotion) ;
    }
	
    public ArrayPageList<Promotion> query(
    		PromotionSO promotionSO) {
    	if (promotionSO == null) {
    		promotionSO = new PromotionSO();
    	}
        return (ArrayPageList<Promotion>)jdbcDao.query(promotionSO, Promotion.class);
    }
    
    public ArrayPageList<Promotion> getInvalidPromotionForOrder(Order order) {
    	PromotionSO promotionSO = new PromotionSO();
    	promotionSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE);
    	if (order.getTime_place() != null) {
    		promotionSO.setCheckTime(order.getTime_place());
    	}
    	else {
    		promotionSO.setCheckTime(order.getCreated_on());
    	}
    	
    	return (ArrayPageList<Promotion>) jdbcDao.queryName("promotions", promotionSO, Promotion.class);
    }
    
    
    public void caculate(Order order) {
    	if ("1".equals(order.getPromotion_flag())) {
    		return;
    	}
    	
    	//重置优惠
    	BigDecimal zero = new BigDecimal(0);
    	order.setAdjustment_ship(new Double(zero.doubleValue()));
    	order.setAdjustment_product(new Double(zero.doubleValue()));
    	order.setAdjustment_order(new Double(zero.doubleValue()));
    	//删除赠品
    	Iterator<OrderItems> iter = order.getItems().iterator();  
    	while(iter.hasNext()){  
    		OrderItems item = iter.next();  
    	    if("1".equals(item.getGift())){  
    	        iter.remove();  
    	        continue;
    	    }  
    	    item.setAdjustment(new Double(zero.doubleValue()));
    	}  
    	
    	//删除订单与促销的关系
    	//todo
    	
    	//重新计算
    	ArrayPageList<Promotion> promotions = getInvalidPromotionForOrder(order);
    	for (Promotion promotion : promotions) {
    		if (promotion.getCondition_money() != null) {
    			
    		}
    	}
    	//update order
    }
    
    
    public OrderBO getOrderBO() {
		return (OrderBO)CodeHelper.getAppContext().getBean("orderBO");
	}
    
    public OrderItemsBO getOrderItemsBO() {
		return (OrderItemsBO)CodeHelper.getAppContext().getBean("orderItemsBO");
	}
}
