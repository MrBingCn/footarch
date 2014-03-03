package com.footarch.biz.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.globalwave.base.BaseEntity;
import com.globalwave.base.annotations.Versionable;

@Entity
@Table(name = "biz_order_items")
@Versionable
public class OrderItems extends BaseEntity {
	@Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private Long order_id;
	private Long catentry_id;
	private String name;
	private Long ffmcentert_id;
	private Double list_price;
	private Double price;
	private Integer quantity;
	private Double adjustment;
	
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
	public Long getCatentry_id() {
		return catentry_id;
	}
	public void setCatentry_id(Long catentry_id) {
		this.catentry_id = catentry_id;
	}
	public Long getFfmcentert_id() {
		return ffmcentert_id;
	}
	public void setFfmcentert_id(Long ffmcentert_id) {
		this.ffmcentert_id = ffmcentert_id;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getList_price() {
		return list_price;
	}
	public void setList_price(Double list_price) {
		this.list_price = list_price;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public Double getAdjustment() {
		return adjustment;
	}
	public void setAdjustment(Double adjustment) {
		this.adjustment = adjustment;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
