package com.footarch.biz.service.report;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;

import com.globalwave.common.cache.CodeHelper;

public abstract class ReportDataRefactor {

	private Map context ;
	
	public ReportDataRefactor() {
		
	}
	
	public void execute(List<Map<String, Object>> datas, ReportDataRefactor ... subRefactors) {
		
		for (Map data:datas) {

			this.envaluate(data) ;
			
			
			List<Map<String, Object>> subDatas = (List<Map<String, Object>>)data.get("items")  ;
			if (subDatas != null) {
				if (subRefactors != null && subRefactors.length >= 1) {
				    subRefactors[0].execute(subDatas, (ReportDataRefactor[])ArrayUtils.subarray(subRefactors, 1, subRefactors.length)) ;
				}
			}
		}

		this.sort(datas) ;
	}
	
	public abstract void sort(List<Map<String, Object>> datas) ;/* {
		Collections.sort(
				datas, 
	    		new PinyinComparator("order-property", true, "order-code-name", "order-column-name")) ;
	}*/
	
	public abstract void envaluate(Map<String, Object> data) ; /*{
		
	}*/
	
	protected void envaluateCode(Map<String, Object> row, String codeName, String columnName, Object idName, String newColumnName) {
		if (newColumnName == null) {
			newColumnName = codeName ;
		}
		row.put(newColumnName, CodeHelper.get(codeName, columnName, row.get(idName))) ;
	}

	public void setContext(Map context) {
		this.context = context;
	}
	
	public Map getContext() {
		return context;
	}
}
