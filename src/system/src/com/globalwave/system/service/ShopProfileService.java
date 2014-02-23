package com.globalwave.system.service;

import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.ShopProfile;
import com.globalwave.system.entity.ShopProfileCriterion;
import com.globalwave.system.entity.User;

public interface ShopProfileService {
    
    public ArrayPageList<ShopProfile> query(
            ShopProfileCriterion criterion, 
            int pageIndex, 
            int pageSize,
            ArrayOrderList orderList) 
    throws Exception ;
    
    public ShopProfile create(ShopProfile shopProfile) throws Exception ;
    public void update(ShopProfile shopProfile) throws Exception ;
    public void delete(ShopProfile shopProfile) throws Exception ;
    public void deleteAll(Long[] ids) throws Exception ;
    
    public ShopProfile get(Long id) throws Exception ;
    
    public ShopProfile get(String regionCode, String shopCode) throws Exception ;
    
    public ShopProfile dayBegin(ShopProfile shop, User user) throws Exception ;
    
    public ShopProfile dayEnd(ShopProfile shop) throws Exception ;

    public boolean isOpen(String regionCode, String shopCode) throws Exception ;
    
    public ShopProfile getShop() ;
}
