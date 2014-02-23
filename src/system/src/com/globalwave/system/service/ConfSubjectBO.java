package com.globalwave.system.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.C;
import com.globalwave.system.entity.ConfSubject;
import com.globalwave.system.entity.ConfSubjectSO;

@Service("confSubjectBO")
@Scope("prototype")
@Transactional
public class ConfSubjectBO extends BaseServiceImpl {
    public ArrayPageList<ConfSubject> query(
    		ConfSubjectSO confSubjectSO) 
    throws Exception {

        if (confSubjectSO == null) {
        	confSubjectSO = new ConfSubjectSO() ;
        }
        confSubjectSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE);
        confSubjectSO.setRecord_status(C.RECORD_STATUS_ACTIVE);
        
        return (ArrayPageList<ConfSubject>)jdbcDao.query(confSubjectSO, ConfSubject.class);
    }
}
