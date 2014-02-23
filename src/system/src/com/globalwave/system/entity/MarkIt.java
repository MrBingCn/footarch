package com.globalwave.system.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.globalwave.base.BaseEntity;

/**
 * 
 * 
 * @author Administrator
 *
 */
@Entity
@Table(name = "cfg_mark_it")
//@Versionable
public class MarkIt extends BaseEntity {
	
    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
	private Long id;
    private Long user_id ;

    private String color             ;
    private String text              ;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
    
    
}



