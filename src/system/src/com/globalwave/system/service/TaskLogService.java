package com.globalwave.system.service;

import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.TaskLog;
import com.globalwave.system.entity.TaskLogCriterion;

public interface TaskLogService {
    
    public ArrayPageList<TaskLog> query(
            TaskLogCriterion criterion, 
            int pageIndex, 
            int pageSize,
            ArrayOrderList orderList) 
    throws Exception ;
    
    public TaskLog create(TaskLog taskLog) throws Exception ;
    public void update(TaskLog taskLog) throws Exception ;
    public void delete(TaskLog taskLog) throws Exception ;
    public void deleteAll(Long[] ids) throws Exception ;
    

    public void cancel(Long[] ids) throws Exception ;
    public void trash(Long[] ids) throws Exception ;
    
}
