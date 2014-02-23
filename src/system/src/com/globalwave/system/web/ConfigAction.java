package com.globalwave.system.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.globalwave.base.BaseAction;
import com.globalwave.base.web.ResponseMessage;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.system.entity.ConfItem;
import com.globalwave.system.entity.ConfItemSO;
import com.globalwave.system.entity.ConfSubject;
import com.globalwave.system.entity.ConfSubjectSO;
import com.globalwave.system.service.ConfSItemBO;
import com.globalwave.system.service.ConfSubjectBO;
import com.globalwave.system.web.annotations.Pid;
import com.opensymphony.xwork2.Preparable;

@Service("system_configAction")
@Scope("prototype")
public class ConfigAction extends BaseAction implements Preparable {
	private ConfSItemBO confSItemBO;
	private ConfSubjectBO confSubjectBO;
	private ConfItemSO confItemSO;
	private ConfSubjectSO confSubjectSO;
	private ConfItem confItem;
	private ConfSubject confSubject;

	//get all subject
	@Pid(value=2050, log=false)
	public String list() throws Exception {  
        ArrayPageList<ConfSubject> pageList = confSubjectBO.query(confSubjectSO) ;
        List<String> l = new ArrayList<String>();
    	l.add("id");
    	l.add("name");
        renderList(pageList, l) ; 
        return null;  
    }
	
	//get all items for a subject
	@Pid(value=2050, log=false)
	public String items() throws Exception {  
        ArrayPageList<ConfItem> pageList = confSItemBO.query(confItemSO) ;
        /*
        List<String> l = new ArrayList<String>();
        l.add("id");
    	l.add("sub_id");
    	l.add("name");
    	l.add("ename");
    	l.add("code");*/
        renderList(pageList) ; 
        return null;  
    }

	//get a item by item's id
	@Pid(value=2050, log=false)
	public String item() throws Exception {  
		//ConfItem confItem = confSItemBO.get(confItemSO.getIds()[0]);
		ConfItem confItem = confSItemBO.get(this.id);
		/*
		List<String> l = new ArrayList<String>();
        l.add("id");
    	l.add("sub_id");
    	l.add("name");
    	l.add("ename");
    	l.add("code");*/
        renderObject(confItem, null); 
        return null;  
    }

	//create item
	@Pid(value=2050)
    public String create()  throws Exception {        
        Object newObject = confSItemBO.create(confItem) ;

    	reloadCache();
    	
    	renderObject(newObject, ResponseMessage.KEY_CREATE_OK) ;
        return null;    
    }

    //update item
	@Pid(value=2050)
    public String update()  throws Exception {    
    	//confItem.addInclusions("name");
    	//confItem.addInclusions("ename");
    	//confItem.addInclusions("code");
    	//confItem.addInclusions("sequence");
    	
    	confSItemBO.update(confItem) ;

    	reloadCache();
    	
    	renderObject(confItem, ResponseMessage.KEY_UPDATE_OK) ;
        return null;    
    }

    //remove item
	@Pid(value=2050)
    public String delete()  throws Exception {
    	if (this.ids == null) {
            confSItemBO.delete(confItem) ;
    	} else {
    		confSItemBO.delete(ids) ;
    	}
    	
    	reloadCache();
    	
        renderObject(confItem, ResponseMessage.KEY_DELETE_OK) ;
        return null;    
    }
    
	//get all items for a subject from cache
	public String get() throws Exception {  
		Map<String, Map<Object,Object>> kv = new HashMap<String, Map<Object,Object>>();
		String sid = this.getRequest().getParameter("sid");
		if (sid != null && sid.trim().length() > 0) {
			String[] sids = sid.split(",");
			for (String id : sids) {
				Map<Object,Object> result = CodeHelper.getMap(id, "name");
				if (result != null && result.size() > 0) {
					kv.put(id, result);
				}
			}
		}
		renderObject(kv, ResponseMessage.KEY_OPERATE_OK) ;
        return null;  
    }
    
	private void reloadCache() throws Exception {
		CodeHelper.reload("cfg_items") ;
		CodeHelper.reload("cfg_subject") ;
	}

	@Override
	public void prepare() throws Exception {
	}

    public ConfSItemBO getConfSItemBO() {
		return confSItemBO;
	}

	public void setConfSItemBO(ConfSItemBO confSItemBO) {
		this.confSItemBO = confSItemBO;
	}

	public ConfSubjectBO getConfSubjectBO() {
		return confSubjectBO;
	}

	public void setConfSubjectBO(ConfSubjectBO confSubjectBO) {
		this.confSubjectBO = confSubjectBO;
	}

	public ConfItemSO getConfItemSO() {
		return confItemSO;
	}

	public void setConfItemSO(ConfItemSO confItemSO) {
		this.confItemSO = confItemSO;
	}

	public ConfSubjectSO getConfSubjectSO() {
		return confSubjectSO;
	}

	public void setConfSubjectSO(ConfSubjectSO confSubjectSO) {
		this.confSubjectSO = confSubjectSO;
	}

	public ConfItem getConfItem() {
		return confItem;
	}

	public void setConfItem(ConfItem confItem) {
		this.confItem = confItem;
	}

	public ConfSubject getConfSubject() {
		return confSubject;
	}

	public void setConfSubject(ConfSubject confSubject) {
		this.confSubject = confSubject;
	}
}
