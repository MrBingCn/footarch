package com.globalwave.system.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.dom4j.Element;
import org.hibernate.annotations.GenericGenerator;

import com.globalwave.base.BaseEntity;
import com.globalwave.common.Convertor;

@Entity
@Table(name = "cfg_terminal")
public class TerminalProfile extends BaseEntity implements Serializable  {

	private static final long serialVersionUID = 1L;
	public final static String STATUS_OPEN = "O" ;
	public final static String STATUS_CLOSE = "C" ;
	
    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    @GenericGenerator(name="terminal_profile_id_SEQ", strategy = "increment")
    private Long terminal_profile_id ;
     private String region_code;
     private String shop_code;
     private String code_;
     private String type_;
     private String name_;
     private String computer_name;
     private String computer_mac;
     private String computer_ip;
     private Integer times_of_relief;
     private Timestamp establish_date;
     private Timestamp sale_date;
     private String current_user;
     private String status_;

     /**
      * 1 is active / 0 is disable 
      */
     private Integer record_status ;

     @Transient
     private List<TerminalAttribute> attributes ;
     
	public Long getTerminal_profile_id() {
		return terminal_profile_id;
	}
	public void setTerminal_profile_id(Long terminal_profile_id) {
		this.terminal_profile_id = terminal_profile_id;
	}
	public String getRegion_code() {
		return region_code;
	}
	public void setRegion_code(String region_code) {
		this.region_code = region_code;
	}
	public String getShop_code() {
		return shop_code;
	}
	public void setShop_code(String shop_code) {
		this.shop_code = shop_code;
	}
	public String getCode_() {
		return code_;
	}
	public void setCode_(String code_) {
		this.code_ = code_;
	}
	public String getType_() {
		return type_;
	}
	public void setType_(String type_) {
		this.type_ = type_;
	}
	public String getName_() {
		return name_;
	}
	public void setName_(String name_) {
		this.name_ = name_;
	}
	public String getComputer_name() {
		return computer_name;
	}
	public void setComputer_name(String computer_name) {
		this.computer_name = computer_name;
	}
	public String getComputer_mac() {
		return computer_mac;
	}
	public void setComputer_mac(String computer_mac) {
		this.computer_mac = computer_mac;
	}
	public String getComputer_ip() {
		return computer_ip;
	}
	public void setComputer_ip(String computer_ip) {
		this.computer_ip = computer_ip;
	}
	public Integer getTimes_of_relief() {
		return times_of_relief;
	}
	public void setTimes_of_relief(Integer times_of_relief) {
		this.times_of_relief = times_of_relief;
	}
	public Timestamp getEstablish_date() {
		return establish_date;
	}
	public void setEstablish_date(Timestamp establish_date) {
		this.establish_date = establish_date;
	}
	public Timestamp getSale_date() {
		return sale_date;
	}
	public void setSale_date(Timestamp sale_date) {
		this.sale_date = sale_date;
	}
	public String getCurrent_user() {
		return current_user;
	}
	public void setCurrent_user(String current_user) {
		this.current_user = current_user;
	}
	public String getStatus_() {
		return status_;
	}
	public void setStatus_(String status_) {
		this.status_ = status_;
	}
	public List<TerminalAttribute> getAttributes() {
		return attributes;
	}
	public void setAttributes(List<TerminalAttribute> attributes) {
		this.attributes = attributes;
	}
	public Integer getRecord_status() {
		return record_status;
	}

	public void setRecord_status(Integer record_status) {
		this.record_status = record_status;
	}

	public void setAttributesMap(Map<String, String[]> entityMap) {
		if (this.attributes == null) {
			this.attributes = new ArrayList<TerminalAttribute>(entityMap.size()) ;
		}
		
		for (String key:entityMap.keySet()) {
			TerminalAttribute t = new TerminalAttribute() ;
			this.attributes.add(t) ;
			
			t.setTerminal_profile_id(terminal_profile_id) ;
			t.setCode_(key) ;
			t.setValue_(entityMap.get(key)[0]) ;
		}
	}
	
	public String asXML() {

        Element root;
		try {
			root = Convertor.object2Xml(this);
			for (TerminalAttribute attr:attributes) {
				root.addElement(attr.getCode_()).addCDATA(attr.getValue_()) ;
			}
		} catch (Exception e) {
			e.printStackTrace() ;
			return null ;
		}
        
        return root.asXML() ;
	}
}
