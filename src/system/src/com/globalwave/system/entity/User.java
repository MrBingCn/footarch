package com.globalwave.system.entity;


import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.globalwave.base.BaseEntity;
import com.globalwave.base.annotations.Comparison;
import com.globalwave.base.annotations.JsonSkip;
import com.globalwave.base.annotations.Versionable;
import com.globalwave.common.ArrayPageList;
import com.globalwave.common.C;


/**
 *@Transient
 * @author Virgil.Chan
 */
@Entity
@Table(name = "SYS_USER")
@Versionable
public class User extends BaseEntity {

	public final static String STATUS_LOCk = "L" ;
	public final static String TYPE_FOREIGNER_AGENT = "F" ;// 海外代理
	
	
	
	
    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="increment")
    @GenericGenerator(name="user_id_seq", strategy = "increment")
	private Long id  ;
    @Comparison(operator=Comparison.EQ)
    private String login_id ;
    
    /*
     * 如果绑定的未升级用户，通过contact_id对就contact，其contact.compayn_id=user.company_id
     * */
    private Long contact_id ;
    private Long company_id ;
    private Long organization_id ;

	@JsonSkip
    private String password_ ;
    private String name_cn ;
    private String name_en ;
    private String email_ ;
    private String phone_ ;
    private String fax_ ;
    private String qq_account ;
    //private String region_ ;
    private String type_ ;
    private String status_ ;
    private String desc_ ;
    private String shop_code ;
    private String region_code ;
    private Short lock_Count ;
    private Timestamp expired_date ;

    private String old_password_1 ;

    private String city_code ;
    private String mobile  ;

    @Transient
    private String old_password ;
    
    @Transient
    private ArrayPageList<Organization> organizations ;

    @Transient
    private ArrayPageList<Role> roles ;
    

    public User() {
    }
    
    public User(Long id) {
        this.id = id ;
    }
    
    public String getDesc_() {
        return desc_;
    }
    public void setDesc_(String desc_) {
        this.desc_ = desc_;
    }
    public String getEmail_() {
        return email_;
    }
    public void setEmail_(String email_) {
        this.email_ = email_;
    }
    public String getLogin_id() {
    	if (login_id == null) {
    		return null ;
    	}
    	if (C.EMPTY_STRING.equals(login_id)) {
    		return null ;
    	}
        return login_id.toUpperCase();
    }
    public void setLogin_id(String login_id) {
        this.login_id = login_id;
    }

    public String getPassword_() {
        return password_;
    }
    public void setPassword_(String password_) {
        this.password_ = password_;
    }
    public String getStatus_() {
        return status_;
    }
    public void setStatus_(String status_) {
        this.status_ = status_;
    }
    
    public Long getId() {
        return id;
    }
    public void setId(Long user_id) {
        this.id = user_id;
    }
  
    public boolean isLock() {
    	return STATUS_LOCk.equals(status_) ;
    }

	public String getShop_code() {
		return shop_code;
	}

	public void setShop_code(String shop_code) {
		this.shop_code = shop_code;
	}

	public String getRegion_code() {
		return region_code;
	}

	public void setRegion_code(String region_code) {
		this.region_code = region_code;
	}


	/**
	 * 密码输入错误一次，将+1，输入正确后，置0，累计达3次，即锁定用户，禁止任何操作
	 */
	public Short getLock_Count() {
		return lock_Count;
	}

	public void setLock_Count(Short lock_Count) {
		this.lock_Count = lock_Count;
	}

	public String getType_() {
		return type_;
	}

	public void setType_(String type_) {
		this.type_ = type_;
	}

	public String getOld_password() {
		return old_password;
	}

	public void setOld_password(String old_password) {
		this.old_password = old_password;
	}
	public ArrayPageList<Organization> getOrganizations() {
		return organizations;
	}
	public void setOrganizations(ArrayPageList<Organization> organizations) {
		this.organizations = organizations;
	}

	public Long getCompany_id() {
		return company_id;
	}

	public void setCompany_id(Long company_id) {
		this.company_id = company_id;
	}


	public String getName_cn() {
		return name_cn;
	}

	public void setName_cn(String name_cn) {
		this.name_cn = name_cn;
	}

	public String getName_en() {
		return name_en;
	}

	public void setName_en(String name_en) {
		this.name_en = name_en;
	}

	public Timestamp getExpired_date() {
		return expired_date;
	}

	public void setExpired_date(Timestamp expire_date) {
		this.expired_date = expire_date;
	}

	public Long getOrganization_id() {
		return organization_id;
	}

	public void setOrganization_id(Long organization_id) {
		this.organization_id = organization_id;
	}

	public ArrayPageList<Role> getRoles() {
		return roles;
	}

	public void setRoles(ArrayPageList<Role> roles) {
		this.roles = roles;
	}

	public String getPhone_() {
		return phone_;
	}

	public void setPhone_(String phone_) {
		this.phone_ = phone_;
	}

	public Long getContact_id() {
		return contact_id;
	}

	public void setContact_id(Long contact_id) {
		this.contact_id = contact_id;
	}

	public String getOld_password_1() {
		return old_password_1;
	}

	public void setOld_password_1(String old_password_1) {
		this.old_password_1 = old_password_1;
	}
	public String getQq_account() {
		return qq_account;
	}
	
	public void setQq_account(String qq_account) {
		this.qq_account = qq_account;
	}

	public String getFax_() {
		return fax_;
	}

	public void setFax_(String fax_) {
		this.fax_ = fax_;
	}

	public String getCity_code() {
		return city_code;
	}

	public void setCity_code(String city_code) {
		this.city_code = city_code;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
}

