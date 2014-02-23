package com.globalwave.system.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.globalwave.base.BaseEntity;
import com.globalwave.base.annotations.Versionable;
import com.globalwave.common.ArrayPageList;

@Entity
@Table(name = "SYS_ORGANIZATION")
@Versionable
public class Organization extends BaseEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    private Long id ;
    @Transient
    private Long sys_organization_id ;
    private Long pro_organization_id ;
    private Long company_id ;
    private String name_ ;
    private String code_ ;
    private String desc_ ;
    private Long leader_id ;
    
    private Integer level_ ;
    private Integer order_ ;
    
    private String record_status ;
    
    
    @Transient
    private Long user_id ;
    
    @Transient
    private ArrayPageList<Privilege> privileges ;
    
    public String getDesc_() {
        return desc_;
    }
    public void setDesc_(String desc_) {
        this.desc_ = desc_;
    }
    public String getName_() {
        return name_;
    }
    public void setName_(String name_) {
        this.name_ = name_;
    }
    public Long getPro_organization_id() {
        return pro_organization_id;
    }
    public void setPro_organization_id(Long pro_organization_id) {
        this.pro_organization_id = pro_organization_id;
    }
    public Long getSys_organization_id() {
        return sys_organization_id;
    }
    public void setSys_organization_id(Long sys_organization_id) {
        this.sys_organization_id = sys_organization_id;
    }
    public Long getUser_id() {
        return user_id;
    }
    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public ArrayPageList<Privilege> getPrivileges() {
		return privileges;
	}
	public void setPrivileges(ArrayPageList<Privilege> privileges) {
		this.privileges = privileges;
	}
	public Long getLeader_id() {
		return leader_id;
	}
	public void setLeader_id(Long leader_id) {
		this.leader_id = leader_id;
	}
	public String getRecord_status() {
		return record_status;
	}
	public void setRecord_status(String record_status) {
		this.record_status = record_status;
	}
    public String getCode_() {
		return code_;
	}
    public void setCode_(String code_) {
		this.code_ = code_;
	}
	public Long getCompany_id() {
		return company_id;
	}
	public void setCompany_id(Long company_id) {
		this.company_id = company_id;
	}
	public Integer getLevel_() {
		return level_;
	}
	public void setLevel_(Integer level_) {
		this.level_ = level_;
	}
	public Integer getOrder_() {
		return order_;
	}
	public void setOrder_(Integer order_) {
		this.order_ = order_;
	}
	
	
}
