package com.globalwave.system.entity;

import com.globalwave.base.BaseSO;
import com.globalwave.base.annotations.Comparison;

public class ConfSubjectSO extends BaseSO {
	@Comparison(operator=Comparison.EQ)
    private String record_status ;

	public String getRecord_status() {
		return record_status;
	}

	public void setRecord_status(String record_status) {
		this.record_status = record_status;
	}

	@Override
	public Class<?> getTableClass() {
		return ConfSubject.class;
	}

}
