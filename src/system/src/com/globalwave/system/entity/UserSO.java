package com.globalwave.system.entity;

import javax.persistence.Column;

import com.globalwave.base.BaseSO;
import com.globalwave.base.annotations.Comparison;
import com.globalwave.common.C;

public class UserSO extends BaseSO {
    private Long user_id  ;
    private String status_ ;
    @Comparison(operator = Comparison.EQ)
    private String login_id ;

    @Column(name="login_id")
    private String login_id_like ;
    
    private String password_ ;

    private String name_cn ;
    private String name_en ;
    private String email_ ;

    @Column(name="user_id")
    private Long[] userIds ;


    @Column(name="id")
    private Long[] ids ;

    private Long company_id  ;
    
    private String type_ ;

    @Column(name="contact_id")
    @Comparison(operator = Comparison.IS_NULL)
    private Integer is_not_binding_contact ;
    
    public String getType_() {
		return type_;
	}
	public void setType_(String type_) {
		this.type_ = type_;
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
    public String getName_cn() {
    	if (name_cn == null) {
    		return null ;
    	}
    	if (C.EMPTY_STRING.equals(name_cn)) {
    		return null ;
    	}
        return "%" + name_cn + "%";
    }
    public void setName_cn(String name_) {
        this.name_cn = name_;
    }
    public String getName_en() {
    	if (name_en == null) {
    		return null ;
    	}
    	if (C.EMPTY_STRING.equals(name_en)) {
    		return null ;
    	}
        return "%" + name_en + "%";
    }
    public void setName_en(String name_) {
        this.name_en = name_;
    }
    public String getPassword_() {
        return password_;
    }
    public void setPassword_(String password_) {
        this.password_ = password_;
    }
    public Long getUser_id() {
        return user_id;
    }
    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }
    public Long[] getUserIds() {
        return userIds;
    }
    public void setUserIds(Long[] userIds) {
        this.userIds = userIds;
    }
	public String getLogin_id_like() {
    	if (login_id_like == null) {
    		return null ;
    	}
    	if (C.EMPTY_STRING.equals(login_id_like)) {
    		return null ;
    	}
		return "%" + login_id_like.toUpperCase() + "%";
	}
	public void setLogin_id_like(String login_id_like) {
		this.login_id_like = login_id_like;
	}
	public Long getCompany_id() {
		return company_id;
	}
	public void setCompany_id(Long company_id) {
		this.company_id = company_id;
	}
	
	public Long[] getIds() {
		return ids;
	}
	public void setIds(Long[] ids) {
		this.ids = ids;
	}
	public Integer getIs_not_binding_contact() {
		return is_not_binding_contact;
	}
	public void setIs_not_binding_contact(Integer is_not_binding_contact) {
		this.is_not_binding_contact = is_not_binding_contact;
	}
	
	public String getStatus_() {
		return status_;
	}
	public void setStatus_(String status_) {
		this.status_ = status_;
	}
	@Override
	public Class<?> getTableClass() {
		return User.class;
	}
}
