package com.globalwave.system.entity;

import javax.persistence.Column;

import com.globalwave.base.annotations.Comparison;

public class ShopProfileCriterion {
    public final static String SQL_STRING = "" ; 

    @Column(name="id")
    private Long[] ids ; 

    public Long[] getIds() {
        return ids;
    }
    public void setIds(Long[] ids) {
        this.ids = ids;
    }
    
    
}
