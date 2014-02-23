package com.globalwave.system.service;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.Table;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.TaskConfig;
import com.globalwave.system.entity.TaskLog;
import com.globalwave.system.entity.TaskLogCriterion;

public class TaskLogServiceImpl 
       extends BaseServiceImpl 
       implements TaskLogService {

    public TaskLog create(TaskLog taskLog) throws Exception {
    	TaskLog result = (TaskLog) jdbcDao.insert(taskLog);

        Map<String, Object> config = new HashMap<String, Object>() ;
        config.put("last_task_log_id", result.getTask_log_id()) ;
        config.put("$TABLE", TaskConfig.class.getAnnotation(Table.class).name()) ;
        
        Map<String, Object> configKey = new HashMap<String, Object>() ;
        configKey.put("task_config_id = ", result.getTask_config_id()) ;
        
        jdbcDao.update(config, configKey);
        
		return result ;
    }

    public void update(TaskLog taskLog) throws Exception {
        jdbcDao.update(taskLog) ;
    }

    public void delete(TaskLog taskLog) throws Exception {
        // delete cascade 
        //OrganizationTaskLog orgTaskLog = new OrganizationTaskLog() ;
        //orgTaskLog.setTaskLog_id(taskLog.getTaskLog_id()) ;
        //jdbcDao.delete(OrganizationTaskLog.class, orgTaskLog) ;
        
        jdbcDao.delete(taskLog) ;
        
    }

    public void deleteAll(Long[] ids) throws Exception {
        TaskLogCriterion criterion = new TaskLogCriterion() ;
        criterion.setIds(ids) ;
        jdbcDao.delete(TaskLog.class, criterion) ;
        
    }

    public void cancel(Long[] ids) throws Exception {
        Map<String, Object> taskLog = new HashMap<String, Object>() ;
        taskLog.put("task_status", TaskLog.TASK_STATUS_CANCELED) ;
        taskLog.put("$TABLE", TaskLog.class.getAnnotation(Table.class).name()) ;
        
        Map<String, Object> taskLogKey = new HashMap<String, Object>() ;
        taskLogKey.put("task_log_id in ", ids) ;
        taskLogKey.put("task_status=", TaskLog.TASK_STATUS_RUNNING) ;
        
        jdbcDao.update(taskLog, taskLogKey) ;
        
    }

    public void trash(Long[] ids) throws Exception {
        Map<String, Object> taskLog = new HashMap<String, Object>() ;
        taskLog.put("task_status", TaskLog.TASK_STATUS_TRASH) ;
        taskLog.put("$TABLE", TaskLog.class.getAnnotation(Table.class).name()) ;
        
        Map<String, Object> taskLogKey = new HashMap<String, Object>() ;
        taskLogKey.put("task_log_id in ", ids) ;
        taskLogKey.put("task_status=", TaskLog.TASK_STATUS_RUNNING) ;
        
        jdbcDao.update(taskLog, taskLogKey) ;
        
    }
    

    public ArrayPageList<TaskLog> query(
            TaskLogCriterion criterion, 
            int pageIndex, 
            int pageSize, 
            ArrayOrderList orderList) throws Exception {
        
        if (orderList == null) {
            orderList = new ArrayOrderList() ;
            orderList.addDesc("task_log_id") ;
        }
        
        return (ArrayPageList<TaskLog>)jdbcDao.query(criterion, pageIndex, pageSize, orderList, TaskLog.class);
    }


    
}
