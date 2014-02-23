package com.globalwave.system.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.globalwave.base.BaseAction;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.SessionUser;
import com.globalwave.system.entity.TerminalProfile;
import com.globalwave.system.entity.TerminalProfileCriterion;
import com.globalwave.system.service.TerminalProfileService;
import com.opensymphony.xwork2.Preparable;

public class TerminalProfileAction extends BaseAction implements Preparable {

    private static final long serialVersionUID = 8582051849254108462L;
    
    private TerminalProfileService terminalProfileService ;
    private TerminalProfile terminalProfile ;
    private Map<String, String[]> entity ;
    private TerminalProfileCriterion criterion ; 

    
    public String execute() throws Exception {    
        return this.list();    
    }
    
    public String list() throws Exception {      
        
        ArrayPageList<TerminalProfile> pageList = 
            terminalProfileService.query(criterion,pageIndex,pageSize,null) ;

        renderXML(pageList.asXML()) ;
        
        return null ;    
        
    }
    public String get() throws Exception {      
        
        TerminalProfile shop = terminalProfileService.get(this.ids[0]) ;

        renderXML(shop.asXML()) ;
        
        return null ;    
        
    }
    
    public String create()  throws Exception {              
        
    	terminalProfile.setAttributesMap(entity) ;
        Object newTerminalProfile = terminalProfileService.create(terminalProfile) ;

        renderXML(this.getSuccessCreateMessage(newTerminalProfile).asXML()) ;
        
        return null;    
        
    }
    
    public String update()  throws Exception {     

    	terminalProfile.setAttributesMap(entity) ;
        terminalProfileService.update(terminalProfile) ;

        renderXML(this.getSuccessUpdateMessage(terminalProfile).asXML()) ;
        
        return null;    
        
    }
    
    public String delete()  throws Exception {
        if (ids == null) { 
            terminalProfileService.delete(terminalProfile) ;
        } else {
            terminalProfileService.deleteAll(ids) ;
        }

        renderXML(this.getSuccessDeleteMessage().asXML()) ;
        
        return null;    
        
    }
    
    public String login() throws Exception {
    	
    	final HttpServletRequest request = getRequest() ;
    	
    	terminalProfile.setComputer_ip(request.getRemoteAddr()) ;//IP地址 
    	terminalProfile.setComputer_name(request.getRemoteHost()) ;//机器名      
    	//terminalProfile.setComputer_mac(request.getr)
        
    	TerminalProfile currentTerminal = 
    		terminalProfileService.dayBeginAndLogin(terminalProfile, getSessionUser().getUser()) ;

    	SessionUser suser = getSessionUser() ;
    	suser.setSale_date(currentTerminal.getSale_date()) ;
    	suser.setTerminal_code(currentTerminal.getCode_()) ;

        renderXML(this.getMessage(null, "").asXML()) ;
        
        return null;    
   }

    
    public String dayEnd() throws Exception {
    	

    	SessionUser suser = getSessionUser() ;
    	
    	terminalProfile.setRegion_code(suser.getUser().getRegion_code()) ;
    	terminalProfile.setCode_(suser.getTerminal_code()) ;
    	
    	TerminalProfile currentTerminal = 
    		terminalProfileService.dayEnd(terminalProfile) ;

    	getSession().removeAttribute(SessionUser.SESSION_PK) ;

        renderXML(this.getMessage(null, "").asXML()) ;
        
        return null;    
   }
   
    
    public void prepare() throws Exception {
        // Auto-generated method stub , donothing
        
    }
    
    public void setTerminalProfileService(TerminalProfileService terminalProfileService) {
        this.terminalProfileService = terminalProfileService;
    }

    public TerminalProfile getTerminalProfile() {
        return terminalProfile;
    }

    public void setTerminalProfile(TerminalProfile terminalProfile) {
        this.terminalProfile = terminalProfile;
    }

    public TerminalProfileCriterion getCriterion() {
        return criterion;
    }

    public void setCriterion(TerminalProfileCriterion criterion) {
        this.criterion = criterion;
    }

	public Map<String, String[]> getEntity() {
		return entity;
	}

	public void setEntity(Map<String, String[]> entity) {
		this.entity = entity;
	}

}
