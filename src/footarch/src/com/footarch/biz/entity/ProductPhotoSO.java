package com.footarch.biz.entity;

import javax.persistence.Column;

import com.globalwave.base.BaseSO;
import com.globalwave.base.annotations.Comparison;


public class ProductPhotoSO extends BaseSO {

    @Column(name="id")
    private Long[] ids ;

    private Long product_id ;

    private String name_cn ;
    
    @Comparison(operator=Comparison.EQ)
    private String desc_ ;

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


	public Long getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Long product_id) {
		this.product_id = product_id;
	}

	public String getDesc_() {
		return desc_;
	}

	public void setDesc_(String desc_) {
		this.desc_ = desc_;
	}

	@Override
	public Class<?> getTableClass() {
		return ProductPhoto.class;
	}
	
}
