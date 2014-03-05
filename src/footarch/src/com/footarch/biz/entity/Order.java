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
@Table(name = "biz_order")
@Versionable
public class Order extends BaseEntity {
	@Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private Long user_id;
	private Long address_id;
	private Timestamp time_place;//'提交订单时间'
	private Timestamp time_pay;// '支付时间'
	private Timestamp time_checkout;//'出账时间'
	
	private Double total_product;//'商品总金额'
	private Double ship;//'运费金额'
	private Double adjustment_product;
	private Double adjustment_ship;
	private Double adjustment_order;
	private Double adjustment_manual;
	private Double total;//'整单总金额'
	private String comments;
	private String remark;
	private String payment_type;//'付款类型:线上支付（0），线下支付（1）'
	private String status;//'订单状态: 购物车（P）,已提交（M）,已支付（C），已打包（A），已发货（D），已取消（X）'
	private String status_payment;//'支付状态:未支付（0），已支付（1）'
	private String status_checkout;//'出账状态:未出帐（0），可出帐（1），已出帐（2）'
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public Long getAddress_id() {
		return address_id;
	}
	public void setAddress_id(Long address_id) {
		this.address_id = address_id;
	}
	public Timestamp getTime_place() {
		return time_place;
	}
	public void setTime_place(Timestamp time_place) {
		this.time_place = time_place;
	}
	public Timestamp getTime_pay() {
		return time_pay;
	}
	public void setTime_pay(Timestamp time_pay) {
		this.time_pay = time_pay;
	}
	public Timestamp getTime_checkout() {
		return time_checkout;
	}
	public void setTime_checkout(Timestamp time_checkout) {
		this.time_checkout = time_checkout;
	}
	public Double getTotal_product() {
		return total_product;
	}
	public void setTotal_product(Double total_product) {
		this.total_product = total_product;
	}
	public Double getShip() {
		return ship;
	}
	public void setShip(Double ship) {
		this.ship = ship;
	}
	public Double getAdjustment_product() {
		return adjustment_product;
	}
	public void setAdjustment_product(Double adjustment_product) {
		this.adjustment_product = adjustment_product;
	}
	public Double getAdjustment_ship() {
		return adjustment_ship;
	}
	public void setAdjustment_ship(Double adjustment_ship) {
		this.adjustment_ship = adjustment_ship;
	}
	public Double getAdjustment_order() {
		return adjustment_order;
	}
	public void setAdjustment_order(Double adjustment_order) {
		this.adjustment_order = adjustment_order;
	}
	public Double getAdjustment_manual() {
		return adjustment_manual;
	}
	public void setAdjustment_manual(Double adjustment_manual) {
		this.adjustment_manual = adjustment_manual;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Double getTotal() {
		return total;
	}
	public void setTotal(Double total) {
		this.total = total;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getPayment_type() {
		return payment_type;
	}
	public void setPayment_type(String payment_type) {
		this.payment_type = payment_type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatus_payment() {
		return status_payment;
	}
	public void setStatus_payment(String status_payment) {
		this.status_payment = status_payment;
	}
	public String getStatus_checkout() {
		return status_checkout;
	}
	public void setStatus_checkout(String status_checkout) {
		this.status_checkout = status_checkout;
	}
}
