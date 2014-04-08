package com.footarch.biz.entity;

import java.sql.Timestamp;

import javax.persistence.Column;

import com.globalwave.base.BaseSO;

public class PromotionSO extends BaseSO {
    @Column(name="id")
    private Long[] ids ;
    private String status;
    private Timestamp checkTime;

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Timestamp checkTime) {
		this.checkTime = checkTime;
	}

	@Override
	public Class<?> getTableClass() {
		return Promotion.class;
	}
}
