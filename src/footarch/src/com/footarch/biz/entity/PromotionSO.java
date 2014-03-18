package com.footarch.biz.entity;

import javax.persistence.Column;

import com.globalwave.base.BaseSO;

public class PromotionSO extends BaseSO {
    @Column(name="id")
    private Long[] ids ;
    private String status;

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

	@Override
	public Class<?> getTableClass() {
		return Promotion.class;
	}
}
