package com.globalwave.system.service;

import java.util.HashMap;

import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.TaskConfig;
import com.globalwave.system.entity.TaskConfigCriterion;

public interface TaskConfigService {
    
    public ArrayPageList<HashMap<Object, Object>> query(
            TaskConfigCriterion criterion, 
            int pageIndex, 
            int pageSize,
            ArrayOrderList orderList) 
    throws Exception ;
    
    public TaskConfig create(TaskConfig taskConfig) throws Exception ;
    public void update(TaskConfig taskConfig) throws Exception ;
    public void delete(TaskConfig taskConfig) throws Exception ;
    public void deleteAll(Long[] ids) throws Exception ;
    public ArrayPageList<TaskConfig> queryAll(TaskConfigCriterion criterion ) throws Exception ;
}
