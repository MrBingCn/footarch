package com.footarch.biz.entity;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.globalwave.common.U;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.system.entity.SessionUser;
import com.globalwave.system.entity.User;
import com.globalwave.util.GsonUtil;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * 
 * 此类不作持久化用，只用作报表的展现
 * 
 * @author Virgil.Chen
 *
 */
public class Report {

	private String operator ;
	private User user ;
	private Timestamp print_on ;
	private ReportSO so ;
	private Integer order_count ;

	private List<?> items ;
	private List<?> item1s ;
	private List<?> item2s ;
	private List<?> item3s ;
	private List<?> item4s ;
	private List<?> item5s ;
	
	private Object total ;
	
	public String getOperator() {
	
		if (operator == null) {
			operator = SessionUser.get().getUser().getName_cn() + "/" + SessionUser.get().getUser().getName_en() ;
		}
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public Timestamp getPrint_on() {
		if (print_on == null) {
			return U.currentTimestamp() ;
		}
		return print_on;
	}

	public String getPrint_on_short() {
		return U.yyyyMMdd_(getPrint_on());
	}
	
	public void setPrint_on(Timestamp print_on) {
		this.print_on = print_on;
	}
	public ReportSO getSo() {
		return so;
	}
	public void setSo(ReportSO so) {
		this.so = so;
	}
	public List<?> getItems() {
		return items;
	}
	public void setItems(List<?> items) {
		this.items = items;
	}
	public List<?> getItem1s() {
		return item1s;
	}
	public void setItem1s(List<?> item1s) {
		this.item1s = item1s;
	}
	public List<?> getItem2s() {
		return item2s;
	}
	public void setItem2s(List<?> item2s) {
		this.item2s = item2s;
	}
	public List<?> getItem3s() {
		return item3s;
	}
	public void setItem3s(List<?> item3s) {
		this.item3s = item3s;
	}
	public List<?> getItem4s() {
		return item4s;
	}
	public void setItem4s(List<?> item4s) {
		this.item4s = item4s;
	}
	public List<?> getItem5s() {
		return item5s;
	}
	public void setItem5s(List<?> item5s) {
		this.item5s = item5s;
	}
	public Object getTotal() {
		return total;
	}
	public void setTotal(Object total) {
		this.total = total;
	}
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getCurrencyRate() {
		return CodeHelper.getString("CM.currency.rate", "desc_", "USD2CNY") ;
	}
	
    
    public Integer getOrder_count() {
    	if (order_count != null) {
    		return order_count ;
    	}
    	
    	if (this.total != null && this.total instanceof Map) {
    		Object count = ((Map) this.total).get("order_count") ;
    		if (count == null) {
    			return null ;
    		}
    		
    		return ((Long)count).intValue() ;
    	}
    	
		return order_count;
	}
	public void setOrder_count(Integer order_count) {
		this.order_count = order_count;
	}
	
	public JsonObject toJson() {

        Gson gson = GsonUtil.getGson(); 
        JsonObject jsonObject = new JsonObject(); 
        jsonObject.add("items", gson.toJsonTree(this.items));
        jsonObject.add("total", gson.toJsonTree(this.total));
        return jsonObject ;
        
    }
    
    private List treeToList(List<?> items, int deep, Long pro_id) {
    	return null ;
    }

    public String asJson() {
    	return toJson().toString() ;
    }

}
