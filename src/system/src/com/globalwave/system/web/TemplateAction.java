package com.globalwave.system.web;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.globalwave.base.BaseAction;
import com.globalwave.base.web.ResponseMessage;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.Template;
import com.globalwave.system.entity.TemplateSO;
import com.globalwave.system.service.TemplateBO;
import com.globalwave.system.web.annotations.Pid;
import com.opensymphony.xwork2.Preparable;

@Service("system_templateAction")
@Scope("prototype")
public class TemplateAction extends BaseAction implements Preparable {

    private static final long serialVersionUID = 8582051849254108462L;
    
    private TemplateBO templateBO ;
    private Template template ;
    private TemplateSO templateSO ; 

    
    public String execute() throws Exception {    
        return this.list();    
    }

    @Pid(value=121, log=false)
    public String list() throws Exception {      
        
        ArrayPageList<Template> pageList = 
            templateBO.query(templateSO) ;

        renderList(pageList) ; 
        
        return null ;    
        
    }

    @Pid(value=2050)
    public String create()  throws Exception {              
        
        Object newTemplate = templateBO.create(template) ;
 
        //renderXML(this.getSuccessCreateMessage(newTemplate).asXML()) ;
        renderObject(newTemplate, ResponseMessage.KEY_CREATE_OK) ;
        
        return null;    
        
    }

    @Pid(value=2050)
    public String update()  throws Exception {     
        
        templateBO.update(template) ;

        //renderXML(this.getSuccessUpdateMessage(template).asXML()) ;
        renderObject(template, ResponseMessage.KEY_UPDATE_OK) ;
        
        return null;    
        
    }

    @Pid(value=2050)
    public String delete()  throws Exception {
        if (this.ids == null) { 
            templateBO.delete(template) ;
        } else {
            templateBO.deleteAll(this.ids) ;
        }

        //renderXML(this.getSuccessDeleteMessage().asXML()) ;
        renderObject(template, ResponseMessage.KEY_DELETE_OK) ;
        
        return null;    
        
    }
    

    
    public String get() throws Exception {     

    	Template template = templateBO.get(this.id) ;
    	
    	renderObject(template, null) ; 
        return null ;  
    }
    
    public void prepare() throws Exception {
        
    }
    
    public void setTemplateBO(TemplateBO templateService) {
        this.templateBO = templateService;
    }

    public Template getTemplate() {
        return template;
    }

    public void setTemplate(Template template) {
        this.template = template;
    }

    public TemplateSO getTemplateSO() {
        return templateSO;
    }

    public void setTemplateSO(TemplateSO templateCriterion) {
        this.templateSO = templateCriterion;
    }

}
