package com.globalwave.system.entity;

import javax.persistence.Column;

//import com.globalwave.base.annotations.Comparison;

public class TaskConfigCriterion {
    public final static String CONFIG_QUERY_SQL_STRING = 
    	    "select c.*, l.task_status as running_status," +
    		"       l.start_on, l.end_on" +
    		"  from sys_task_config c left join sys_task_log l" +
    		"    on c.last_task_log_id=l.task_log_id" ; 

    @Column(name="task_config_id")
    private Long[] ids ; 
    private Long task_config_id ; 
    private String task_status;
    private String code_ ;
    private String name_ ;

    public Long[] getIds() {
        return ids;
    }
    public void setIds(Long[] ids) {
        this.ids = ids;
    }
	public String getTask_status() {
		return task_status;
	}
	public void setTask_status(String task_status) {
		this.task_status = task_status;
	}
	public Long getTask_config_id() {
		return task_config_id;
	}
	public void setTask_config_id(Long task_config_id) {
		this.task_config_id = task_config_id;
	}
	public String getCode_() {
		return code_;
	}
	public void setCode_(String code_) {
		this.code_ = code_;
	}
	public String getName_() {
		return name_;
	}
	public void setName_(String name_) {
		this.name_ = name_;
	}
    
    
}
