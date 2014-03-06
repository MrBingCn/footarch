package com.footarch.biz.entity;

import javax.persistence.Column;

import com.globalwave.base.BaseSO;

public class PaymentSO extends BaseSO {
    @Column(name="id")
    private Long[] ids ;
    private Long order_id;
    private String status;

    public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public Long getOrder_id() {
		return order_id;
	}

	public void setOrder_id(Long order_id) {
		this.order_id = order_id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public Class<?> getTableClass() {
		return Payment.class;
	}
}
