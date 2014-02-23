package com.globalwave.system.web;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.globalwave.base.BaseAction;
import com.globalwave.base.web.ResponseMessage;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.system.entity.Menu;
import com.globalwave.system.entity.MenuSO;
import com.globalwave.system.service.MenuBO;
import com.globalwave.system.web.annotations.Pid;
import com.opensymphony.xwork2.Preparable;

@Service("system_menuAction")
@Scope("prototype")
public class MenuAction extends BaseAction implements Preparable {

    private static final long serialVersionUID = 7244882365197775441L;
    
    private MenuBO menuBO ;
    private Menu menu ;
    private MenuSO menuSO ; 
    
    public String execute() throws Exception {        
        
        return this.list();        
        
    }
    

    @Pid(value=151)
    public String list() throws Exception {  
        ArrayPageList<Menu> pageList = menuBO.query(menuSO) ;

        renderList(pageList) ; 
        
        return null ;  
        
    }

    @Pid(value=151)
    public String get() throws Exception {  

    	Menu org = menuBO.get(this.id) ;

    	renderObject(org, null) ; 
        return null ;  
    }

    @Pid(value=152)
    public String create()  throws Exception {        
        
        Object newMenu = menuBO.create(menu) ;

        reloadCache();
        
        renderObject(newMenu, ResponseMessage.KEY_CREATE_OK) ;
        return null;    
        
    }

    @Pid(value=153)
    public String update()  throws Exception {     
    	
        menuBO.update(menu) ;

        reloadCache();


        renderObject(menu, ResponseMessage.KEY_UPDATE_OK) ;
        
        return null;    
        
    }

    @Pid(value=154)
    public String delete()  throws Exception {

        if (this.ids == null) { 
            menuBO.delete(menu) ;
        } else {
            menuBO.deleteAll(ids) ;
        }

        reloadCache();
        
        renderObject(menu, ResponseMessage.KEY_DELETE_OK) ;
        
        return null;    
        
    }


	private void reloadCache() throws Exception {
		CodeHelper.reload("Menu") ;
		CodeHelper.reload("ProMenu") ;
	}

    public void prepare() throws Exception {
       
    }

    public void setMenuBO(MenuBO menuBO) {
		this.menuBO = menuBO;
	}

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public MenuSO getMenuSO() {
        return menuSO;
    }

    public void setMenuSO(MenuSO menuSO) {
        this.menuSO = menuSO;
    }

}
