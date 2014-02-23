package com.globalwave.system.entity;


import javax.persistence.Column;

import com.globalwave.base.BaseSO;


public class MarkItSO extends BaseSO {

    @Column(name="id")
    private Long[] ids ;

    private Long user_id ;

    
	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	
	@Override
	public Class<?> getTableClass() {
		return MarkIt.class;
	}
	
}
