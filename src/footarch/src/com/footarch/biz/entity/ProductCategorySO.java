package com.footarch.biz.entity;

import javax.persistence.Column;

import com.globalwave.base.BaseSO;


public class ProductCategorySO extends BaseSO {

    @Column(name="id")
    private Long[] ids ;

    private String name_cn ;

    private String record_status        ;
    
    public String getName_cn() {
    	if (name_cn == null) {
    		return null;
    	}
    	
    	if (name_cn.trim().equals("")) {
    		return null ;
    	}
    	
		return name_cn;
	}
    
    public void setName_cn(String name_) {
		this.name_cn = name_;
	}
    
    
	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}
	
	
	public String getRecord_status() {
		return record_status;
	}

	public void setRecord_status(String record_status) {
		this.record_status = record_status;
	}

	@Override
	public Class<?> getTableClass() {
		return ProductCategory.class;
	}
	
}
