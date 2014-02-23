package com.globalwave.system.entity;

import javax.persistence.Column;

//import com.globalwave.base.annotations.Comparison;

public class TaskLogCriterion {
    public final static String SQL_STRING = "" ; 

    @Column(name="task_log_id")
    private Long[] ids ; 

    private Long task_config_id ;
    private Long task_log_id ;
    public Long[] getIds() {
        return ids;
    }
    public void setIds(Long[] ids) {
        this.ids = ids;
    }
	public Long getTask_config_id() {
		return task_config_id;
	}
	public void setTask_config_id(Long task_config_id) {
		this.task_config_id = task_config_id;
	}
	public Long getTask_log_id() {
		return task_log_id;
	}
	public void setTask_log_id(Long task_log_id) {
		this.task_log_id = task_log_id;
	}
    
    
}
