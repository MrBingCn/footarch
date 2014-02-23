package com.globalwave.${e.moduleName}.entity;

import javax.persistence.Column;

import com.globalwave.base.annotations.Comparison;

public class ${e.className}SO extends BaseSO {

   <#list g.getEditForm().getFields() as f>
     <#if f.getIs_primary_key() == 1>    
    @Column(name="${f.code_}")
     </#if>
   </#list>
    private Long[] ids ; 

    public Long[] getIds() {
        return ids;
    }
    public void setIds(Long[] ids) {
        this.ids = ids;
    }
    
    
}
