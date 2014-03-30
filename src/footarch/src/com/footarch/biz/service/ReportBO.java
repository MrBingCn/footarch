package com.footarch.biz.service;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalwave.base.BaseServiceImpl;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.C;
import com.globalwave.common.cache.CodeHelper;
import com.globalwave.report.parser.excel.ExcelParser;
import com.globalwave.system.entity.SessionUser;
import com.footarch.biz.entity.Report;
import com.footarch.biz.entity.ReportSO;
import com.footarch.biz.service.report.ReportDataRefactor;
import com.footarch.biz.service.report.refactor.BlankRefactor;

/*

 * @author Administrator
 *
 */
@Service("reportBO")
@Scope("prototype")
@Transactional
public class ReportBO extends BaseServiceImpl {
	
	/**
	 * 根据查询条件，获取Excel的Report对象，供调用者使用
	 * 
	 * @param reportSO
	 * @return
	 * @throws Exception
	 */
	public com.globalwave.report.parser.excel.Report generateExcel(ReportSO reportSO) throws Exception {
		
		Map<String, Object> context = new HashMap<String, Object>() ;
		ExcelParser parser = null ;
		
		short type = reportSO.getReport_type() ;
		
		// name 用于指定method & template.xls
		String name = CodeHelper.getString("BIZ.Report.report_type", "name_", String.valueOf(type)) ;
		

		context.put("report", fetchData(type, name, reportSO)) ;
		
		parser = new ExcelParser("report/" + name + ".xls") ;
		

		parser.parser(context) ;
		
		return parser.getReport() ;
	}
	
	public Report preview(ReportSO reportSO) throws Exception {
		
		short type = reportSO.getReport_type() ;
		
		String name = CodeHelper.getString("BIZ.Report.report_type", "name_", String.valueOf(type)) ;
		
		return fetchData(type, name, reportSO) ;
	}
	
	private Report fetchData(short type, String name, ReportSO reportSO) throws Exception {

		SessionUser su = SessionUser.get() ;
		//if (!su.isHltAccount()) {
		//	reportSO.setSales_id(su.getUser().getId()) ;
		//}
		
    	reportSO.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE) ;
    	
		Report report = null ;
		if (type > 100 && type < 200) {
			//report = unpaid(reportSO, type) ;
		} else {
			try {
				report = (Report)this.getClass().getMethod(
								StringUtils.uncapitalize(name), ReportSO.class).invoke(this, reportSO) ;
			} catch (IllegalArgumentException e) {
				throw e;
			} catch (SecurityException e) {
				throw e;
			} catch (IllegalAccessException e) {
				throw e;
			} catch (InvocationTargetException e) {
				throw (Exception)e.getTargetException() ;
			} catch (NoSuchMethodException e) {
				throw e;
			}
		}
		
		return report ;
	}
	

	

    /**
     * 查询所有订单，用于显示
     * 
     * @param reportSO
     * @return
     */
    public ArrayPageList<Map<String, Object>> queryOrder(ReportSO reportSO) {

    	/*
		SessionUser su = SessionUser.get() ;
		if (!su.isHltAccount()) {
			reportSO.setSales_id(su.getUser().getId()) ;
		}*/
		
    	ArrayPageList<Map<String, Object>> result =
    			(ArrayPageList<Map<String, Object>>)jdbcDao.queryName("reportSQLs:orderDetailForm+orderWhere+orderOrderBy", reportSO, HashMap.class);
    	
    	/*
    	for (Map<String, Object> element:result) {
    		//element.put("sales_name", CodeHelper.get("Sales", "name_cn", element.get("sales_id"))) ;
    		//element.put("company_name", CodeHelper.get("Company", "name_cn", element.get("company_id"))) ;
    		element.put("agent_name", CodeHelper.get("Company", "name_cn", element.get("agent_id"))) ;
    		element.put("status_ship_name", CodeHelper.get("BIZ.Order.status_ship", "name_", element.get("status_ship"))) ;
    		element.put("status_checkout_name", CodeHelper.get("BIZ.Order.status_checkout", "name_", element.get("status_checkout"))) ;
    		element.put("record_status_name", CodeHelper.get("ORD.cancel.yesno", "name_", element.get("record_status"))) ;
    	}*/
    	
    	return result ;
    }
    

	public ArrayPageList<HashMap<String, Object>> distinctOrder(ReportSO so) {

		setReportSO(so) ;
		
		so.setPageIndex(ArrayPageList.PAGEINDEX_NO_PAGE) ;
		return (ArrayPageList<HashMap<String, Object>>)jdbcDao.queryName("reportSQLs:distinctOrder+orderWhere", so, HashMap.class) ;
	}

	
	private void setReportSO(ReportSO so) {
		SessionUser su = SessionUser.get() ;
		
		if ( so.getReport_type() == -1) {
			//so.setAgent_id(su.getUser().getCompany_id());
		} else {
			//if (!su.isHltAccount()) {
			//	so.setSales_id(su.getUser().getId()) ;
			//}
		}
	}

	// ----------------   公用方法  --------------------------------------------------------------------
	
	public ArrayPageList<Map<String, Object>> splitTo2Group(ArrayPageList<Map<String, Object>> details, String[] groupBys, String[] columns) {
		return this.splitTo2Group(details, groupBys, columns, "currency_code") ;
	}
	/**
	 * 通过货币，按货币形式，分成两组数
	 * 
	 * @param details
	 * @param groupBy
	 * @param columns
	 * @return
	 */
	public ArrayPageList<Map<String, Object>> splitTo2Group(ArrayPageList<Map<String, Object>> details, String[] groupBys, String[] columns, String splitColumn) {

		ArrayPageList<Map<String, Object>> result = new ArrayPageList<Map<String, Object>> () ;
		
		ArrayPageList<Map<String, Object>> items = new ArrayPageList<Map<String,Object>>() ;
		
		Object[] current_id = new Object[groupBys.length] ;
		
		for (int i = 0 ; i < details.size() ; i ++) {
			Map<String, Object> detail = details.get(i) ;
			/*
		    if (current_id == null) {
		    	current_id = (Long)detail.get(groupBy) ;
		    }*/
		    
		    //if (current_id.equals((Long)detail.get(groupBy))) {
			if (isEqual(current_id, detail, groupBys)) {
		    	items.add(detail) ;
		    } else {
		    	result.addAll(merger(items, columns, splitColumn)) ;
		    	items.clear() ;
		    	items.add(detail) ;

		    	//current_id = (Long)detail.get(groupBy) ;
		    }
		}

    	result.addAll(merger(items, columns, splitColumn)) ;
		
		return result ;
	}
	
	public boolean isEqual(Object[] keys, Map<String, Object> entity, String[] groupBys) {
		boolean result = true;
				
		for (int i = 0 ; i < groupBys.length ; i ++) {
			String groupBy = groupBys[i] ;
			Object key = entity.get(groupBy) ;
			if(!key.equals(keys[i])) {
				result = false;
				keys[i] = key;
			}
		}
		
		return result ;
	}

	public ArrayPageList<Map<String, Object>> merger(ArrayPageList<Map<String, Object>> items, String[] columns, String splitColumn) {
		ArrayPageList<Map<String, Object>> result = new ArrayPageList<Map<String, Object>> () ;
		String preCurrency = null ;
		
		int j = 0 ;
		
		for (int i = 0 ; i < items.size() ; i ++) {
			final Map<String, Object> detail = items.get(i) ;
			Map<String, Object> resultDetail = null ; 
			/*
			if (preCurrency == null) {
				preCurrency = (String)detail.get(mergerBy) ;
			}*/
			
			String currency = (String)detail.get(splitColumn) ;
			if (preCurrency == null) {
				preCurrency = currency ;
			}
			if (preCurrency.equals(currency)) {
				result.add(detail) ;
				resultDetail = detail ;
			} else {
				if (j >= result.size()) {
					result.add(detail) ;
					resultDetail = detail ;
				} else {
					resultDetail = result.get(j) ;
				}
				j ++ ;
			}			
			for (String column:columns) {
				resultDetail.put(currency.toLowerCase() + "_" + column, detail.get(column)) ;
			}
		}
		
		return result ;
	}
	
	
	private ArrayPageList<Map<String, Object>> orderNoPaidNoRecOrder(ReportSO reportSO) {
        return (ArrayPageList<Map<String, Object>>)jdbcDao.queryName("reportSQLs:orderDetail_NoPaidNoRec_order", reportSO, HashMap.class);
	}
    
    /**
     * 对数据列表，指定列，分拆成树数据
     * 
     * @param details 需要分离成树的数据集
     * @param sperators 作为结点数据
     * @param deep  由0开始
     * @param sorts 指定字段是否先进行排序，null，全不排序
     * @return
     */
	private ArrayPageList<Map<String, Object>> buildTreeList(ArrayPageList<Map<String, Object>> details, String[] sperators, int deep, boolean[] sorts) {

    	ArrayPageList<Map<String, Object>> items = new ArrayPageList<Map<String, Object>>() ;
    	
    	String key = sperators[deep] ;

    	/*
    	if (sorts != null && sorts[deep]) {
    	    Collections.sort(details, new PinyinComparator(key, true, null, null));
    	}
    	*/
    	
    	Object id = -1342098324178332529L ;
    	ArrayPageList<Map<String, Object>> subDetails = null ;
    	Map<Object, ArrayPageList<Map<String, Object>>> subDetailsMap = new HashMap<Object, ArrayPageList<Map<String,Object>>>() ;
    	List<Object> keySet = new ArrayList<Object>() ;
    	
    	for (Map<String, Object> detail : details) {
    		//System.err.println("key =>>" + detail.get(key));
    		if (!id.equals(detail.get(key))) {
    			id = detail.get(key) ;
    			subDetails = subDetailsMap.get(id) ;
    			if (subDetails == null) {
    				subDetails = new ArrayPageList<Map<String,Object>>() ;
    				subDetailsMap.put(id, subDetails) ;
    				keySet.add(id) ;
    			}    			
    		}
    		
			subDetails.add(detail) ;
    	}
    	
    	Map<String, Object> item = null ; 
    	for (Object keyId:keySet) {
    		item = new HashMap<String, Object>() ;
    		items.add(item) ;
    		
    		item.put(key, keyId) ;
    		
    		subDetails = subDetailsMap.get(keyId) ;
    		
			if( deep + 1 < sperators.length) {
				item.put("items", buildTreeList(subDetails, sperators, deep + 1, sorts)) ;
			} else {
				item.put("items", subDetails) ;
			}
    	}
    	
    	return items ;
		
	}
	/*

	private ArrayPageList<Map<String, Object>> buildTreeList(ArrayPageList<Map<String, Object>> details, String[] sperators, int deep, boolean[] sorts) {

    	ArrayPageList<Map<String, Object>> items = new ArrayPageList<Map<String, Object>>() ;
    	
    	String key = sperators[deep] ;

    	if (sorts != null && sorts[deep]) {
    	    Collections.sort(details, new PinyinComparator(key, true, null, null));
    	}
    	
    	Object id = -1L ;
    	ArrayPageList<Map<String, Object>> subDetails = null ;
    	Map<String, Object> item = null ;
    	
    	for (Map<String, Object> detail : details) {
    		if (!id.equals(detail.get(key))) {
    			
    			if (subDetails != null) {
    				if( deep + 1 < sperators.length) {
	        			item.put("items", buildTreeList(subDetails, sperators, deep + 1, sorts)) ;
	    			} else {
	        			item.put("items", subDetails) ;
	    			}
    			}

    			subDetails = new ArrayPageList<Map<String,Object>>() ;
    			
    			item = new HashMap<String, Object>() ;
    			items.add(item) ;
    			
    			id = detail.get(key) ;
    			item.put(key, id) ;
    			
    		}
    		
			subDetails.add(detail) ;
    	}
    	
		// 最后一组需要处理
		if (subDetails != null) {
			if( deep + 1 < sperators.length) {
				item.put("items", buildTreeList(subDetails, sperators, deep + 1, sorts)) ;
			} else {
				item.put("items", subDetails) ;
			}
		}
    	
    	return items ;
		
	} 
	 * */

    /**
     * 按组条件归并后，生成树
     * 
     * @param reportSO   报表SO
     * @param queryName　查询的SQL名
     * @param groupColumns　全分组字段
     * @param deep start from 1
     * @return
     */
	private ArrayPageList<Map<String, Object>> queryGroupTree(ReportSO reportSO, String queryName, String[] groupColumnArray, String[] orderColumnArray, int deep) {
		/*StringBuffer group_columns = new StringBuffer() ;
		for (int i = 0 ; i < deep ; i ++) {
			group_columns.append(", " + groupColumnArray[i]) ;
		}
    	reportSO.setGroup_columns(group_columns.substring(1)) ;
    	*/
		reportSO.setGroup_columns(cat(groupColumnArray, deep)) ;
		reportSO.setOrder_columns(cat(orderColumnArray, deep)) ;
		
		ArrayPageList<Map<String, Object>> proList = (ArrayPageList<Map<String, Object>>)jdbcDao.queryName(queryName, reportSO, HashMap.class);
		
		if (deep == groupColumnArray.length) {// 没以下一级了，不用往下递归
			return proList ;
		}
		
		ArrayPageList<Map<String, Object>> subList = queryGroupTree(reportSO, queryName, groupColumnArray, orderColumnArray, deep + 1) ;
		
		return split(proList, subList, (String[])ArrayUtils.subarray(groupColumnArray, 0, deep)) ;
	}
	
	/**
	 * 根据深度，把字符串用“,“连接在一起
	 * 
	 * @param columnArray
	 * @param deep
	 * @return
	 */
	private String cat(String[] columnArray, int deep) {
		StringBuffer group_columns = new StringBuffer() ;
		for (int i = 0 ; i < deep ; i ++) {
			group_columns.append(", " + columnArray[i]) ;
		}
    	return group_columns.substring(1) ;
	}

	/* *
	 * @deprecated
	 * 
	 * 
	 * @param subList
	 * @param keys
	 * @param deep start from 0
	 * @return
    private ArrayPageList<Map<String, Object>> split(ArrayPageList<Map<String, Object>> subList, String[] keys) {
    	ArrayPageList<Map<String, Object>> proList = new ArrayPageList<Map<String,Object>>() ;

    	String key = keys[keys.length - 1] ;
    	Set<Object> set = new HashSet<Object>() ;
    	
		for (Map<String, Object> item:subList) {
			Object value = item.get(key) ;
			if (!set.contains(value)) {
				Map<String, Object> map = new HashMap<String, Object>() ;
				for (String k:keys) {
				    map.put(k, item.get(k)) ;
				}
				proList.add(map) ;
				set.add(value) ;
			}
		}
    	 
		subList = split(proList, subList, new String[]{key}) ;
		if (keys.length <= 1) {
		    return subList ;
		} else {
			return split(subList, (String[]) ArrayUtils.subarray(keys, 0, keys.length - 1)) ;
		}
    }
	 */
    public ArrayPageList<Map<String, Object>> split(ArrayPageList<Map<String, Object>> proList, ArrayPageList<Map<String, Object>> subList, String[] keys) {

    	int subListSize = subList.size() ;
		for (Map<String, Object> proItem:proList) {
			ArrayPageList<Map<String, Object>> list = new ArrayPageList<Map<String,Object>>() ;
			proItem.put("items", list) ;
			
			for (int i = 0; i < subListSize ; i ++) {
				Map<String, Object> subItem = subList.get(i) ;
				
				boolean isEqual = true ;
				for (String key:keys) {
					if (key.indexOf(".")>0) {
						key = key.substring(key.indexOf(".") + 1) ;
					}
					if (!proItem.get(key).equals(subItem.get(key))) {
						isEqual = false ;
						break ;
					}
				}
				
				if (isEqual) {
					list.add(subItem) ;
				}
			}
		}
		
		return proList;
    }
    
    private ArrayPageList<Map<String, Object>> removeRedundance(
    		ArrayPageList<Map<String, Object>> items, 
    		String[] redundanceColumns){
    	
    	Object preValue = null ;
    	Object curValue = null ;
    	

    	for (int i = 0 ; i < redundanceColumns.length ; i++){
    		String col = redundanceColumns[i] ;
    		String preCol = i > 0?redundanceColumns[i - 1]:null;
    				
    		for(Map<String, Object> item : items){
    			curValue = item.get(col);
    			if (isEqual(preValue, curValue) 
    					&& (preCol == null || item.get(preCol) == null)) {
    				item.put(col, null) ;
    			} else {
    				preValue = curValue ;
    			}
    		}
    	}
    	
    	return items;
    }
    
    private boolean isEqual(Object obj1, Object obj2) {
    	if (obj1 == null && obj2 == null) {
    		return true ;
    	}
    	if (obj1 == null && obj2 != null) {
    		return false ;
    	}
    	return obj2.equals(obj1) ;
    }
}
