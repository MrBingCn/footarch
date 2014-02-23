package com.globalwave.system.entity;



import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.globalwave.base.BaseEntity;
import com.globalwave.base.annotations.Versionable;


/**
 *@Transient
 * @author Virgil.Chan
 */
@Entity
@Table(name = "sys_menu")
@Versionable
public class Menu extends BaseEntity {

    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    @GenericGenerator(name="menu_id_seq", strategy = "increment")
    private Long id               ;
    private Long pro_menu_id      ;
    private Long pid              ;
    private String label          ;
    private String url            ;
    private String icon           ;
    private Integer level_        ;
    private Integer order_        ;
    private String record_status  ;
    
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getPro_menu_id() {
		return pro_menu_id;
	}
	public void setPro_menu_id(Long pro_menu_id) {
		this.pro_menu_id = pro_menu_id;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public Integer getLevel_() {
		return level_;
	}
	public void setLevel_(Integer level_) {
		this.level_ = level_;
	}
	public String getRecord_status() {
		return record_status;
	}
	public void setRecord_status(String record_status) {
		this.record_status = record_status;
	}
	public Integer getOrder_() {
		return order_;
	}
	public void setOrder_(Integer order_) {
		this.order_ = order_;
	}
    
    
}

