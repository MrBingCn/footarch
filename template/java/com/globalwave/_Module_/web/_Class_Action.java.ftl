package com.globalwave.${e.moduleName}.web;

import com.globalwave.base.BaseAction;
import com.globalwave.common.ArrayPageList;
import com.globalwave.${e.moduleName}.entity.${e.className};
import com.globalwave.${e.moduleName}.entity.${e.className}SO;
import com.globalwave.${e.moduleName}.service.${e.className}BO;
import com.opensymphony.xwork2.Preparable;

@Service("${e.moduleName}_${e.entityName}Action")
@Scope("prototype")
public class ${e.className}Action extends BaseAction implements Preparable {

    private static final long serialVersionUID = 8582051849254108462L;
    
    private ${e.className}BO ${e.entityName}BO ;
    private ${e.className} ${e.entityName} ;
    private ${e.className}SO so ; 

    
    public String execute() throws Exception {    
        return this.list();    
    }
    
    @Pid(value=-1)
    public String list() throws Exception {      
        
        ArrayPageList<${e.className}> pageList = 
            ${e.entityName}BO.query(so,pageIndex,pageSize,null) ;

        renderXML(pageList.asXML()) ;
        
        return null ;    
        
    }
    
    @Pid(value=-1)
    public String create()  throws Exception {              
        
        Object new${e.className} = ${e.entityName}BO.create(${e.entityName}) ;

        renderXML(this.getSuccessCreateMessage(new${e.className}).asXML()) ;
        
        return null;    
        
    }
    
    @Pid(value=-1)
    public String update()  throws Exception {     
        
        ${e.entityName}BO.update(${e.entityName}) ;

        renderXML(this.getSuccessUpdateMessage(${e.entityName}).asXML()) ;
        
        return null;    
        
    }
    
    @Pid(value=-1)
    public String delete()  throws Exception {
        if (ids == null) { 
            ${e.entityName}BO.delete(${e.entityName}) ;
        } else {
            ${e.entityName}BO.deleteAll(ids) ;
        }

        renderXML(this.getSuccessDeleteMessage().asXML()) ;
        
        return null;    
        
    }
    
    public void prepare() throws Exception {
        // Auto-generated method stub , donothing
        
    }
    
    public void set${e.className}BO(${e.className}BO ${e.entityName}BO) {
        this.${e.entityName}BO = ${e.entityName}BO;
    }

    public ${e.className} get${e.className}() {
        return ${e.entityName};
    }

    public void set${e.className}(${e.className} ${e.entityName}) {
        this.${e.entityName} = ${e.entityName};
    }

    public ${e.className}SO getSo() {
        return so;
    }

    public void setSo(${e.className}SO so) {
        this.so = so;
    }

}
