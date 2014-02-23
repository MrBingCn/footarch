package com.globalwave.system.entity;


import javax.persistence.Column;

import com.globalwave.base.BaseSO;
import com.globalwave.base.annotations.Comparison;


public class TemplateSO extends BaseSO {
    
    @Comparison(operator=Comparison.EQ)
    private String code_ ;
    private String name_ ; 
    private String title_ ; 
    private Integer version_ ;
    private String record_status ;
    
    @Column(name="id")
    private Long[] ids  ;
    
    
    public void setIds(Long[] ids) {
		this.ids = ids;
	}
    public Long[] getIds() {
		return ids;
	}
	public String getCode_() {
		if (code_ == null) {
			return null ;
		}
		
		if (code_.length() == 0) {
			return null ;
		}
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
	@Override
	public Class<?> getTableClass() {
		return Template.class;
	}
}
