package com.globalwave.system.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.globalwave.base.BaseEntity;

@Entity
@Table(name = "sys_task_config")
public class TaskConfig extends BaseEntity implements Serializable  {

	final public static String TASK_TYPE_ONCE = "O" ;
	final public static String TASK_TYPE_SCHEDULING = "S" ;
	final public static String TASK_TYPE_PERIOD = "P" ; 

	final public static String SCHEDULE_TYPE_MONTH = "M" ;
	final public static String SCHEDULE_TYPE_WEEK = "W" ;
	final public static String SCHEDULE_TYPE_DAY = "D" ; 

	final public static String COMMAND_TYPE_DATA_SYNC = "S" ;
	final public static String COMMAND_TYPE_JAVA = "J" ;

	final public static String TASK_STATUS_ACTIVE = "A" ;
	final public static String TASK_STATUS_CANCEL = "C" ;

    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    @GenericGenerator(name="task_config_id_seq", strategy = "increment")
    private Long task_config_id ;
     private String code_;
     private String name_;
     private String task_type;
     private String command_type;
     private String command_content;
     private String command_params;
     private String task_status;
     private String schedule_type;
     private Long trigger_period;
     private String trigger_scope;
     private Integer start_on_hour;
     private Integer start_on_minute;
     private String cron_sequence;
     private String app_id_type;
     private String app_id;
     private String desc_;
     private Long last_task_log_id ;
     
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
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	public String getCommand_type() {
		return command_type;
	}
	public void setCommand_type(String command_type) {
		this.command_type = command_type;
	}
	public String getCommand_content() {
		return command_content;
	}
	public void setCommand_content(String command_content) {
		this.command_content = command_content;
	}
	public String getCommand_params() {
		return command_params;
	}
	public void setCommand_params(String command_params) {
		this.command_params = command_params;
	}
	public String getTask_status() {
		return task_status;
	}
	public void setTask_status(String task_status) {
		this.task_status = task_status;
	}
	public String getSchedule_type() {
		return schedule_type;
	}
	public void setSchedule_type(String schedule_type) {
		this.schedule_type = schedule_type;
	}
	public Long getTrigger_period() {
		return trigger_period;
	}
	public void setTrigger_period(Long trigger_period) {
		this.trigger_period = trigger_period;
	}
	public String getTrigger_scope() {
		return trigger_scope;
	}
	public void setTrigger_scope(String trigger_scope) {
		this.trigger_scope = trigger_scope;
	}
	public Integer getStart_on_hour() {
		return start_on_hour;
	}
	public void setStart_on_hour(Integer start_on_hour) {
		this.start_on_hour = start_on_hour;
	}
	public Integer getStart_on_minute() {
		return start_on_minute;
	}
	public void setStart_on_minute(Integer start_on_minute) {
		this.start_on_minute = start_on_minute;
	}
	public String getCron_sequence() {
		return cron_sequence;
	}
	public void setCron_sequence(String cron_sequence) {
		this.cron_sequence = cron_sequence;
	}
	public String getApp_id_type() {
		return app_id_type;
	}
	public void setApp_id_type(String app_id_type) {
		this.app_id_type = app_id_type;
	}
	public String getApp_id() {
		return app_id;
	}
	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}
	public String getDesc_() {
		return desc_;
	}
	public void setDesc_(String desc_) {
		this.desc_ = desc_;
	}
	public Long getLast_task_log_id() {
		return last_task_log_id;
	}
	public void setLast_task_log_id(Long last_task_log_id) {
		this.last_task_log_id = last_task_log_id;
	}
	
}
