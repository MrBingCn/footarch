package com.globalwave.system.entity;

import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.globalwave.common.entity.AttributeBase;

@Entity
@Table(name = "cfg_Shop_Attr")
public class ShopAttribute extends AttributeBase {


    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    @GenericGenerator(name="shop_attribute_id_SEQ", strategy = "increment")
	private Long shop_attribute_id ;
	private Long shop_profile_id ;
	private String code_ ;
	private String value_ ;
	
	public Long getShop_attribute_id() {
		return shop_attribute_id;
	}
	public void setShop_attribute_id(Long shop_attribute_id) {
		this.shop_attribute_id = shop_attribute_id;
	}
	public Long getShop_profile_id() {
		return shop_profile_id;
	}
	public void setShop_profile_id(Long shop_profile_id) {
		this.shop_profile_id = shop_profile_id;
	}
	public String getCode_() {
		return code_;
	}
	public void setCode_(String code_) {
		this.code_ = code_;
	}
	public String getValue_() {
		return value_;
	}
	public void setValue_(String value_) {
		this.value_ = value_;
	}
	
	@Override
	protected AttributeBase newAttribute(Map.Entry<String, Object> entity, Long referenceId) {
		ShopAttribute attr = new ShopAttribute() ;
		attr.shop_profile_id = referenceId ;
		attr.code_ = entity.getKey() ;
		attr.value_ = String.valueOf(entity.getValue()) ;
		return attr;
	}
	
	
	
}
