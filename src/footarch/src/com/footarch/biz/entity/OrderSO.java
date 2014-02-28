package com.footarch.biz.entity;

import javax.persistence.Column;

import com.globalwave.base.BaseSO;

public class OrderSO extends BaseSO {
    @Column(name="id")
    private Long[] ids ;
    private Long user_id;
    private String status;

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

	@Override
	public Class<?> getTableClass() {
		return Order.class;
	}

}
