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
@Table(name = "biz_promotion")
@Versionable
public class Promotion extends BaseEntity {
	@Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private String name;
	private String pro_type;
	private String catentry_id;
	private Double condition_money;
	private Long condition_quantity;
	private String discount_type;
	private Long discount_per;
	private Double discount_moeny;
	private String exclusion;
	private Long weight;
	private Timestamp begin_date;
	private Timestamp end_date;
	private String status;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPro_type() {
		return pro_type;
	}
	public void setPro_type(String pro_type) {
		this.pro_type = pro_type;
	}
	public String getCatentry_id() {
		return catentry_id;
	}
	public void setCatentry_id(String catentry_id) {
		this.catentry_id = catentry_id;
	}
	public Double getCondition_money() {
		return condition_money;
	}
	public void setCondition_money(Double condition_money) {
		this.condition_money = condition_money;
	}
	public Long getCondition_quantity() {
		return condition_quantity;
	}
	public void setCondition_quantity(Long condition_quantity) {
		this.condition_quantity = condition_quantity;
	}
	public String getDiscount_type() {
		return discount_type;
	}
	public void setDiscount_type(String discount_type) {
		this.discount_type = discount_type;
	}
	public Long getDiscount_per() {
		return discount_per;
	}
	public void setDiscount_per(Long discount_per) {
		this.discount_per = discount_per;
	}
	public Double getDiscount_moeny() {
		return discount_moeny;
	}
	public void setDiscount_moeny(Double discount_moeny) {
		this.discount_moeny = discount_moeny;
	}
	public String getExclusion() {
		return exclusion;
	}
	public void setExclusion(String exclusion) {
		this.exclusion = exclusion;
	}
	public Long getWeight() {
		return weight;
	}
	public void setWeight(Long weight) {
		this.weight = weight;
	}
	public Timestamp getBegin_date() {
		return begin_date;
	}
	public void setBegin_date(Timestamp begin_date) {
		this.begin_date = begin_date;
	}
	public Timestamp getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Timestamp end_date) {
		this.end_date = end_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

}
