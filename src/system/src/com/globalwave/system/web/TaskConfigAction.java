package com.globalwave.system.web;

import java.util.HashMap;

import com.globalwave.base.BaseAction;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.scheduling.TaskScheduler;
import com.globalwave.system.entity.TaskConfig;
import com.globalwave.system.entity.TaskConfigCriterion;
import com.globalwave.system.service.TaskConfigService;
import com.opensymphony.xwork2.Preparable;

public class TaskConfigAction extends BaseAction implements Preparable {

    private static final long serialVersionUID = 8582051849254108462L;
    
    private TaskConfigService taskConfigService ;
    private TaskConfig taskConfig ;
    private TaskConfigCriterion criterion ; 

    
    public String execute() throws Exception {    
        return this.list();    
    }
    
    public String list() throws Exception {      
        
        ArrayPageList<HashMap<Object, Object>> pageList = 
            taskConfigService.query(criterion,pageIndex,pageSize,null) ;

        renderXML(pageList.asXML()) ;
        
        return null ;    
        
    }
    
    public String create()  throws Exception {              
        
        TaskConfig newTaskConfig = taskConfigService.create(taskConfig) ;

        TaskScheduler.getInstance().schedule(newTaskConfig) ;
        
        renderXML(this.getSuccessCreateMessage(newTaskConfig).asXML()) ;
        
        return null;    
        
    }
    
    public String update()  throws Exception {     
        
        taskConfigService.update(taskConfig) ;
        
        TaskScheduler.getInstance().schedule(taskConfig) ;

        renderXML(this.getSuccessUpdateMessage(taskConfig).asXML()) ;
        
        return null;    
        
    }
    
    public String delete()  throws Exception {
        if (ids == null) { 
            taskConfigService.delete(taskConfig) ;
        } else {
            taskConfigService.deleteAll(ids) ;
        }

        renderXML(this.getSuccessDeleteMessage().asXML()) ;
        
        return null;    
        
    }
    
    public String schedule() throws Exception {
    	TaskScheduler.getInstance().schedule(ids[0]) ;
        renderXML(getMessage(taskConfig,"已经成功启用！") .asXML()) ;
    	return null ;
    }
    
    public String cancel() throws Exception {
    	TaskScheduler.getInstance().cancel(ids[0]) ;
        renderXML(getMessage(taskConfig,"已经成功停用！") .asXML()) ;
    	return null ;
    }
    
    public String scheduleAll() throws Exception {
    	TaskScheduler.getInstance().scheduleAll() ;
        renderXML(getMessage(taskConfig,"已经成功启用！") .asXML()) ;
    	return null ;
    }
    
    public String cancelAll() throws Exception {
    	TaskScheduler.getInstance().cancelAll() ;
        renderXML(getMessage(taskConfig,"已经成功停用！") .asXML()) ;
    	return null ;
    }
    
    public void prepare() throws Exception {
        // Auto-generated method stub , donothing
        
    }
    
    public void setTaskConfigService(TaskConfigService taskConfigService) {
        this.taskConfigService = taskConfigService;
    }

    public TaskConfig getTaskConfig() {
        return taskConfig;
    }

    public void setTaskConfig(TaskConfig taskConfig) {
        this.taskConfig = taskConfig;
    }

    public TaskConfigCriterion getCriterion() {
        return criterion;
    }

    public void setCriterion(TaskConfigCriterion criterion) {
        this.criterion = criterion;
    }

}
