package com.globalwave.system.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.MarkIt;
import com.globalwave.system.entity.MarkItSO;
import com.globalwave.system.entity.SessionUser;
import com.globalwave.system.entity.User;

@Service("markItBO")
@Scope("prototype")
@Transactional
public class MarkItBO extends BaseServiceImpl {

    @SuppressWarnings("unchecked")
    public ArrayPageList<MarkIt> query(MarkItSO markItSO) {
    	
        if (markItSO == null) {
    		markItSO = new MarkItSO() ;
    	}
    	
		markItSO.addAsc("text") ;
	
        return (ArrayPageList<MarkIt>)jdbcDao.query(markItSO, MarkIt.class);
    }

    public Map<Long,MarkIt> queryByUserId(Long user_id) {
    	
    	MarkItSO markItSO = new MarkItSO() ;
    	
    	markItSO.setUser_id(user_id) ;
    	markItSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE) ;
    	
	
        List<MarkIt> list = (ArrayPageList<MarkIt>)this.query(markItSO); 
        Map<Long, MarkIt> result = new HashMap<Long, MarkIt>() ;
        
        for (MarkIt mark : list) {
        	result.put(mark.getId(), mark) ;
        }
        
        return result ;
    }

    public MarkIt create(MarkIt markIt) { 
        final MarkIt newMarkIt = (MarkIt) jdbcDao.insert(markIt) ;
                
        return newMarkIt;
    }
    

    public MarkIt save(MarkIt markIt) {
    	
    	markIt.setUser_id(SessionUser.get().getUser().getId()) ;

    	if (markIt.getId() == null) {
    		if (StringUtils.isEmpty(markIt.getColor())) {
    			markIt.setColor("#FFFFFF") ;
    		}
    		markIt = (MarkIt) jdbcDao.insert(markIt) ;
    	} else {    		
    		jdbcDao.update(markIt); 
    	}
    	
    	SessionUser sUser = SessionUser.get() ;
    	sUser.setMarks(this.queryByUserId(sUser.getUser().getId())) ;
    	
    	return markIt ;
    }

    public void update(MarkIt markIt) { 
    	
        jdbcDao.update(markIt);
    }


    public void delete(MarkIt markIt) {
        
        jdbcDao.delete(markIt) ;

    	SessionUser sUser = SessionUser.get() ;
    	sUser.setMarks(this.queryByUserId(sUser.getUser().getId())) ;
    }

    public void deleteAll(Long[] ids) {
        
        MarkItSO so = new MarkItSO() ;
        so.setIds(ids) ;

        jdbcDao.delete(MarkIt.class, so) ;
        
    }

    public MarkIt get(Long markIt_id) {
        MarkIt markIt = new MarkIt() ;
        markIt.setId(markIt_id) ;
        
        return (MarkIt)jdbcDao.get(markIt) ;
    }
}
