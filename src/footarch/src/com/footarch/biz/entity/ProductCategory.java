package com.footarch.biz.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.globalwave.base.BaseEntity;
import com.globalwave.base.annotations.Versionable;

/**
 * 
 * @author Administrator
 *
 */
@Entity
@Table(name = "biz_product_category")
@Versionable
public class ProductCategory extends BaseEntity {
	
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
    
	private Long pro_product_category_id;

    private String name_cn              ;
    private String name_en              ;
    private String keywords_            ;
    private String desc_                ;
    private String record_status        ;
    private Integer order_ ;
    private Integer is_show ;
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName_cn() {
		return name_cn;
	}
	public void setName_cn(String name_cn) {
		this.name_cn = name_cn;
	}
	public String getName_en() {
		return name_en;
	}
	public void setName_en(String name_en) {
		this.name_en = name_en;
	}
	public String getKeywords_() {
		return keywords_;
	}
	public void setKeywords_(String keywords_) {
		this.keywords_ = keywords_;
	}
	public String getDesc_() {
		return desc_;
	}
	public void setDesc_(String desc_) {
		this.desc_ = desc_;
	}
	public String getRecord_status() {
		return record_status;
	}
	public void setRecord_status(String record_status) {
		this.record_status = record_status;
	}
	public Integer getOrder_() {
		return order_;
	}
	public void setOrder_(Integer order_) {
		this.order_ = order_;
	}
	public Integer getIs_show() {
		return is_show;
	}
	public void setIs_show(Integer is_show) {
		this.is_show = is_show;
	}
	public Long getPro_product_category_id() {
		return pro_product_category_id;
	}
	public void setPro_product_category_id(Long pro_product_category_id) {
		this.pro_product_category_id = pro_product_category_id;
	}
	
}



