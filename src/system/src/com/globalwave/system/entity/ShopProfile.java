package com.globalwave.system.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.dom4j.Element;
import org.hibernate.annotations.GenericGenerator;

import com.globalwave.base.BaseEntity;
import com.globalwave.common.Convertor;

@Entity
@Table(name = "cfg_shop")
public class ShopProfile extends BaseEntity implements Serializable  {

	public final static String STATUS_OPEN = "O" ;
	public final static String STATUS_CLOSE = "C" ;
    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    @GenericGenerator(name="shop_profile_id_SEQ", strategy = "increment")
    private Long shop_profile_id ;
     private String region_code;
     private String code_;
     private String name_;
     private String type_;
     private String area_code;
     private String province_branch_code;
     private String province_branch_name;
     private String city_branch_code;
     private String city_branch_name;
     private String return_area_code;
     private String return_area_name;
     private String manager_class;
     private Long manager_number;
     private Timestamp establish_date;
     private Timestamp sale_date;
     private String shop_address;
     private String phone_prefix;
     private String phone_number;
     private String stock_control_flag;
     private String home_delivery_flag;
     private String status_;
     private String delivery_shop_code;
     /**
      * 1 is active / 0 is disable 
      */
     private Integer record_status ;
     
     @Transient
     private List<ShopAttribute> attributes ;
     
     
	public Long getShop_profile_id() {
		return shop_profile_id;
	}
	public void setShop_profile_id(Long shop_profile_id) {
		this.shop_profile_id = shop_profile_id;
	}
	public String getRegion_code() {
		return region_code;
	}
	public void setRegion_code(String region_code) {
		this.region_code = region_code;
	}
	public String getCode_() {
		return code_;
	}
	public void setCode_(String code_) {
		this.code_ = code_;
	}
	public String getName_() {
		return name_;
	}
	public void setName_(String name_) {
		this.name_ = name_;
	}
	public String getType_() {
		return type_;
	}
	public void setType_(String type_) {
		this.type_ = type_;
	}
	public String getArea_code() {
		return area_code;
	}
	public void setArea_code(String area_code) {
		this.area_code = area_code;
	}
	public String getProvince_branch_code() {
		return province_branch_code;
	}
	public void setProvince_branch_code(String province_branch_code) {
		this.province_branch_code = province_branch_code;
	}
	public String getProvince_branch_name() {
		return province_branch_name;
	}
	public void setProvince_branch_name(String province_branch_name) {
		this.province_branch_name = province_branch_name;
	}
	public String getCity_branch_code() {
		return city_branch_code;
	}
	public void setCity_branch_code(String city_branch_code) {
		this.city_branch_code = city_branch_code;
	}
	public String getCity_branch_name() {
		return city_branch_name;
	}
	public void setCity_branch_name(String city_branch_name) {
		this.city_branch_name = city_branch_name;
	}
	public String getReturn_area_code() {
		return return_area_code;
	}
	public void setReturn_area_code(String return_area_code) {
		this.return_area_code = return_area_code;
	}
	public String getReturn_area_name() {
		return return_area_name;
	}
	public void setReturn_area_name(String return_area_name) {
		this.return_area_name = return_area_name;
	}
	public String getManager_class() {
		return manager_class;
	}
	public void setManager_class(String manager_class) {
		this.manager_class = manager_class;
	}
	public Long getManager_number() {
		return manager_number;
	}
	public void setManager_number(Long manager_number) {
		this.manager_number = manager_number;
	}
	public Timestamp getEstablish_date() {
		return establish_date;
	}
	public void setEstablish_date(Timestamp establish_date) {
		this.establish_date = establish_date;
	}
	public Timestamp getSale_date() {
		return sale_date;
	}
	public void setSale_date(Timestamp sale_date) {
		this.sale_date = sale_date;
	}
	public String getShop_address() {
		return shop_address;
	}
	public void setShop_address(String shop_address) {
		this.shop_address = shop_address;
	}
	public String getPhone_prefix() {
		return phone_prefix;
	}
	public void setPhone_prefix(String phone_prefix) {
		this.phone_prefix = phone_prefix;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	public String getStock_control_flag() {
		return stock_control_flag;
	}
	public void setStock_control_flag(String stock_control_flag) {
		this.stock_control_flag = stock_control_flag;
	}
	public String getHome_delivery_flag() {
		return home_delivery_flag;
	}
	public void setHome_delivery_flag(String home_delivery_flag) {
		this.home_delivery_flag = home_delivery_flag;
	}
	public String getDelivery_shop_code() {
		return delivery_shop_code;
	}
	public void setDelivery_shop_code(String delivery_shop_code) {
		this.delivery_shop_code = delivery_shop_code;
	}
	public String getStatus_() {
		return status_;
	}
	public void setStatus_(String status_) {
		this.status_ = status_;
	}
	public List<ShopAttribute> getAttributes() {
		return attributes;
	}
	public void setAttributes(List<ShopAttribute> attributes) {
		this.attributes = attributes;
	}
	public Integer getRecord_status() {
		return record_status;
	}

	public void setRecord_status(Integer record_status) {
		this.record_status = record_status;
	}

	public void setAttributesMap(Map<String, String[]> entityMap) {
		if (this.attributes == null) {
			this.attributes = new ArrayList<ShopAttribute>(entityMap.size()) ;
		}
		
		for (String key:entityMap.keySet()) {
			ShopAttribute t = new ShopAttribute() ;
			this.attributes.add(t) ;
			
			t.setShop_profile_id(shop_profile_id) ;
			t.setCode_(key) ;
			t.setValue_(entityMap.get(key)[0]) ;
		}
	}
	
	public String asXML() {
		

        Element root;
		try {
			root = Convertor.object2Xml(this);
			for (ShopAttribute attr:attributes) {
				root.addElement(attr.getCode_()).addCDATA(attr.getValue_()) ;
			}
		} catch (Exception e) {
			e.printStackTrace() ;
			return null ;
		}
        
        return root.asXML() ;
	}
	
}
