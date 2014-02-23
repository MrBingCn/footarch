package com.globalwave.system.web;

import com.globalwave.base.BaseAction;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.TaskLog;
import com.globalwave.system.entity.TaskLogCriterion;
import com.globalwave.system.service.TaskLogService;
import com.opensymphony.xwork2.Preparable;

public class TaskLogAction extends BaseAction implements Preparable {

    private static final long serialVersionUID = 8582051849254108462L;
    
    private TaskLogService taskLogService ;
    private TaskLog taskLog ;
    private TaskLogCriterion criterion ; 

    
    public String execute() throws Exception {    
        return this.list();    
    }
    
    public String list() throws Exception {      
        
    	pageSize = 10 ;
    	
        ArrayPageList<TaskLog> pageList = 
            taskLogService.query(criterion,pageIndex,pageSize,null) ;

        renderXML(pageList.asXML()) ;
        
        return null ;    
        
    }
    
    public String create()  throws Exception {              
        
        Object newTaskLog = taskLogService.create(taskLog) ;

        renderXML(this.getSuccessCreateMessage(newTaskLog).asXML()) ;
        
        return null;    
        
    }
    
    public String update()  throws Exception {     
        
        taskLogService.update(taskLog) ;

        renderXML(this.getSuccessUpdateMessage(taskLog).asXML()) ;
        
        return null;    
        
    }
    
    public String delete()  throws Exception {
        if (ids == null) { 
            taskLogService.delete(taskLog) ;
        } else {
            taskLogService.deleteAll(ids) ;
        }

        renderXML(this.getSuccessDeleteMessage().asXML()) ;
        
        return null;    
        
    }

    public String cancel()  throws Exception {     
        
        taskLogService.cancel(ids) ;

        //renderXML(this.getSuccessUpdateMessage(taskLog).asXML()) ;
        renderXML(getMessage(null ,"已经成功发送中止运行讯号！") .asXML()) ;
        
        return null;    
        
    }
    
    public String trash()  throws Exception {     
        
        taskLogService.trash(ids) ;

        //renderXML(this.getSuccessUpdateMessage(taskLog).asXML()) ;
        renderXML(getMessage(null ,"已经成功废弃任务！") .asXML()) ;
        
        return null;    
        
    }
    
    
    
    public void prepare() throws Exception {
        // Auto-generated method stub , donothing
        
    }
    
    public void setTaskLogService(TaskLogService taskLogService) {
        this.taskLogService = taskLogService;
    }

    public TaskLog getTaskLog() {
        return taskLog;
    }

    public void setTaskLog(TaskLog taskLog) {
        this.taskLog = taskLog;
    }

    public TaskLogCriterion getCriterion() {
        return criterion;
    }

    public void setCriterion(TaskLogCriterion criterion) {
        this.criterion = criterion;
    }

}
