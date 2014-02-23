package com.globalwave.system.entity;

import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.globalwave.common.entity.AttributeBase;

@Entity
@Table(name = "cfg_Terminal_Attr")
public class TerminalAttribute extends AttributeBase {


    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    @GenericGenerator(name="Terminal_Attribute_id_SEQ", strategy = "increment")
	private Long terminal_attribute_id ;
	private Long terminal_profile_id ;
	private String code_ ;
	private String value_ ;
	
	public Long getTerminal_attribute_id() {
		return terminal_attribute_id;
	}
	public void setTerminal_attribute_id(Long terminal_attribute_id) {
		this.terminal_attribute_id = terminal_attribute_id;
	}
	public Long getTerminal_profile_id() {
		return terminal_profile_id;
	}
	public void setTerminal_profile_id(Long terminal_profile_id) {
		this.terminal_profile_id = terminal_profile_id;
	}
	public String getCode_() {
		return code_;
	}
	public void setCode_(String code_) {
		this.code_ = code_;
	}
	public String getValue_() {
		return value_;
	}
	public void setValue_(String value_) {
		this.value_ = value_;
	}
	
	@Override
	protected AttributeBase newAttribute(Map.Entry<String, Object> entity, Long referenceId) {
		TerminalAttribute attr = new TerminalAttribute() ;
		attr.terminal_profile_id = referenceId ;
		attr.code_ = entity.getKey() ;
		attr.value_ = String.valueOf(entity.getValue()) ;
		return attr;
	}
	
	
	
}
