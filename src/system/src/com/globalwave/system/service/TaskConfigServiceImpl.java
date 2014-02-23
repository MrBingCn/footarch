package com.globalwave.system.service;

import java.math.BigDecimal;
import java.util.HashMap;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.scheduling.TaskScheduler;
import com.globalwave.system.entity.TaskConfig;
import com.globalwave.system.entity.TaskConfigCriterion;

public class TaskConfigServiceImpl 
       extends BaseServiceImpl 
       implements TaskConfigService {

    public TaskConfig create(TaskConfig taskConfig) throws Exception {
    	setConfig(taskConfig);
        return (TaskConfig) jdbcDao.insert(taskConfig);
    }

    public void update(TaskConfig taskConfig) throws Exception {
    	setConfig(taskConfig);
        jdbcDao.update(taskConfig) ;
    }
    
    private void setConfig(TaskConfig taskConfig) {

    	if (TaskConfig.TASK_TYPE_SCHEDULING.equals(taskConfig.getTask_type())) {
    		// * 0-59 * * * *
    		String scheduleType = taskConfig.getSchedule_type() ;
    		String ssmihh24 = "0 " + taskConfig.getStart_on_minute() + " " + taskConfig.getStart_on_hour() + " " ;
    		
    		if (TaskConfig.SCHEDULE_TYPE_MONTH.equals(scheduleType)) {
    			taskConfig.setCron_sequence(ssmihh24 + taskConfig.getTrigger_scope() + " * *") ;
    		} else if (TaskConfig.SCHEDULE_TYPE_WEEK.equals(scheduleType)) {
    			taskConfig.setCron_sequence(ssmihh24 + "* * " + taskConfig.getTrigger_scope()) ;
    		} else {
    			taskConfig.setCron_sequence(ssmihh24 + "* * *") ;    			
    		}
    	} else {
    		taskConfig.setCron_sequence("") ;
    	}
    }

    public void delete(TaskConfig taskConfig) throws Exception {
        // delete cascade 
        //OrganizationTaskConfig orgTaskConfig = new OrganizationTaskConfig() ;
        //orgTaskConfig.setTaskConfig_id(taskConfig.getTaskConfig_id()) ;
        //jdbcDao.delete(OrganizationTaskConfig.class, orgTaskConfig) ;
        
        jdbcDao.delete(taskConfig) ;
        
    }

    public void deleteAll(Long[] ids) throws Exception {
        TaskConfigCriterion criterion = new TaskConfigCriterion() ;
        criterion.setIds(ids) ;
        jdbcDao.delete(TaskConfig.class, criterion) ;
        
    }

    public ArrayPageList<HashMap<Object, Object>> query(
            TaskConfigCriterion criterion, 
            int pageIndex, 
            int pageSize, 
            ArrayOrderList orderList) throws Exception {
        
        if (orderList == null) {
            orderList = new ArrayOrderList() ;
            orderList.addAsc("task_status") ;
            orderList.addAsc("name_") ;
        }
        
        //return jdbcDao.query(TaskConfig.class, criterion, orderList, pageIndex, pageSize);
        ArrayPageList<HashMap<Object, Object>> result = (ArrayPageList<HashMap<Object, Object>>)jdbcDao.query(
        		new StringBuffer(TaskConfigCriterion.CONFIG_QUERY_SQL_STRING),
        		criterion,
        		pageIndex,
        		pageSize,
        		orderList,
        		HashMap.class) ;
        
        for (HashMap<Object, Object> entity:result) {
        	Long id = ((BigDecimal)entity.get("task_config_id")).longValue() ;
        	entity.put("is_scheduled", TaskScheduler.getInstance().isScheduled(id)?"R":"S") ;//Running/Stoped
        }
        
        return result ;
    }


    public ArrayPageList<TaskConfig> queryAll(
            TaskConfigCriterion criterion ) throws Exception {
        /*
            ArrayOrderList orderList
        if (orderList == null) {
            orderList = new ArrayOrderList() ;
            orderList.addAsc("task_status") ;
            orderList.addAsc("name_") ;
        }*/
        
        return (ArrayPageList<TaskConfig>)jdbcDao.query(criterion, 1, 1, null, TaskConfig.class);

    }
    
}
