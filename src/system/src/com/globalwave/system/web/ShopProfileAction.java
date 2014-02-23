package com.globalwave.system.web;

import java.util.Map;

import com.globalwave.base.BaseAction;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.SessionUser;
import com.globalwave.system.entity.ShopProfile;
import com.globalwave.system.entity.ShopProfileCriterion;
import com.globalwave.system.entity.TerminalProfile;
import com.globalwave.system.service.ShopProfileService;
import com.opensymphony.xwork2.Preparable;

public class ShopProfileAction extends BaseAction implements Preparable {

    private static final long serialVersionUID = 8582051849254108462L;
    
    private ShopProfileService shopProfileService ;
    private ShopProfile shopProfile ;
    private Map<String, String[]> entity ;
    private ShopProfileCriterion criterion ; 

    
    public String execute() throws Exception {    
        return this.list();    
    }

    public String list() throws Exception {      
        
        ArrayPageList<ShopProfile> pageList = 
            shopProfileService.query(criterion,pageIndex,pageSize,null) ;

        renderXML(pageList.asXML()) ;
        
        return null ;    
        
    }
    public String get() throws Exception {      
        
        ShopProfile shop = shopProfileService.get(this.ids[0]) ;

        renderXML(shop.asXML()) ;
        
        return null ;    
        
    }
    
    public String create()  throws Exception {      
    	
    	shopProfile.setAttributesMap(entity) ;
        Object newShopProfile = shopProfileService.create(shopProfile) ;

        renderXML(this.getSuccessCreateMessage(newShopProfile).asXML()) ;
        
        return null;    
        
    }
    
    public String update()  throws Exception {     
        
    	shopProfile.setAttributesMap(entity) ;
        shopProfileService.update(shopProfile) ;

        renderXML(this.getSuccessUpdateMessage(shopProfile).asXML()) ;
        
        return null;    
        
    }
    
    public String delete()  throws Exception {
        if (ids == null) { 
            shopProfileService.delete(shopProfile) ;
        } else {
            shopProfileService.deleteAll(ids) ;
        }

        renderXML(this.getSuccessDeleteMessage().asXML()) ;
        
        return null;    
        
    }

    
    public String dayBegin() throws Exception {
    	

    	SessionUser suser = getSessionUser() ;
    	
    	shopProfile.setRegion_code(suser.getUser().getRegion_code()) ;
    	shopProfile.setCode_(suser.getShop_code()) ;
    	
    	ShopProfile currentShop = 
    		shopProfileService.dayBegin(shopProfile, suser.getUser()) ;
    	
    	suser.setSale_date(currentShop.getSale_date()) ;

    	getSession().removeAttribute(SessionUser.SESSION_PK) ;

        renderXML(this.getSuccessDeleteMessage().asXML()) ;
        
        return null;    
   }
    
    public String dayEnd() throws Exception {
    	

    	SessionUser suser = getSessionUser() ;
    	
    	shopProfile.setRegion_code(suser.getUser().getRegion_code()) ;
    	shopProfile.setCode_(suser.getShop_code()) ;
    	
    	ShopProfile currentShop = 
    		shopProfileService.dayEnd(shopProfile) ;

    	getSession().removeAttribute(SessionUser.SESSION_PK) ;

        renderXML(this.getSuccessDeleteMessage().asXML()) ;
        
        return null;    
   }
    
    public void prepare() throws Exception {
        // Auto-generated method stub , donothing
        
    }
    
    public void setShopProfileService(ShopProfileService shopProfileService) {
        this.shopProfileService = shopProfileService;
    }

    public ShopProfile getShopProfile() {
        return shopProfile;
    }

    public void setShopProfile(ShopProfile shopProfile) {
        this.shopProfile = shopProfile;
    }

    public ShopProfileCriterion getCriterion() {
        return criterion;
    }

    public void setCriterion(ShopProfileCriterion criterion) {
        this.criterion = criterion;
    }

	public Map<String, String[]> getEntity() {
		return entity;
	}

	public void setEntity(Map<String, String[]> entity) {
		this.entity = entity;
	}

}
