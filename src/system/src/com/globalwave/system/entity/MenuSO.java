package com.globalwave.system.entity;

import javax.persistence.Column;

import com.globalwave.base.BaseSO;
import com.globalwave.base.annotations.Comparison;

public class MenuSO extends BaseSO {

    @Column(name="id")
    @Comparison(operator = Comparison.IN)
    private Long[] ids ;
    
    private String label ;

	public Long[] getIds() {
		return ids;
	}
	public void setIds(Long[] ids) {
		this.ids = ids;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	@Override
	public Class<?> getTableClass() {
		return Menu.class;
	}
    
    
}
