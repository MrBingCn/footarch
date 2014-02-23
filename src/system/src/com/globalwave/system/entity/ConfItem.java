package com.globalwave.system.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.globalwave.base.BaseEntity;
import com.globalwave.base.annotations.JsonSkip;

@Entity
@Table(name = "cfg_items")
public class ConfItem extends BaseEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
    private Long sub_id;
    private String name;
    private String ename;
    private String code;
	@JsonSkip
	private String record_status;
	private int sequence;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getSub_id() {
		return sub_id;
	}
	public void setSub_id(Long sub_id) {
		this.sub_id = sub_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getRecord_status() {
		return record_status;
	}
	public void setRecord_status(String record_status) {
		this.record_status = record_status;
	}
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
    public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
}
