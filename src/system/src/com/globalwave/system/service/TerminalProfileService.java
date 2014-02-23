package com.globalwave.system.service;


import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.system.entity.TerminalProfile;
import com.globalwave.system.entity.TerminalProfileCriterion;
import com.globalwave.system.entity.User;

public interface TerminalProfileService {
    
    public ArrayPageList<TerminalProfile> query(
            TerminalProfileCriterion criterion, 
            int pageIndex, 
            int pageSize,
            ArrayOrderList orderList) 
    throws Exception ;
    
    public TerminalProfile create(TerminalProfile terminalProfile) throws Exception ;
    public void update(TerminalProfile terminalProfile) throws Exception ;
    public void delete(TerminalProfile terminalProfile) throws Exception ;
    public void deleteAll(Long[] ids) throws Exception ;
    
    public TerminalProfile get(Long id) throws Exception ;
    
    public TerminalProfile get(String regionCode, String terminalCode) throws Exception ;
    
    public TerminalProfile login(TerminalProfile terminal, User user) throws Exception ;
    
    public void checkAllDayEnded(String regionCode, String shopCode, String excludeTerminalCode) throws Exception ;
    //public void dayBegin() throws Exception ;
    
    //public void dayEnd() throws Exception ;
 
    public void dayEndByShop(String regionCode, String shopCode) throws Exception ;
    
    public TerminalProfile dayEnd(TerminalProfile terminal) throws Exception  ;
    
    /**
     * 换班，当前Pos机，由另一个用户操作。
     * 
     * @throws Exception
     */
    public TerminalProfile relief(TerminalProfile terminal, User user) throws Exception ;
    
    public TerminalProfile dayBeginAndLogin(TerminalProfile terminal, User user) throws Exception ;
    
    public TerminalProfile getLoginTerminalInfo(User user) throws Exception ;
}
