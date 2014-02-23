package com.globalwave.system.entity;

import javax.persistence.Column;

import com.globalwave.base.annotations.Comparison;

public class TerminalProfileCriterion {
    public final static String SQL_STRING = "" ; 

    @Column(name="id")
    private Long[] ids ; 
    
    @Column(name="code_")
    @Comparison(operator="<>")
    private String not_eq_code ;
    private String current_user ;

    public Long[] getIds() {
        return ids;
    }
    public void setIds(Long[] ids) {
        this.ids = ids;
    }
	public String getNot_eq_code() {
		return not_eq_code;
	}
	public void setNot_eq_code(String not_eq_code) {
		this.not_eq_code = not_eq_code;
	}
	public String getCurrent_user() {
		return current_user;
	}
	public void setCurrent_user(String current_user) {
		this.current_user = current_user;
	}
    
    
}
