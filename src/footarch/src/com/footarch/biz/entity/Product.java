package com.footarch.biz.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.globalwave.base.BaseEntity;
import com.globalwave.base.annotations.Comparison;
import com.globalwave.base.annotations.Versionable;

@Entity
@Table(name = "biz_product")
@Versionable
public class Product extends BaseEntity {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;

    private Long pro_product_id ;
    private Long product_category_id  ;
    private String brand_id  ;
    private String code_                ;
    private String name_cn              ;
    private String name_en              ;
    private String short_desc              ;
    private String full_desc              ;
    private String keywords_              ;
    private String main_photo_uuid              ;
    private Integer click_count ;
    
    private Double weight_ ;
    private Double market_price ;
    private Double selling_price ;
    private Double promote_price ;

    private Timestamp promote_start_on ;
    private Timestamp promote_end_on ;
    
    //private Integer order_ ;
    
    @Comparison(operator=Comparison.EQ)
    private String color_ ;
    @Comparison(operator=Comparison.EQ)
    private String size_;

    @Comparison(operator=Comparison.EQ)
    private String record_status        ;

    
    @Transient
    private List<Product> colors ;
    
    @Transient
    private List<Product> sizes ;

    @Transient
    private List<ProductPhoto> productPhotoes;
    
    @Transient
    private Product pro_product ;
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCode_() {
		return code_;
	}
	public void setCode_(String code_) {
		this.code_ = code_;
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
	public String getRecord_status() {
		return record_status;
	}
	public void setRecord_status(String record_status) {
		this.record_status = record_status;
	}

	public Long getProduct_category_id() {
		return product_category_id;
	}
	public void setProduct_category_id(Long product_category_id) {
		this.product_category_id = product_category_id;
	}
	public String getBrand_id() {
		return brand_id;
	}
	public void setBrand_id(String brand_id) {
		this.brand_id = brand_id;
	}
	public String getShort_desc() {
		return short_desc;
	}
	public void setShort_desc(String short_desc) {
		this.short_desc = short_desc;
	}
	public String getFull_desc() {
		return full_desc;
	}
	public void setFull_desc(String full_desc) {
		this.full_desc = full_desc;
	}
	public String getKeywords_() {
		return keywords_;
	}
	public void setKeywords_(String keywords_) {
		this.keywords_ = keywords_;
	}
	public String getMain_photo_uuid() {
		return main_photo_uuid;
	}
	public void setMain_photo_uuid(String main_photo_uuid) {
		this.main_photo_uuid = main_photo_uuid;
	}
	public Integer getClick_count() {
		return click_count;
	}
	public void setClick_count(Integer click_count) {
		this.click_count = click_count;
	}
	public Double getWeight_() {
		return weight_;
	}
	public void setWeight_(Double weight_) {
		this.weight_ = weight_;
	}
	public Double getMarket_price() {
		return market_price;
	}
	public void setMarket_price(Double market_price) {
		this.market_price = market_price;
	}
	public Double getSelling_price() {
		return selling_price;
	}
	public void setSelling_price(Double selling_price) {
		this.selling_price = selling_price;
	}
	public Double getPromote_price() {
		return promote_price;
	}
	public void setPromote_price(Double promote_price) {
		this.promote_price = promote_price;
	}
	public Timestamp getPromote_start_on() {
		return promote_start_on;
	}
	public void setPromote_start_on(Timestamp promote_start_on) {
		this.promote_start_on = promote_start_on;
	}
	public Timestamp getPromote_end_on() {
		return promote_end_on;
	}
	public void setPromote_end_on(Timestamp promote_end_on) {
		this.promote_end_on = promote_end_on;
	}
	public Long getPro_product_id() {
		return pro_product_id;
	}
	public void setPro_product_id(Long pro_product_id) {
		this.pro_product_id = pro_product_id;
	}
	public String getColor_() {
		return color_;
	}
	public void setColor_(String color_) {
		this.color_ = color_;
	}
	public String getSize_() {
		return size_;
	}
	public void setSize_(String size_) {
		this.size_ = size_;
	}
	public List<Product> getColors() {
		return colors;
	}
	public void setColors(List<Product> colors) {
		this.colors = colors;
	}
	public List<Product> getSizes() {
		return sizes;
	}
	public void setSizes(List<Product> sizes) {
		this.sizes = sizes;
	}
	public Product getPro_product() {
		return pro_product;
	}
	public void setPro_product(Product pro_product) {
		this.pro_product = pro_product;
	}
	public List<ProductPhoto> getProductPhotoes() {
		return productPhotoes;
	}
	public void setProductPhotoes(List<ProductPhoto> productPhotoes) {
		this.productPhotoes = productPhotoes;
	}
	
	
}



