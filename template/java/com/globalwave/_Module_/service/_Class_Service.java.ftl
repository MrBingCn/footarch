package com.globalwave.${e.moduleName}.service;

import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.${e.moduleName}.entity.${e.className};
import com.globalwave.${e.moduleName}.entity.${e.className}Criterion;

public interface ${e.className}Service {
    
    public ArrayPageList<${e.className}> query(
            ${e.className}Criterion criterion, 
            int pageIndex, 
            int pageSize,
            ArrayOrderList orderList) 
    throws Exception ;
    
    public ${e.className} create(${e.className} ${e.entityName}) throws Exception ;
    public void update(${e.className} ${e.entityName}) throws Exception ;
    public void delete(${e.className} ${e.entityName}) throws Exception ;
    public void deleteAll(Long[] ids) throws Exception ;
}
