package com.footarch.biz.entity;

import java.io.File;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.globalwave.base.BaseEntity;
import com.globalwave.base.annotations.Versionable;

/**
 * 
 * @author Administrator
 *
 */
@Entity
@Table(name = "biz_product_photo")
@Versionable
public class ProductPhoto extends BaseEntity {

	
    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
	private Long id;

	private Long product_id;
	    
	private String folder_name  ;
    private String file_uuid             ;
    private String name_        ;

    private String type_        ;
	
    private String desc_        ;
        
    private Integer order_ ;
    
    @Transient
    private File photo_file ;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Long product_id) {
		this.product_id = product_id;
	}

	public String getFolder_name() {
		return folder_name;
	}

	public void setFolder_name(String folder_name) {
		this.folder_name = folder_name;
	}

	public String getFile_uuid() {
		return file_uuid;
	}

	public void setFile_uuid(String file_uuid) {
		this.file_uuid = file_uuid;
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

	public String getDesc_() {
		return desc_;
	}

	public void setDesc_(String desc_) {
		this.desc_ = desc_;
	}

	public Integer getOrder_() {
		return order_;
	}

	public void setOrder_(Integer order_) {
		this.order_ = order_;
	}

	public File getPhoto_file() {
		return photo_file;
	}

	public void setPhoto_file(File photo_file) {
		this.photo_file = photo_file;
	}
    
	
}



