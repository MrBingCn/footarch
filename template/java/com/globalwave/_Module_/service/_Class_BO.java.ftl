package com.globalwave.${e.moduleName}.service;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.${e.moduleName}.entity.${e.className};
import com.globalwave.${e.moduleName}.entity.${e.className}SO;

@Service("${e.entityName}BO")
@Scope("prototype")
@Transactional
public class ${e.className}BO extends BaseServiceImpl {

    public ${e.className} create(${e.className} ${e.entityName}) throws Exception {
        return (${e.className}) jdbcDao.create(${e.entityName});
    }

    public void update(${e.className} ${e.entityName}) throws Exception {
        jdbcDao.update(${e.entityName}) ;
    }

    public void delete(${e.className} ${e.entityName}) throws Exception {
        // delete cascade 
        //Organization${e.className} org${e.className} = new Organization${e.className}() ;
        //org${e.className}.set${e.className}_id(${e.entityName}.get${e.className}_id()) ;
        //jdbcDao.delete(Organization${e.className}.class, org${e.className}) ;
        
        jdbcDao.delete(${e.entityName}) ;
        
    }

    public void deleteAll(Long[] ids) throws Exception {
        ${e.className}SO so = new ${e.className}SO() ;
        so.setIds(ids) ;
        jdbcDao.delete(${e.className}.class, so) ;
        
    }

    public ArrayPageList<${e.className}> query(
            ${e.className}SO so, 
            int pageIndex, 
            int pageSize, 
            ArrayOrderList orderList) throws Exception {
        
        if (orderList == null) {
            orderList = new ArrayOrderList() ;
            //orderList.addAsc("${e.entityName}_id") ;
        }
        
        return jdbcDao.query(${e.className}.class, so, orderList, pageIndex, pageSize);
    }


    
}
