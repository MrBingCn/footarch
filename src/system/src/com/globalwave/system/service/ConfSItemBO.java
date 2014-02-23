package com.globalwave.system.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.C;
import com.globalwave.system.entity.ConfItem;
import com.globalwave.system.entity.ConfItemSO;

@Service("confSItemBO")
@Scope("prototype")
@Transactional
public class ConfSItemBO extends BaseServiceImpl {
    public ConfItem create(ConfItem confItem) {  
    	ConfItem newConfItem = (ConfItem) jdbcDao.insert(confItem) ;
        return newConfItem;
    }
    
    public void update(ConfItem confItem) {
    	confItem.addExclusions("record_status") ;
        jdbcDao.update(confItem) ;  
    }

    public void delete(ConfItem confItem) {
    	confItem.addInclusions("record_status") ;
    	confItem.setRecord_status(C.RECORD_STATUS_CANCEL) ;
        jdbcDao.update(confItem) ;
    }

    public void delete(Long[] ids) {
    	ConfItemSO so = new ConfItemSO() ;
    	so.setIds(ids) ;

        jdbcDao.executeName("systemSQLs:deleteConfItems", so) ;
    }
    
    public ArrayPageList<ConfItem> query(ConfItemSO confItemSO){
        confItemSO.setRecord_status(C.RECORD_STATUS_ACTIVE);
        confItemSO.addDesc("sequence") ;
        //confItemSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE);
        return (ArrayPageList<ConfItem>)jdbcDao.query(confItemSO, ConfItem.class);
        //return (ArrayPageList<ConfItem>)jdbcDao.queryName("systemSQLs:getItemsBySub", confItemSO, ConfItem.class) ;
    }
    
    public ConfItem get(Long id) {  
    	ConfItem confItem = new ConfItem() ;
    	confItem.setId(id) ;
    	confItem = (ConfItem) jdbcDao.get(confItem) ;
        return confItem;
    }
}
