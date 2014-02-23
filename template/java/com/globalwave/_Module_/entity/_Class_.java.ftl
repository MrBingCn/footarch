package com.globalwave.${e.moduleName}.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.globalwave.base.BaseEntity;

@Entity
@Table(name = "${g.editForm.view.table_name}")
public class ${e.className} extends BaseEntity implements Serializable  {

   <#list g.getEditForm().getFields() as f>
     <#if f.getIs_primary_key() == 1>    
    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    @GenericGenerator(name="${f.code_}_SEQ", strategy = "increment")
    private Long ${f.code_} ;
     <#else>
     private <#if f.getType_() == 4>Integer<#elseif f.getType_() == -5>Long<#elseif f.getType_() == 8>Double<#elseif f.getType_() == 93>Timestamp<#elseif f.getType_() == 91>Date<#else>String</#if> ${f.code_};
     </#if>
   </#list>                         
	
}
