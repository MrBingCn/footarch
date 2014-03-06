package com.footarch.biz.entity;

import java.util.Set;

import javax.persistence.Column;

import com.globalwave.base.BaseSO;

public class OrderSO extends BaseSO {
    @Column(name="id")
    private Long[] ids ;
    private Long user_id;
    private String status;
    private Set<String> inStatus;
    private Set<String> notInStatus;
    private String orderby;

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Set<String> getInStatus() {
		return inStatus;
	}

	public void setInStatus(Set<String> inStatus) {
		this.inStatus = inStatus;
	}

	public Set<String> getNotInStatus() {
		return notInStatus;
	}

	public void setNotInStatus(Set<String> notInStatus) {
		this.notInStatus = notInStatus;
	}

	public String getOrderby() {
		return orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}

	@Override
	public Class<?> getTableClass() {
		return Order.class;
	}

}
