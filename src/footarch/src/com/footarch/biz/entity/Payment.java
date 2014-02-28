package com.footarch.biz.entity;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.globalwave.base.BaseEntity;
import com.globalwave.base.annotations.Versionable;

@Entity
@Table(name = "biz_order_payment")
@Versionable
public class Payment extends BaseEntity {
	@Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private Long order_id;
	private Double expected_amount;
	private Double approving_amount;
	private Double approved_amount;
	private String pay_system_name;
	private Timestamp time_pay;
	private String status;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getOrder_id() {
		return order_id;
	}
	public void setOrder_id(Long order_id) {
		this.order_id = order_id;
	}
	public Double getExpected_amount() {
		return expected_amount;
	}
	public void setExpected_amount(Double expected_amount) {
		this.expected_amount = expected_amount;
	}
	public Double getApproving_amount() {
		return approving_amount;
	}
	public void setApproving_amount(Double approving_amount) {
		this.approving_amount = approving_amount;
	}
	public Double getApproved_amount() {
		return approved_amount;
	}
	public void setApproved_amount(Double approved_amount) {
		this.approved_amount = approved_amount;
	}
	public String getPay_system_name() {
		return pay_system_name;
	}
	public void setPay_system_name(String pay_system_name) {
		this.pay_system_name = pay_system_name;
	}
	public Timestamp getTime_pay() {
		return time_pay;
	}
	public void setTime_pay(Timestamp time_pay) {
		this.time_pay = time_pay;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
