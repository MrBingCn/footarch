package com.globalwave.system.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.common.exception.BusinessException;
import com.globalwave.system.entity.Menu;
import com.globalwave.system.entity.MenuSO;
import com.globalwave.system.entity.SessionUser;


@Service("menuBO")
@Scope("prototype")
@Transactional
public class MenuBO extends BaseServiceImpl {

    public Menu create(Menu menu) {  

    	Long pid = menu.getPro_menu_id() ;
    	if (pid != null && lock(pid) == 0) {
    		throw new BusinessException(1301L) ;//1301', '父菜单不存在，本操作无效！
    	}
    	
    	if (pid == null) {
    		menu.setLevel_(2) ;
    		menu.setPro_menu_id(0L) ;
    	} else {
    		menu.setLevel_(3) ;
    	}
    	
        Menu newItem = (Menu) jdbcDao.insert(menu) ;
        
        return newItem;
    }
    
    public void update(Menu menu) {

    	lock(menu.getPro_menu_id()) ;

    	menu.addExclusions("level_") ;
    	menu.addExclusions("pro_menu_id") ;
    	
        jdbcDao.update(menu) ;
    }

    public void delete(Menu menu) {

    	lock(menu.getPro_menu_id()) ;
    	
    	if (hasChildren(menu.getId())) {
    		throw new BusinessException(1302L) ;// 1302', '子菜单存在，本操作无效！' );
    	}
    	
        jdbcDao.delete(menu) ;
        
    }

    public void deleteAll(Long[] menuIds) {
    	
    	for (Long oId:menuIds) {
        	if (hasChildren(oId)) {
        		throw new BusinessException(1302L) ;// 1302', '子菜单存在，本操作无效！' );
        	}
    	}
    	
        MenuSO criterion = new MenuSO() ;
        criterion.setIds(menuIds) ;
        jdbcDao.delete(Menu.class, criterion) ;
        
    }
    
    private boolean hasChildren(Long menuId) {
    	Menu so = new Menu() ;
    	so.setPro_menu_id(menuId) ;
    	return jdbcDao.find(so) != null ;
    }

    private int lock(Long menuId) {
    	if (menuId == null) {
    		return 0;
    	}
    	
    	Menu o = new Menu() ;
    	o.setOperate(Menu.OPERATE_UPDATE_UNVERSION) ;
    	o.setId(menuId) ;
    	o.addInclusions("id") ;
    	
    	return jdbcDao.update(o) ;
    }
    
    public ArrayPageList<Menu> query(MenuSO menuSO) {

        if (menuSO == null) {
        	menuSO = new MenuSO() ;
        }
        menuSO.addAsc("pro_menu_id") ;
        menuSO.addAsc("order_") ;
        menuSO.addAsc("label") ;
        
        return (ArrayPageList<Menu>)jdbcDao.query(menuSO, Menu.class);
    }

    public static List<HashMap<String, Object>> getUserMenu(SessionUser sUser) {
    	
    	if (sUser == null) {
    		return null ;
    	}
    	
    	List<HashMap<String, Object>> result = (List<HashMap<String, Object>>)CodeHelper.query("Menu", HashMap.class) ;
    	for (int i = result.size() - 1 ; i >= 0 ; i --) {
    		HashMap<String, Object> e = result.get(i) ;
    		if (3 != (Short)e.get("level_")) {
    			continue ;
    		}
    		if (!sUser.hasPrivilege((Short)e.get("pid"))){
    			result.remove(i);
    		}
    	}
    	HashMap<String, Object> first = new HashMap<String, Object>() ;
    	first.put("id", 0L) ;
    	first.put("pro_menu_id", null) ;
    	first.put("level_", 1) ;
    	result.add(0, first) ;
    	return result ;
    }


    public Menu get(Long id) {  
    	Menu org = new Menu() ;
    	org.setId(id) ;
        org = (Menu) jdbcDao.get(org) ;
        
        
        return org;
    }
    
}
