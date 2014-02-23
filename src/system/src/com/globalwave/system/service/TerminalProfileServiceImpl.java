package com.globalwave.system.service;

import java.util.List;

import javax.persistence.Table;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.C;
import com.globalwave.common.U;
import com.globalwave.common.exception.BusinessException;
import com.globalwave.system.entity.TerminalAttribute;
import com.globalwave.system.entity.TerminalProfile;
import com.globalwave.system.entity.TerminalProfileCriterion;
import com.globalwave.system.entity.User;

public class TerminalProfileServiceImpl 
       extends BaseServiceImpl 
       implements TerminalProfileService {

	private ShopProfileService shopService ;
	private TerminalProfile terminalProfile ;
	
    public TerminalProfile create(TerminalProfile terminalProfile) throws Exception {
    	TerminalProfile profile = (TerminalProfile) jdbcDao.insert(terminalProfile);
    	jdbcDao.insertAll(profile.getAttributes()) ;
    	return profile ;
    }

    public void update(TerminalProfile profile) throws Exception {
        jdbcDao.update(profile) ;
        
        TerminalProfile criterion = new TerminalProfile() ;
        criterion.setTerminal_profile_id(profile.getTerminal_profile_id()) ;
        jdbcDao.delete(TerminalAttribute.class, criterion) ;
        
    	jdbcDao.insertAll(profile.getAttributes()) ;
    }

    public void delete(TerminalProfile profile) throws Exception {
        // delete cascade 
        TerminalProfile criterion = new TerminalProfile() ;
        criterion.setTerminal_profile_id(profile.getTerminal_profile_id()) ;
        jdbcDao.delete(TerminalAttribute.class, criterion) ;
        
        jdbcDao.delete(profile) ;
        
    }

    public void deleteAll(Long[] ids) throws Exception {
        TerminalProfileCriterion criterion = new TerminalProfileCriterion() ;
        criterion.setIds(ids) ;
        
        jdbcDao.delete(TerminalAttribute.class, criterion) ;
        
        jdbcDao.delete(TerminalProfile.class, criterion) ;
        
    }

    public ArrayPageList<TerminalProfile> query(
            TerminalProfileCriterion criterion, 
            int pageIndex, 
            int pageSize, 
            ArrayOrderList orderList) throws Exception {
        
        if (orderList == null) {
            orderList = new ArrayOrderList() ;
            //orderList.addAsc("terminalProfile_id") ;
        }
        
        return (ArrayPageList<TerminalProfile>)jdbcDao.query(criterion, pageIndex, pageSize, orderList, TerminalProfile.class);
    }



    public TerminalProfile get(Long id) throws Exception {
    	TerminalProfile criterion = new TerminalProfile() ;
        criterion.setTerminal_profile_id(id) ;
        
        TerminalProfile result = (TerminalProfile)jdbcDao.find(criterion) ;
       
        result.setAttributes(
        		(ArrayPageList<TerminalAttribute>)jdbcDao.query(criterion, ArrayPageList.PAGEINDEX_NO_PAGE, -1, null, TerminalAttribute.class)) ;
        
        return result ;
        
    } 
    

    public TerminalProfile login(TerminalProfile terminal, User user) throws Exception {
    	
    	String code = terminal.getCode_() ;
    	String login_id = user.getLogin_id() ;
    	
    	if (terminalProfile == null) {
    		terminalProfile = getActive(user.getRegion_code(), code) ;
    	}
    	
    	TerminalProfile resultTerminal = terminalProfile ;
    	
        if(U.currentTimestamp().before(resultTerminal.getEstablish_date())){
        	// E0001020008', '該員工所使用的终端未到使用日期,請核實後登入！
        	throw new BusinessException("E0001020008");
        }
    	
    	if (!TerminalProfile.STATUS_OPEN.equals(resultTerminal.getStatus_())) {
    		// throw exception, pls day begin first
    		//E0001020005', '终端[%s]还没有开业，请先开业后再登录！
    		throw new BusinessException("E0001020005", code) ;
    	}

    	TerminalProfile terminalLogined = getTerminalUserLogined(login_id)  ;
		//验证当前操作人是否重复登陆POS机(排除当前登陆的POS编号)
    	if (terminalLogined != null && !code.equals(terminalLogined.getCode_())) {
    		// E0001020006', '当前用户[%s]已经登录终端[%s]，不能登录其它终端！
    		throw new BusinessException("E0001020006", login_id, terminalLogined.getCode_()) ;
    	}
    	
    	// update Terminal    	// update ip	// update name   	// update staff
        jdbcDao.update(
        		TerminalProfile.class.getAnnotation(Table.class).name(),
        		new String[]{"Computer_ip", "Computer_name", "current_user"}, 
        		new Object[]{terminal.getComputer_ip(), terminal.getComputer_name(), login_id},
        		new String[]{"Terminal_profile_id="}, 
        		new Object[]{resultTerminal.getTerminal_profile_id()}) ;

        resultTerminal.setComputer_ip(terminal.getComputer_ip()) ;
        resultTerminal.setComputer_name(terminal.getComputer_name()) ;
        resultTerminal.setCurrent_user(login_id) ;
        
    	return resultTerminal ;
    }

    public TerminalProfile getTerminalUserLogined(String login_id) throws Exception {
    	TerminalProfileCriterion criterion = new TerminalProfileCriterion() ;
    	criterion.setCurrent_user(login_id) ;

    	List<TerminalProfile> terminals = (List<TerminalProfile>)jdbcDao.query(criterion, null, TerminalProfile.class) ;
    	if (terminals.size()> 0) {
    		return terminals.get(0) ;
    	} else {
    		return null ;
    	}
    }

    public TerminalProfile dayBeginAndLogin(TerminalProfile terminal, User user) throws Exception {
    	
    	terminalProfile = get(user.getRegion_code(), terminal.getCode_()) ;

    	if (TerminalProfile.STATUS_CLOSE.equals(terminalProfile.getStatus_())) {// is open , not to day begin
    	    dayBegin(terminal, user) ;
    	}
    	return login(terminal, user) ;
    }
    
    
    public TerminalProfile dayBegin(TerminalProfile terminal, User user) throws Exception {
    	
    	final String regionCode = user.getRegion_code() ;
    	final String shopCode = user.getShop_code() ;
    	
    	if (!this.getShopService().isOpen(regionCode, shopCode)) {
    		//E0001020010', ' 店铺[%s]未开业状态下，终端不能开业！
    		throw new BusinessException("E0001020010", shopCode) ;
    	}
    	terminal.setSale_date(this.getShopService().getShop().getSale_date()) ;
    	
    	if (terminalProfile == null) {
    		terminalProfile = getActive(user.getRegion_code(), terminal.getCode_()) ;
    	}
    	
    	TerminalProfile resultTerminal = terminalProfile ;
    	
    	if (TerminalProfile.STATUS_OPEN.equals(resultTerminal.getStatus_())) {
    		// status is not correct
    		//E0001020003', '终端[%s]已开业，无需要重复开业！
    		throw new BusinessException("E0001020003", resultTerminal.getCode_()) ;
    	}
    	
    	if (!resultTerminal.getSale_date().before(terminal.getSale_date())) {
    		// E0001020009', '销售日期应该在%D之后！
    		throw new BusinessException("E0001020009", resultTerminal.getSale_date()) ;
    	}
    	
    	// update status
    	// update sale date
        jdbcDao.update(
        		TerminalProfile.class.getAnnotation(Table.class).name(),
        		new String[]{"Status_", "Sale_date"}, 
        		new Object[]{TerminalProfile.STATUS_OPEN, terminal.getSale_date()},
        		new String[]{"Terminal_profile_id="}, 
        		new Object[]{resultTerminal.getTerminal_profile_id()}) ;
        
        resultTerminal.setStatus_(TerminalProfile.STATUS_OPEN) ;
        resultTerminal.setSale_date(terminal.getSale_date()) ;
        
    	return resultTerminal ;
    }

    public TerminalProfile dayEnd(TerminalProfile terminal) throws Exception {
    	
    	TerminalProfile resultTerminal = getActive(terminal.getRegion_code(), terminal.getCode_()) ;
    	
    	if (TerminalProfile.STATUS_CLOSE.equals(resultTerminal.getStatus_())) {
    		// status no rigth
    		// E0001020004', '终端[%s]已结业，无需要重复结业！
    		throw new BusinessException("E0001020004", resultTerminal.getCode_()) ;
    	}
    	/* posctl.setStaffNum("");                                 //当前操作人编号
            posctl.setVersionID(DateFunc.getCurrentTime(accessor)); //系统时间戳
            posctl.setChgCut(new Long(0));                          //换班次数
            posctl.setIpAddr("");              */
    	// update status
    	// update sale date
        jdbcDao.update(
        		TerminalProfile.class.getAnnotation(Table.class).name(),
        		new String[]{"Status_", "Computer_ip", "Computer_name", "current_user"}, 
        		new Object[]{TerminalProfile.STATUS_CLOSE, "", "", ""},
        		new String[]{"Terminal_profile_id="}, 
        		new Object[]{resultTerminal.getTerminal_profile_id()}) ;
        
    	return resultTerminal ;
    }
    
    /**
     * 验证是否该中心所有的POS机都已结业，记录未结业的POS编号及操作人编号 
     */
    public void checkAllDayEnded(String regionCode, String shopCode, String excludeTerminalCode) throws Exception {

        
        List<TerminalProfile> terminals = findOpenTerminal(regionCode, shopCode) ;
        
        if (terminals.size() > 0) {
        	String ts = "" ;
        	for (TerminalProfile t:terminals) {
        		ts += t.getCurrent_user() + "@" + t.getCode_() + "； " ;
        	}
        	
        	if ("".equals(ts)) {
        		// E0001020007', '当前仍未结业的终端如下：%s！
    		    throw new BusinessException("E0001020007", ts) ;
        	}
        }
    }
    
    public void dayEndByShop(String regionCode, String shopCode) throws Exception {
        List<TerminalProfile> terminals = findOpenTerminal(regionCode, shopCode) ;
        
        if (terminals.size() > 0) {
        	for (TerminalProfile t:terminals) {
        		dayEnd(t) ;
        	}
        }
    }
    
    
    private List<TerminalProfile> findOpenTerminal(String regionCode, String shopCode) throws Exception {
    	TerminalProfile criterion = new TerminalProfile() ;
        criterion.setRegion_code(regionCode) ;
        criterion.setShop_code(shopCode) ;
        criterion.setStatus_(TerminalProfile.STATUS_OPEN) ;
        criterion.setRecord_status(C.RECORD_ACTIVE) ;
        
        return (List<TerminalProfile>)jdbcDao.query(criterion, null, TerminalProfile.class) ;
    }

	@Override
	public TerminalProfile get(String regionCode, String terminalCode) throws Exception {

    	TerminalProfile criterion = new TerminalProfile() ;
        criterion.setRegion_code(regionCode) ;
        criterion.setCode_(terminalCode) ;
        
        return (TerminalProfile)jdbcDao.find(criterion) ;
	}

	public TerminalProfile getActive(String regionCode, String terminalCode)
			throws Exception {

		terminalProfile = get(regionCode, terminalCode) ;
		
		checkActive() ;
		
		return terminalProfile ;
	}

	public void checkActive() throws Exception {
	    	
    	if (terminalProfile == null) {
    		// throw exception, can't not be found.
    		// E0001020001', '未能找到编号为%s的终端，请检查！
    		throw new BusinessException("E0001020001", terminalProfile.getCode_()) ;
    	}
    	
    	if(C.RECORD_ACTIVE.intValue() != terminalProfile.getRecord_status().intValue()) {
        	// not a active record. throw exception
    		//E0001020002', '终端[%s]非活动状态，不能使用！
    		throw new BusinessException("E0001020002", terminalProfile.getCode_()) ;
    	}
    	
	}
	
	/**
	 * 换班
	 */
	@Override
	public TerminalProfile relief(TerminalProfile terminal, User user)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * if sale date is null then open centre
	 * if pos status is 0 then open pos & login
	 * else login
	 * 
	 * @param user
	 * @return
	 */
	public TerminalProfile getLoginTerminalInfo(User user) throws Exception {
		
		String regionCode = user.getRegion_code() ;
		String shopCode = user.getShop_code() ;
		
		if (shopCode == null) {
			//E0000000005', '非终端用户，不能登录终端！
			throw new BusinessException("E0000000005") ;
		}
		
		TerminalProfile result = new TerminalProfile() ;
		
		if (!getShopService().isOpen(regionCode, shopCode)) {
			return result ;
		}

		result.setSale_date(this.shopService.getShop().getSale_date()) ;
		
		TerminalProfile logined = getTerminalUserLogined(user.getLogin_id()) ;
		
		if (logined != null) {
			result.setCode_(logined.getCode_()) ;
		}
		
		return result ;
	}
	
	public ShopProfileService getShopService() {
		if (shopService == null) {
			ShopProfileServiceImpl s = new ShopProfileServiceImpl() ;
			s.setTerminalService(this) ;
			s.setJdbcDao(jdbcDao) ;
			shopService = s ;
		}
		return shopService;
	}

	public void setShopService(ShopProfileService shopService) {
		this.shopService = shopService;
	}
	
	
}
