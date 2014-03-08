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
    private String document_name        ;

    private String document_type        ;
	
    private String desc_        ;
    
    private String record_status        ;
    
    private Integer order_ ;

    @Transient
    private File document_file ;
    
    @Transient
    private String product_uuids ;
    
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
	public Long getBiz_id() {
		return product_id;
	}
	public void setBiz_id(Long product_id) {
		this.product_id = product_id;
	}
	public String getFile_uuid() {
		return file_uuid;
	}
	public void setFile_uuid(String file_uid) {
		this.file_uuid = file_uid;
	}
	public String getDocument_name() {
		return document_name;
	}
	public void setDocument_name(String document_name) {
		this.document_name = document_name;
	}
	public String getDocument_type() {
		return document_type;
	}
	public void setDocument_type(String document_type) {
		this.document_type = document_type;
	}
	public String getFolder_name() {
		return folder_name;
	}
	public void setFolder_name(String folder_name) {
		this.folder_name = folder_name;
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
	public File getDocument_file() {
		return document_file;
	}
	public void setDocument_file(File document_file) {
		this.document_file = document_file;
	}
	public String getProduct_uuids() {
		return product_uuids;
	}
	public void setProduct_uuids(String product_uuid) {
		this.product_uuids = product_uuid;
	}
	
}



