package com.globalwave.system.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.globalwave.base.BaseEntity;


@Entity
@Table(name = "CFG_TEMPLATE")
public class Template extends BaseEntity {

	final public static Long QUOTE_ID = 1L ;
	final public static Long CONFIRM_BL_ID = 2L ; 
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id ;
    
    private String code_ ;
    private String name_ ; 
    private String title_ ; 
    private String content_ ; 
    private Integer version_ ;
    private String record_status ;
    
    
    
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
	public String getName_() {
		return name_;
	}
	public void setName_(String name_) {
		this.name_ = name_;
	}
	public String getTitle_() {
		return title_;
	}
	public void setTitle_(String title_) {
		this.title_ = title_;
	}
	public String getContent_() {
		return content_;
	}
	public void setContent_(String content_) {
		this.content_ = content_;
	}
	public Integer getVersion_() {
		return version_;
	}
	public void setVersion_(Integer version_) {
		this.version_ = version_;
	}
	public String getRecord_status() {
		return record_status;
	}
	public void setRecord_status(String record_status) {
		this.record_status = record_status;
	}
    
    

}
