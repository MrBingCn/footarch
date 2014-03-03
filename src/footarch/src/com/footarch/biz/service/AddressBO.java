package com.footarch.biz.service;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footarch.biz.entity.Address;
import com.footarch.biz.entity.AddressSO;
import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.exception.BusinessException;

@Service("addressBO")
@Scope("prototype")
@Transactional
public class AddressBO extends BaseServiceImpl {
	public Address create(Address address) {
		return (Address) jdbcDao.insert(address);
	}
	
	public void update(Address address) {
		jdbcDao.update(address);
	}
	
	public void delete(Address address) {
		address.setStatus("1");
		address.addInclusions("status");
		update(address);
	}
	
    public Address get(Long id) { 
    	if (id == null) {
    		throw new BusinessException("address id is required") ;
    	}
    	Address address = new Address() ;
    	address.setId(id) ;
        return (Address) jdbcDao.get(address) ;
    }
	
	public void setDefault(Long userId, Long addressId) {
		AddressSO addressSO = new AddressSO();
		addressSO.setUser_id(userId);
		addressSO.setStatus("0");
		addressSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE);
		ArrayPageList<Address> list = query(addressSO);
		Address ready_default = null;
		for (Address address : list) {
			if (address.getId().longValue() == addressId) {
				ready_default = address;
				break;
			}
		}
		if (ready_default != null) {
			ready_default.setIs_default("1");
			update(ready_default);
		}
		for (Address address : list) {
			if (address.getIs_default().equals("1") && address.getId().longValue() != addressId) {
				address.setIs_default("0");
				update(address);
				break;
			}
		}
	}
	
    public ArrayPageList<Address> query(
    		AddressSO addressSO) {
    	if (addressSO == null) {
    		addressSO = new AddressSO();
    	}
    	addressSO.setStatus("0");
        return (ArrayPageList<Address>)jdbcDao.query(addressSO, Address.class);
    }
}
