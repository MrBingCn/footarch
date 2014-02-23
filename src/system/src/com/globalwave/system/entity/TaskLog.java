package com.globalwave.system.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.globalwave.base.BaseEntity;

@Entity
@Table(name = "sys_task_log")
public class TaskLog extends BaseEntity implements Serializable  {

	final public static String TASK_STATUS_RUNNING = "R" ;
	final public static String TASK_STATUS_SUCCESS = "S" ;
	final public static String TASK_STATUS_FAIL = "F" ;
	final public static String TASK_STATUS_CANCELED = "C" ;// 取消运行
	final public static String TASK_STATUS_BREAK_DOWN = "B" ;// 中止
	final public static String TASK_STATUS_TRASH = "T" ;// 废弃运行
	

    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    @GenericGenerator(name="task_log_id_seq", strategy = "increment")
    private Long task_log_id ;
     private Long task_config_id;
     private Long group_id;
     private String task_status;
     private Timestamp start_on;
     private Timestamp end_on;
     private String remark_;
     private String switch_;
     private String app_id;
     private Timestamp update_on;
	public Long getTask_log_id() {
		return task_log_id;
	}
	public void setTask_log_id(Long task_log_id) {
		this.task_log_id = task_log_id;
	}
	public Long getTask_config_id() {
		return task_config_id;
	}
	public void setTask_config_id(Long task_config_id) {
		this.task_config_id = task_config_id;
	}
	public Long getGroup_id() {
		return group_id;
	}
	public void setGroup_id(Long group_id) {
		this.group_id = group_id;
	}
	public String getTask_status() {
		return task_status;
	}
	public void setTask_status(String task_status) {
		this.task_status = task_status;
	}
	public Timestamp getStart_on() {
		return start_on;
	}
	public void setStart_on(Timestamp start_on) {
		this.start_on = start_on;
	}
	public Timestamp getEnd_on() {
		return end_on;
	}
	public void setEnd_on(Timestamp end_on) {
		this.end_on = end_on;
	}
	public String getRemark_() {
		return remark_;
	}
	public void setRemark_(String remark_) {
		this.remark_ = remark_;
	}
	public String getSwitch_() {
		return switch_;
	}
	public void setSwitch_(String switch_) {
		this.switch_ = switch_;
	}
	public String getApp_id() {
		return app_id;
	}
	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}
	public Timestamp getUpdate_on() {
		return update_on;
	}
	public void setUpdate_on(Timestamp update_on) {
		this.update_on = update_on;
	}
	
}
