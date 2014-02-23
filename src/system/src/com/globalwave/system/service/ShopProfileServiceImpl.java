package com.globalwave.system.service;

import javax.persistence.Table;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayOrderList;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.C;
import com.globalwave.common.U;
import com.globalwave.common.exception.BusinessException;
import com.globalwave.system.entity.ShopAttribute;
import com.globalwave.system.entity.ShopProfile;
import com.globalwave.system.entity.ShopProfileCriterion;
import com.globalwave.system.entity.User;

public class ShopProfileServiceImpl 
       extends BaseServiceImpl 
       implements ShopProfileService {

	private TerminalProfileService terminalService ;
	private ShopProfile shop ;
	
    public ShopProfile create(ShopProfile shopProfile) throws Exception {
    	ShopProfile profile = (ShopProfile) jdbcDao.insert(shopProfile);
    	jdbcDao.insertAll(profile.getAttributes()) ;
    	return profile ;
    }

    public void update(ShopProfile shopProfile) throws Exception {
        jdbcDao.update(shopProfile) ;
        
        ShopProfile criterion = new ShopProfile() ;
        criterion.setShop_profile_id(shopProfile.getShop_profile_id()) ;
        jdbcDao.delete(ShopAttribute.class, criterion) ;
        
    	jdbcDao.insertAll(shopProfile.getAttributes()) ;
    }

    public void delete(ShopProfile shopProfile) throws Exception {
        // delete cascade        
        ShopProfile criterion = new ShopProfile() ;
        criterion.setShop_profile_id(shopProfile.getShop_profile_id()) ;
        jdbcDao.delete(ShopAttribute.class, criterion) ;
        
        jdbcDao.delete(shopProfile) ;
        
    }

    public void deleteAll(Long[] ids) throws Exception {
        ShopProfileCriterion criterion = new ShopProfileCriterion() ;
        criterion.setIds(ids) ;
        
        // delete cascade  
        jdbcDao.delete(ShopAttribute.class, criterion) ;
        
        jdbcDao.delete(ShopProfile.class, criterion) ;
        
    }


    public ShopProfile get(Long id) throws Exception {
        ShopProfile criterion = new ShopProfile() ;
        criterion.setShop_profile_id(id) ;
        
        ShopProfile result = (ShopProfile)jdbcDao.find(criterion) ;
       
        result.setAttributes(
        		(ArrayPageList<ShopAttribute>)jdbcDao.query(criterion, ArrayPageList.PAGEINDEX_NO_PAGE, -1, null, ShopAttribute.class)) ;
        
        return result ;
        
    }

    public ArrayPageList<ShopProfile> query(
            ShopProfileCriterion criterion, 
            int pageIndex, 
            int pageSize, 
            ArrayOrderList orderList) throws Exception {
        
        if (orderList == null) {
            orderList = new ArrayOrderList() ;
            //orderList.addAsc("shopProfile_id") ;
        }
        
        return (ArrayPageList<ShopProfile>)jdbcDao.query(criterion, pageIndex, pageSize, orderList, ShopProfile.class);
    }

    /**
     * user parameter is not use
     */
	@Override
	public ShopProfile dayBegin(ShopProfile shop, User user) throws Exception {

        String regionCode = shop.getRegion_code();
        String shopCode = shop.getCode_() ;
        ShopProfile resultShop = getActive(regionCode, shopCode) ;

        //当前日期
        if(U.currentTimestamp().before(resultShop.getEstablish_date())){
        	// 該員工所在中心未到使用日期,請核實後登入.E0001030005
        	throw new BusinessException("E0001030005");
        }
        
        if (ShopProfile.STATUS_OPEN.equals(resultShop.getStatus_())) {
    		// status is not correct
    		//E0001020003', '店铺[%s]已开业，无需要重复开业！
    		throw new BusinessException("E0001030003", shopCode) ;
    	}
        
    	if (!resultShop.getSale_date().before(shop.getSale_date())) {
    		// E0001020009', '销售日期应该在%D之后！
    		throw new BusinessException("E0001030009", resultShop.getSale_date()) ;
    	}
    	
        /* 设置需要修改的字段值 */
        //中心状态
    	// update shop    	开业状态/ 营业日期
        jdbcDao.update(
        		ShopProfile.class.getAnnotation(Table.class).name(),
        		new String[]{"sale_date", "status_"}, 
        		new Object[]{shop.getSale_date(), ShopProfile.STATUS_OPEN},
        		new String[]{"shop_profile_id="}, 
        		new Object[]{resultShop.getShop_profile_id()}) ;
        
		return resultShop;
	}

	/**
	 * 对当前POS机对应的店铺进行结业操作
	 * 
	 * @param terminal
	 * @return
	 * @throws Exception
	 */
	@Override
	public ShopProfile dayEnd(ShopProfile shop) throws Exception {
		
		String regionCode = shop.getRegion_code() ;
		String shopCode = shop.getCode_() ;
		
        ShopProfile resultShop = getActive(regionCode, shopCode) ;

        if (ShopProfile.STATUS_CLOSE.equals(resultShop.getStatus_())) {
    		// status is not correct
    		//E0001020003', '店铺[%s]已结业，无需要重复结业！
    		throw new BusinessException("E0001030004", shopCode) ;
    	}
		
		getTerminalService().dayEndByShop(regionCode , shopCode) ;

        jdbcDao.update(
        		ShopProfile.class.getAnnotation(Table.class).name(),
        		new String[]{"status_"}, 
        		new Object[]{ShopProfile.STATUS_CLOSE},
        		new String[]{"shop_profile_id="}, 
        		new Object[]{resultShop.getShop_profile_id()}) ;
        
		return resultShop;
	}

	@Override
	public ShopProfile get(String regionCode, String shopCode) throws Exception {
		
		ShopProfile criterion = new ShopProfile() ;

		if (regionCode == null) {
			throw new BusinessException("required", "Region Code") ;
		}
		
		if (shopCode == null) {
			throw new BusinessException("required", "Shop Code") ;
		}
		
		criterion.setRegion_code(regionCode) ;
		criterion.setCode_(shopCode) ;
		
		return (ShopProfile)jdbcDao.find(criterion);
	}


	public ShopProfile getShop() {
		return shop;
	}

	public ShopProfile getActive(String regionCode, String shopCode) throws Exception {
		
		ShopProfile result = get(regionCode, shopCode) ;
		

    	if (result == null) {
    		// throw exception, can't not be found.
    		// E0001020001', '未能找到编号为%s的店铺，请检查！
    		throw new BusinessException("E0001030001", shopCode) ;
    	}
    	
    	if(C.RECORD_ACTIVE.intValue() != result.getRecord_status().intValue()) {
        	// not a active record. throw exception
    		//E0001020002', '店铺[%s]非活动状态，不能使用！
    		throw new BusinessException("E0001030002", shopCode) ;
    	}
		
    	this.shop = result ;
		return result;
	}

    public boolean isOpen(String regionCode, String shopCode) throws Exception {
    	getActive(regionCode, shopCode);
    	return ShopProfile.STATUS_OPEN.equals(this.shop.getStatus_()) ;
    }

	public TerminalProfileService getTerminalService() {
		if (terminalService == null) {
			TerminalProfileServiceImpl t = new TerminalProfileServiceImpl() ;
			t.setShopService(this) ;
			t.setJdbcDao(jdbcDao) ;
			
			this.terminalService  = t ;
		}
		return terminalService;
	}

	public void setTerminalService(TerminalProfileService terminalService) {
		this.terminalService = terminalService;
	}

    
    
}
