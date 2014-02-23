package com.globalwave.system.web;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.globalwave.base.BaseAction;
import com.globalwave.base.web.ResponseMessage;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.MarkIt;
import com.globalwave.system.entity.MarkItSO;
import com.globalwave.system.service.MarkItBO;
import com.globalwave.system.web.annotations.Pid;
import com.opensymphony.xwork2.Preparable;

@Service("system_markItAction")
@Scope("prototype")
public class MarkItAction extends BaseAction implements Preparable {
   
    private static final long serialVersionUID = 1L;

    private MarkItBO markItBO = null ;

    private MarkIt markIt ;
    private MarkItSO markItSO ;
    
    public String execute() throws Exception {
        return this.list();    
        
    }
    
    public String edit() throws Exception {
    	return "jsp";
    }

    public String list() throws Exception {        
        
        ArrayPageList<MarkIt> pageList = markItBO.query(markItSO) ;

        renderList(pageList) ;
        
        return null ;    
        
    }


    public String get() throws Exception {
    	
    	renderObject(this.markItBO.get(this.id), null) ; 
    	
        return null ;  
    	
    }
    
    
    
    @Pid(value=1071)
    public String create()  throws Exception {        
                
        final Object newMarkIt = markItBO.create(markIt) ;
        
        renderObject(newMarkIt, ResponseMessage.KEY_CREATE_OK) ;
        
        return null;    
        
    }
    
    @Pid(value=1071)
    public String update()  throws Exception {     
        
        markItBO.update(markIt) ;
        
        renderObject(markIt, ResponseMessage.KEY_UPDATE_OK) ;
        
        return null;    
        
    }
    
    @Pid(value=1071)
    public String save()  throws Exception {     
        
        markItBO.save(this.markIt) ;

        renderObject(markIt, ResponseMessage.KEY_UPDATE_OK) ;
        
        return null;    
        
    }
    
    @Pid(value=1071)
    public String delete()  throws Exception {
        
        if (ids == null) {
            markItBO.delete(markIt) ;
        } else {
            markItBO.deleteAll(ids) ;
        }
        
        renderObject(markIt, ResponseMessage.KEY_DELETE_OK) ;
        
        
        return null;    
        
    }

    
    public void prepare() throws Exception {

    }
        
    // ------------------------------------------------------------------------
    
    // ioc
    public void setMarkItBO(MarkItBO markItService) {
        this.markItBO = markItService;
    }

    // entity...
    public MarkIt getMarkIt() {
        return markIt;
    }

    public void setMarkIt(MarkIt markIt) {
        this.markIt = markIt;
    }


	public MarkItSO getMarkItSO() {
		return markItSO;
	}

	public void setMarkItSO(MarkItSO markItSO) {
		this.markItSO = markItSO;
	}

}
