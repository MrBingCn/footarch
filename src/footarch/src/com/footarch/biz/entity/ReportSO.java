package com.footarch.biz.entity;


import java.sql.Timestamp;

import com.globalwave.base.BaseSO;
import com.globalwave.common.U;

/**
 * 报表的查询条件
 * 
 * @author Virgil.Chen
 *
 */
public class ReportSO extends BaseSO {

		
	private Timestamp start_on ;
	private Timestamp end_on ;


	

	private String group_columns ;
	private String order_columns ;

    
    private short report_type ;
    
	private String order_no;
	private Long agent_id_1;
	private Long agent_id_2;
	private Long agent_id_3;
	private Long agent_id_4;
    
    private String distinct_column ;
    
    
	public Timestamp getStart_on() {
		return start_on;
	}

	public String getStart_on_short() {
		return U.yyyyMMdd_(start_on) ;
	}
	
	public void setLaunch_date_from(Timestamp start_on) {
		this.start_on = start_on;
	}

	public void setStart_on(Timestamp start_on) {
		this.start_on = start_on;
	}

	public Timestamp getEnd_on() {
		return end_on;
	}

	public String getEnd_on_short() {
		return U.yyyyMMdd_(end_on) ;
	}

	public void setLaunch_date_to(Timestamp end_on) {
		this.end_on = end_on;
	}
	
	public void setEnd_on(Timestamp end_on) {
		this.end_on = end_on;
	}

	public String getGroup_columns() {
		return group_columns;
	}

	public void setGroup_columns(String group_columns) {
		this.group_columns = group_columns;
	}

	public String getOrder_columns() {
		return order_columns;
	}

	public void setOrder_columns(String order_columns) {
		this.order_columns = order_columns;
	}
	
	public short getReport_type() {
		return report_type;
	}

	public String getReport_typeAsString() {
		return String.valueOf(report_type);
	}
	
	public void setReport_type(short report_type) {
		this.report_type = report_type;
	}

	

	public String getOrder_no() {
		return this.getLikeValue(order_no);
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}


	public String getDistinct_column() {
		return distinct_column;
	}

	public void setDistinct_column(String distinct_column) {
		if (distinct_column != null && distinct_column.indexOf('.') > 0) {
			distinct_column = distinct_column.substring(distinct_column.indexOf('.') + 1) ;
		}
		this.distinct_column = distinct_column;
	}
	

	public Long getAgent_id_1() {
		return agent_id_1;
	}

	public void setAgent_id_1(Long agent_id_1) {
		this.agent_id_1 = agent_id_1;
	}

	public Long getAgent_id_2() {
		return agent_id_2;
	}

	public void setAgent_id_2(Long agent_id_2) {
		this.agent_id_2 = agent_id_2;
	}

	public Long getAgent_id_3() {
		return agent_id_3;
	}

	public void setAgent_id_3(Long agent_id_3) {
		this.agent_id_3 = agent_id_3;
	}

	public Long getAgent_id_4() {
		return agent_id_4;
	}

	public void setAgent_id_4(Long agent_id_4) {
		this.agent_id_4 = agent_id_4;
	}

	@Override
	public Class<?> getTableClass() {
		return null;
	}

}
