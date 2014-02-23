package com.globalwave.system.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.exception.BusinessException;
import com.globalwave.system.entity.Template;
import com.globalwave.system.entity.TemplateSO;

@Service("templateBO")
@Scope("prototype")
@Transactional
public class TemplateBO extends BaseServiceImpl {

    @SuppressWarnings("unchecked")
    public ArrayPageList<Template> query(TemplateSO templateSO) {
    	
        if (templateSO == null) {
    		templateSO = new TemplateSO() ;
    	}
    	
		templateSO.addAsc("record_status") ;
		templateSO.addAsc("name_") ;
		templateSO.addAsc("version_") ;
	
        return (ArrayPageList<Template>)jdbcDao.query(templateSO, Template.class);
    }

    private void checkTemplateExisted(Template template) {
    	if (this.isTemplateExisted(template.getCode_())){
    		throw new BusinessException(102L, template.getCode_()) ;//102', '编码已经被使用，保存失败，请使用其它编码后再进行保存！！
    	}
    }
    
    private boolean isTemplateExisted(String code) {
    	Template template = new Template() ;
    	template.setCode_(code) ;
    	
        return jdbcDao.find(template) != null;
        
    }

    public Template create(Template template) { 
    	checkTemplateExisted(template) ;
        final Template newTemplate = (Template) jdbcDao.insert(template) ;
                
        return newTemplate;
    }

    public void update(Template template) {        
    	Template old = (Template)this.jdbcDao.get(template) ;
    	
    	if (!old.getCode_().equals(template.getCode_())) {
        	checkTemplateExisted(template) ;
    	}
    	
        jdbcDao.update(template);
    }

    public void delete(Template template) {
        
        jdbcDao.delete(template) ;
        
    }

    public void deleteAll(Long[] ids) {
        
        TemplateSO so = new TemplateSO() ;
        so.setIds(ids) ;

        jdbcDao.delete(Template.class, so) ;
        
    }

    public Template get(Long template_id) {
        Template template = new Template() ;
        template.setId(template_id) ;
        
        return (Template)jdbcDao.get(template) ;
    }


}
