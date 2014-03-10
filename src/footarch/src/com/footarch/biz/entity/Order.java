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
	private String pay_system_name;
	private String status;//'订单状态: 购物车（P）,已提交（M）,已支付（C），已打包（A），已发货（D），已取消（X）'
	private String status_payment;//'支付状态:未支付（0），已支付（1）'
	private String status_checkout;//'出账状态:未出帐（0），可出帐（1），已出帐（2）'
	
	private int order_agent_level ; //'下订单的代理等级，0:台湾工厂，1:省级代理，2:市级代理，3:区级代理，4:终端代理，5:预留代理',
	private double ar_amount_0 ;//'零级代理/台湾工厂的 应收金额',

	private long agent_id_1 ;//'一级代理/省级代理 的 id',
	private double ar_amount_1 ; //'一级代理/省级代理 的 应收金额',
	
	private long agent_id_2;//'二级代理/市级代理 的 id',
	private double ar_amount_2 ; // '二级代理/市级代理 的 应收金额',
	
	private long agent_id_3 ;//'三级代理/区级代理 的 id',
	private double ar_amount_3 ; //'三级代理/区级代理 的 应收金额',

	private long agent_id_4 ;//'四级代理/终端代理 的 id',
	private double ar_amount_4 ; //'四级代理/终端代理 的 应收金额',
	
	private long agent_id_5 ;//'五级代理/预留代理 的 id',
	private double ar_amount_5 ; //'五级代理/预留代理 的 应收金额',

	private long sale_id     ;// '销售员，预留，用于提成，出报表',
	private String sale_name ;// '销售员，预留，用于提成，出报表',
	private double commission ;//  decimal(12,2) default 0.00 not null comment '佣金；回扣',
	
	
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
	public String getPay_system_name() {
		return pay_system_name;
	}
	public void setPay_system_name(String pay_system_name) {
		this.pay_system_name = pay_system_name;
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
	public int getOrder_agent_level() {
		return order_agent_level;
	}
	public void setOrder_agent_level(int order_agent_level) {
		this.order_agent_level = order_agent_level;
	}
	public double getAr_amount_0() {
		return ar_amount_0;
	}
	public void setAr_amount_0(double ar_amount_0) {
		this.ar_amount_0 = ar_amount_0;
	}
	public long getAgent_id_1() {
		return agent_id_1;
	}
	public void setAgent_id_1(long agent_id_1) {
		this.agent_id_1 = agent_id_1;
	}
	public double getAr_amount_1() {
		return ar_amount_1;
	}
	public void setAr_amount_1(double ar_amount_1) {
		this.ar_amount_1 = ar_amount_1;
	}
	public long getAgent_id_2() {
		return agent_id_2;
	}
	public void setAgent_id_2(long agent_id_2) {
		this.agent_id_2 = agent_id_2;
	}
	public double getAr_amount_2() {
		return ar_amount_2;
	}
	public void setAr_amount_2(double ar_amount_2) {
		this.ar_amount_2 = ar_amount_2;
	}
	public long getAgent_id_3() {
		return agent_id_3;
	}
	public void setAgent_id_3(long agent_id_3) {
		this.agent_id_3 = agent_id_3;
	}
	public double getAr_amount_3() {
		return ar_amount_3;
	}
	public void setAr_amount_3(double ar_amount_3) {
		this.ar_amount_3 = ar_amount_3;
	}
	public long getAgent_id_4() {
		return agent_id_4;
	}
	public void setAgent_id_4(long agent_id_4) {
		this.agent_id_4 = agent_id_4;
	}
	public double getAr_amount_4() {
		return ar_amount_4;
	}
	public void setAr_amount_4(double ar_amount_4) {
		this.ar_amount_4 = ar_amount_4;
	}
	public long getAgent_id_5() {
		return agent_id_5;
	}
	public void setAgent_id_5(long agent_id_5) {
		this.agent_id_5 = agent_id_5;
	}
	public double getAr_amount_5() {
		return ar_amount_5;
	}
	public void setAr_amount_5(double ar_amount_5) {
		this.ar_amount_5 = ar_amount_5;
	}
	public long getSale_id() {
		return sale_id;
	}
	public void setSale_id(long sale_id) {
		this.sale_id = sale_id;
	}
	public String getSale_name() {
		return sale_name;
	}
	public void setSale_name(String sale_name) {
		this.sale_name = sale_name;
	}
	public double getCommission() {
		return commission;
	}
	public void setCommission(double commission) {
		this.commission = commission;
	}
}
