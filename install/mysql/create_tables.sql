drop table if exists sys_user;

drop table if exists sys_organization;

drop table if exists sys_organization_privilege;

drop table if exists sys_privilege;

drop table if exists sys_user_organization;

drop table if exists cfg_dict;

drop table if exists cfg_message;

drop table if exists sys_op_log;

drop table if exists biz_company;

/*==============================================================*/
/* Table: SYS_USER                                              */
/*==============================================================*/
create table sys_user  (
   id                 bigint(12)                      not null AUTO_INCREMENT,
   contact_id         bigint(12) comment '与联系人绑定的标识',
   login_id           VARCHAR(16),
   Region_Code        VARCHAR(8)                     default '',
   Shop_Code          VARCHAR(8)                     default '',
   name_cn            VARCHAR(250),
   name_en            VARCHAR(250),
   email_             VARCHAR(250),
   phone_             VARCHAR(250),
   fax_               VARCHAR(250),
   qq_account         VARCHAR(250),
   desc_              VARCHAR(250),
   password_          VARCHAR(250),
   old_password_1     VARCHAR(250),
   old_password_2     VARCHAR(250),
   Password_Changed_On TIMESTAMP,
   Effective_Date     TIMESTAMP,
   Expired_Date       TIMESTAMP,
   Supervisor_Flag    CHAR(1),
   Lock_Flag          CHAR(1),
   Lock_Count         bigint(12),
   company_id         bigint(12),
   organization_id         bigint(12),
   status_            char(1),
   type_            char(1),
   city_code            varchar(5),
   mobile               varchar(25),
    
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   
   constraint PK_SYS_USER primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: SYS_organization                                    */
/*==============================================================*/
create table sys_organization  (
   id                 bigint(12)                      not null AUTO_INCREMENT,
   pro_organization_id bigint(12)                     default 0,
   company_id         bigint(12)                     default 0,
   code_              VARCHAR(8)                     default '',
   name_              VARCHAR(64),
   desc_              VARCHAR(64),
   leader_id         bigint(12),
    
   level_               int comment '层次',
   order_               int comment '先后顺序',
   
   record_status     CHAR(1) default 'A' NOT NULL,
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   
   constraint PK_SYS_ORGANIZATION primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: SYS_organization_privilege                          */
/*==============================================================*/
create table sys_organization_privilege  (
   organization_id    bigint(12)                     default 0 not null,
   privilege_id       bigint(12)                     default 0 not null,
   constraint PK_SYS_ORGANIZATION_PRIVILEGE primary key (organization_id, privilege_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: SYS_privilege                                       */
/*==============================================================*/
create table sys_privilege  (
   id                 bigint(12)                      not null AUTO_INCREMENT,
   pro_privilege_id   bigint(12)                     default 0,
   code_              int,
   name_              VARCHAR(64),
   url_               VARCHAR(250),
   desc_              VARCHAR(256),
   constraint PK_SYS_PRIVILEGE primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: SYS_user_organization                               */
/*==============================================================*/
create table sys_user_organization  (
   organization_id    bigint(12)                     default 0 not null,
   user_id            bigint(12)                     default 0 not null,
   constraint PK_SYS_USER_ORGANIZATION primary key (organization_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: CFG_DICT                                              */
/*==============================================================*/
create table cfg_dict  (
   id                 bigint(12)                      not null AUTO_INCREMENT,
   pro_dict_id        bigint(12)                     default 0,
   domain_            VARCHAR(64),
   code_              VARCHAR(64),
   name_              text(1000),
   desc_              VARCHAR(256),
   flag_              CHAR(1),
   status_            CHAR(1),
   order_             int(8),
   ext_s1               varchar(250),
   ext_s2               varchar(250),
   ext_s3               varchar(250),
   ext_s4               varchar(250),
   ext_s5               varchar(250),
   constraint PK_CFG_DICT primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: CFG_Message                                         */
/*==============================================================*/
create table cfg_message  (
   ID                   bigint(12)                      not null AUTO_INCREMENT,
   CODE_                bigint(12)                     default 0,
   VALUE_               VARCHAR(1024),
   VALUE_en               VARCHAR(1024),
   constraint PK_CFG_MESSAGE primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table sys_op_log  (
   id                 bigint(12)                     not null AUTO_INCREMENT,
   order_id           bigint(12)                     not null,
   user_id            bigint(12)                     not null,
   user_name          VARCHAR(50),
   biz_data           VARCHAR(2500),
   created_by         varchar(50) comment '创建的操作员Login_ID',
   created_on         datetime comment '创建的时间',
   updated_by         varchar(50) comment '更新的操作员Login_ID',
   updated_on         datetime comment '更新的时间，同时用作version_id',
   version_id         bigint comment '用于做DAO层的版本控制',
   constraint PK_SYS_OP_LOG primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**
 * 报价单
 */
drop table if exists biz_order;
create table biz_order ( 
   id                BIGINT(12) NOT NULL AUTO_INCREMENT, 
   order_no          VARCHAR(20) comment '订单号',  
   company_id        BIGINT(12) NOT NULL comment '客户id', 
   related_company_id BIGINT(12) NOT NULL comment '相关客户id，发货人或收货人', 
   related_user_id   BIGINT(12) NOT NULL comment '相关客户的登录帐号id', 
   contact_oversear  bigint(12) comment '相关业务员id',
   company_name      VARCHAR(100) comment '客户名称',
   company_type      int default 1 comment '客户类型：1：发货方，2：收货方',
   contact_person    bigint(12) comment '联系人',
   agent_contact     bigint(12) comment '海外代理联系人（收发货，通知人）',
   biz_type          int default 0 comment '业务类型',
   delegate_type     int comment '委托类型',
   mbl_type          int comment 'mbl海运提单类型', 
   mbl_no            VARCHAR(20) comment '海运提单号',
   hbl_type          int comment 'hlt提单类型',
   hbl_no            VARCHAR(20) comment 'hlt海运提单号',
   pono              VARCHAR(50) comment 'pono号',
   so_no             VARCHAR(20) comment 'agent ref no', 
   delegate_no       VARCHAR(50) comment '委托单号',
   trans_terms       int comment '运输条款',
   trans_terms_hbl   int comment '运输条款',
   charge_terms      int comment 'mbl运费条款',
   charge_terms_hbl  int comment 'hbl运费条款',
   consignor         text comment '发货人',
   consignee         text comment '收货人',
   notifier          text comment '通知人',
   boat_company_id   BIGINT(12) comment '船公司id',
   boat_time         VARCHAR(50) comment '船期',
   boat_name         varchar(100) comment '船名',
   voyage            varchar(100) comment '航次',
   voyage2           varchar(100) comment '约号',
   
   enchase_type      int default 501 not null comment '装箱方式',
   clearance_type    int default 401 comment '报关方式',
   clearance_split   int default 0 comment '是否分票报关',
   clearance_num     int comment '分票报关数量',

   container_20      int(4) comment '20寸货柜数量',
   container_40      int(4),
   container_45      int(4),
   other_container   VARCHAR(100),
   goods_name        VARCHAR(255) comment '货物名称',
   goods_mark        VARCHAR(255) comment '货物MARK',
   goods_num         int comment '货物件数',
   goods_weight      decimal(12,3) comment '货物毛重',
   goods_volume      decimal(12,3) comment '货物体积',
   goods_unit        int default 1249 comment '货物单位',
   goods_type        VARCHAR(100) comment '货物类型id',
   
   money_invalid     datetime comment '报价有效期',
   launch_date_book  datetime comment '预计开航日',
   place_time        datetime comment '装箱时间',
   end_time          datetime comment '完成时间',
   package_date_book datetime comment '预约装箱日期',
   broker_end_date   datetime comment '截关日期',
   launch_date       datetime comment '开船日期',
   arrive_date       datetime comment '到港日期',
   broker_date       datetime comment '报关日期',
   sign_date         datetime comment '签单日期',
   sent_date         datetime comment '送单日期',
   pre_alert_date    datetime comment 'Pre-Alert日期',

   port_charge       BIGINT(12) comment '付款地点',
   port_ship         BIGINT(12) comment '收货地',
   port_ship_name    varchar(100) comment '收货地',
   port_loading      BIGINT(12) comment '装货港',
   port_loading_name varchar(100) comment '装货港',
   port_change       BIGINT(12) comment '中转港',
   port_target       BIGINT(12) comment '卸货港',
   port_target_name  varchar(100) comment '卸货港',
   port_delivery     BIGINT(12) comment '交货地',
   port_end          BIGINT(12) comment '目的地',
   port_end_name     varchar(100) comment '目的地',
   line              varchar(100) comment '航线',
   package_port      BIGINT(12) comment '进港码头', 

   money_type         varchar(10) default 'RMB' NOT NULL comment 'RMB：人民币，USD：美元',
   money_all_in       decimal(12,2),
   
   agent_id          BIGINT(12) comment '内部代理', 
   boat_agent_id     BIGINT(12) comment '船代', 
   abroad_agent_id   BIGINT(12) comment '海外代理', 
   car_id            BIGINT(12) comment '车队id', 
   storage_id        BIGINT(12) comment '仓库id',
   broker_id         BIGINT(12) comment '报关行id', 

   record_status     CHAR(1) default 'A' NOT NULL,
   status            CHAR(2) default '0' NOT NULL comment '订单状态: 询价单(0)，客服已报价(1)，客人已确认(2)，客人暂不确认(-1)，客人删除(-2)，正式订单(3)',
   status_ship       CHAR(2) default '-1' NOT NULL comment '未处理(-1),未放舱(0)，已开船(1)，已放舱(2)',
   status_fee        CHAR(1) default '0' NOT NULL comment '初始状态(0), 待商务审核(1), 待商务复核(2), 待客服复核(3)',
   status_checkout   CHAR(1) default '9' NOT NULL comment '未可结算(9)，待结算(0)，已结算盈利(1)，已结算亏损(2)，已结算没利润(3)',
   status_car        CHAR(1) default '0' NOT NULL comment '装箱信息：未安排(0), 已安排(1)，已进港(2)', 
   status_broker     CHAR(1) default '0' NOT NULL comment '未处理(0)，已申报(1), 海关查验（2），已放行(3)', 
   status_confirm    CHAR(1) default '0' NOT NULL comment '初始化(0), 待确认费用(1)，费用已确认(2)', 
   status_sign       CHAR(1) default '0' NOT NULL comment '未签单(0), 已签单(1)', 
   status_sent       CHAR(1) default '0' NOT NULL comment '未寄送(0), 已寄送(1)，已电放(2)', 
   pre_alert         CHAR(1) default '0' NOT NULL comment '未做(0), 已做(1)', 
   status_agent      CHAR(1) default '0' NOT NULL comment '海外代理确认状态，unfinished(0), finished(1)', 
   status_alert      CHAR(1) default '0' NOT NULL comment '截关前两天提示，不提示(0), 提示(1)', 
   status_doc        CHAR(1) default '0' NOT NULL comment '单据状态，未完成(0), 已完成(1)', 
   status_finish     CHAR(1) default '0' NOT NULL comment '归档状态，未完成(0), 已完成(1)', 
   status_order      int(1) default 0 NOT NULL comment '询价单(0)，订单(1)'
   next_op           CHAR(1) default '0' NULL comment '下一操作者：hlt客服(1)，客户(2)，hlt操作员(3), 商务员（4）,单证员（5），财务（6）',

   marks             varchar(250) comment '标签ID串，以[,]分隔',
   remark_price      text comment '备注（客服报价)',
   remark_order      text comment '备注（商务)',
   remark_ladding    text comment '装箱要求',
   
   op_operator       varchar(50) comment 'hlt操作员',
   op_operator_name  VARCHAR(50), 
   op_customer       varchar(50),
   op_car            varchar(50),
   op_storage        varchar(50),
   op_boat_agent     varchar(50),
   op_broker         varchar(50),
   op_abroad_agent   varchar(50),
   op_operator_time  datetime comment '操作员第一次操作时间',
	
   sales_id          BIGINT(12) NOT NULL comment '客服id', 
   sales_name        VARCHAR(50), 
   sales_full_name   VARCHAR(100), 
   bus_id            BIGINT(12) comment '商务员id', 
   bus_name          VARCHAR(50), 
   spe_id            BIGINT(12) comment '单证员id', 
   spe_name          VARCHAR(50), 

   usd_balance       decimal(12,2),
   usd_AR_balance    decimal(12,2),
   usd_AP_balance    decimal(12,2),
   usd_account_receivable decimal(12,2),
   usd_account_payable    decimal(12,2),
   usd_account_received decimal(12,2),
   usd_account_paid  decimal(12,2),
   cny_balance       decimal(12,2),
   cny_account_receivable decimal(12,2),
   cny_account_payable    decimal(12,2),
   cny_account_received decimal(12,2),
   cny_account_paid decimal(12,2),
   cny_ar_balance   decimal(12,2),
   cny_ap_balance   decimal(12,2),
   usd_ar_adjust   decimal(12,2),
   usd_ap_adjust   decimal(12,2),
   cny_ar_adjust   decimal(12,2),
   cny_ap_adjust   decimal(12,2),
   usd_currency_rate decimal(12,2),
   invoice_title_usd varchar(200),
   invoice_title_rmb varchar(200),
   
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',

   goods_asign       CHAR(1) default '0' NOT NULL comment '是否是指定货，否(0), 是(1)',
   package_type      int comment '装箱方',  
   package_get_date  datetime comment '提箱日期', 
   package_date      datetime comment '进港日期', 
   package_get       int comment '提箱堆场', 
   tax_refund_doc_on datetime comment '核料日期',
   tax_rebate_on     datetime comment '退税日期',
   broker_no         VARCHAR(50) comment '报关单号',
   contact_car       bigint(12) comment '发货人id',
   container_total   int(4) comment '货柜总数',
   
   ar_ap_remark      text,
   
   constraint PK_BIZ_ORDER primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists biz_order_delivery;
create table biz_order_delivery ( 
   id                BIGINT(12) NOT NULL AUTO_INCREMENT, 
   order_id          BIGINT(12) NOT NULL,
   name              VARCHAR(50) NOT NULL comment '订单名称',
   type              CHAR(1) NOT NULL comment '提单类型 M：MBL，H:Hbl',
   biz_data          VARCHAR(2500) NOT NULL comment 'json数据',
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   constraint PK_BIZ_ORDER_DELIVERY primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists biz_order_port ;
create table biz_order_port  (
   id                 bigint(12)        not null AUTO_INCREMENT,
   port_id            bigint(12)        not null,
   port_name          varchar(100),     
   company_id         bigint(12)        not null,
   type               CHAR(1)           not null,
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   constraint PK_BIZ_ORDER_PORT primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists biz_order_car ;
create table biz_order_car  (
   id                 bigint(12)        not null AUTO_INCREMENT,
   order_id           bigint(12)        not null,
   box_no             VARCHAR(50) comment '箱号',
   package_no         VARCHAR(50) comment '封箱号',
   delivery_no        VARCHAR(50) comment '提单号',
   car_no             varchar(50)        not null,
   driver             varchar(50),     
   mobile             varchar(50),
   goods_num         int default 0 comment '货物件数',
   goods_weight      decimal(12,3) comment '货物毛重',
   goods_volume      decimal(12,3) comment '货物体积',
   goods_unit        int default 1249 comment '货物单位',
   package_get       int comment '提箱堆场', 
   package_get_date  datetime comment '提箱日期', 
   package_date      datetime comment '进港日期', 
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   constraint PK_BIZ_ORDER_CAR primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists biz_order_broker ;
create table biz_order_broker  (
   id                bigint(12)        not null AUTO_INCREMENT,
   order_id          bigint(12)        not null,
   broker_no         VARCHAR(50) comment '报关单号',
   broker_title      VARCHAR(50) comment '报关抬头',
   tax_rebate_on     datetime comment '退单日期',
   tax_refund_doc_on datetime comment '核料日期',
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   constraint PK_BIZ_ORDER_BROKER primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists biz_order_goodstype ;
create table biz_order_goodstype  (
   id                bigint(12)        not null AUTO_INCREMENT,
   order_id          bigint(12)        not null,
   goods_type_id     bigint(12) not null comment '货物类型',
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   constraint PK_BIZ_ORDER_GOODSTYPE primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists biz_agent_contact ;
create table biz_agent_contact  (
   id                bigint(12)        not null AUTO_INCREMENT,
   company_id        bigint(12)        not null comment '海外代理公司id',
   code              varchar(50) not null comment '代码',
   consignor         text comment '发货人',
   consignee         text comment '收货人',
   notifier          text comment '通知人',
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   constraint PK_BIZ_ORDER_GOODSTYPE primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: sys_user_role                                       */
/*==============================================================*/
drop table if exists sys_user_role ;
create table sys_user_role  (
   role_id            bigint                     default 0 not null,
   user_id            bigint                     default 0 not null,
   constraint PK_SYS_USER_ROLE primary key (role_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


drop table if exists sys_role ;

/*==============================================================*/
/* Table: sys_role                                            */
/*==============================================================*/
create table sys_role  (
   id                 bigint                     not null  AUTO_INCREMENT,
   pro_role_id        bigint                     default 0,
   code_              VARCHAR(8)                     default '',
   name_              VARCHAR(64),
   desc_              VARCHAR(64),
    
   record_status     CHAR(1) default 'A' NOT NULL,
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   constraint PK_SYS_ROLE primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists sys_role_privilege ;

/*==============================================================*/
/* Table: sys_role_privilege                                  */
/*==============================================================*/
create table sys_role_privilege  (
   role_id            bigint                     default 0 not null,
   privilege_id       bigint                     default 0 not null,
   constraint PK_SYS_ROLE_PRIVILEGE primary key (role_id, privilege_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**
 * 配置
 */
drop table if exists cfg_subject;
CREATE TABLE cfg_subject ( 
   id                 bigint not null  AUTO_INCREMENT,
   name               VARCHAR(255) not null,
   record_status      CHAR(1) default 'A' NOT NULL, 
   constraint PK_CFG_SUBJECT primary key (id) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists cfg_items;
CREATE TABLE cfg_items ( 
   id                 bigint NOT NULL  AUTO_INCREMENT,
   sub_id             bigint NOT NULL, 
   code              VARCHAR(100) NULL, 
   name               VARCHAR(100) NOT NULL, 
   ename              VARCHAR(100) NULL, 
   record_status      CHAR(1) default 'A' NOT NULL, 
   sequence           INT default 0 NOT NULL, 
   constraint PK_CFG_ITEMS primary key (id) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**
 * 付款方式
 */
 
drop table if exists cfg_payment_method;
CREATE TABLE cfg_payment_method ( 
   id                 bigint NOT NULL  AUTO_INCREMENT, 
   code               VARCHAR(100) NULL, 
   name               VARCHAR(100) NULL, 
   payment_code       VARCHAR(100) NULL, 
   payment_name       VARCHAR(100) NULL, 
   record_status      CHAR(1) default 'A' NOT NULL, 
   sequence           INT default 0 NOT NULL, 
   constraint PK_CFG_ITEMS primary key (id) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**
 * 国家&港口&航线&船公司
 */
drop table if exists cfg_port;
CREATE TABLE cfg_port ( 
   id                 bigint NOT NULL  AUTO_INCREMENT,
   code               VARCHAR(20) NOT NULL, 
   name               VARCHAR(100) NOT NULL, 
   country_code       varchar(25),
   line_id            bigint, 
   record_status      CHAR(1) default 'A' NOT NULL, 
   sequence           INT default 0 NOT NULL, 
   constraint PK_CFG_PORT primary key (id) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists cfg_country;
CREATE TABLE cfg_country ( 
   id                 bigint NOT NULL  AUTO_INCREMENT,
   name               VARCHAR(100), 
   ename              VARCHAR(200), 
   code               VARCHAR(20), 
   code1              VARCHAR(20), 
   line               VARCHAR(20), 
   record_status      CHAR(1) default 'A' NOT NULL, 
   sequence           INT default 0 NOT NULL, 
   constraint PK_CFG_COUNTRY primary key (id) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists cfg_line;
CREATE TABLE cfg_line ( 
   id                 bigint NOT NULL  AUTO_INCREMENT,
   name               VARCHAR(100) NOT NULL, 
   area               VARCHAR(20) NOT NULL, 
   record_status      CHAR(1) default 'A' NOT NULL, 
   sequence           INT default 0 NOT NULL, 
   constraint PK_CFG_LINE primary key (id) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists cfg_boat_company;
CREATE TABLE cfg_boat_company ( 
   id                 bigint NOT NULL  AUTO_INCREMENT,
   code               VARCHAR(100), 
   name               VARCHAR(100), 
   ename              VARCHAR(100), 
   shipper            VARCHAR(100),
   company_type       int comment '1:航海公司，2航空公司',
   record_status      CHAR(1) default 'A' NOT NULL, 
   sequence           INT default 0 NOT NULL, 
   constraint PK_CFG_BOAT_COMPANY primary key (id) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
 * 
 * acount
 * 
 * */
drop table if exists biz_ar_ap;

/*==============================================================*/
/* Table: biz_ar_ap                                             */
/*==============================================================*/
create table biz_ar_ap
(
   id                   bigint not null auto_increment comment '标识',
   pro_ar_ap_id         bigint,
   order_id             bigint,
   fee_item_code    varchar(50) comment '对应费项代码表，费项如：O/F,BAF,CAF,AMS等',
   pro_fee_item_code     varchar(50) ,
   ar_ap_flag           int comment '本项是应收项还是收付项',
   hlt_company_id       bigint,
   company_id           bigint,
   related_party_id     bigint,
   role_code            varchar(50) comment '公司内部、船东、船代运杂等，跟角色表对应',
   prepaid_collect_flag varchar(1),
   currency_code        varchar(3),
   currency_rate        decimal(6,2),
   amount               decimal(12,2) comment '应收应付',
   amount_ed            decimal(12,2) comment '实收实付',
   adjust               decimal(12,2),
   balance              decimal(12,2),
   accrued_amount       decimal(12,2) default 0,
   status               varchar(1),
   is_displayable       int  default 1,
   is_updateable        int  default 1,
   is_deleteable        int  default 1,
   invoice_title        varchar(250) comment '发票抬头',
   invoice_code         varchar(500),
   invoice_type         int comment '0:不开票、1:普通票、2:增值税票等',
   invoice_date         date comment '开票日期',
   zt002                decimal(12,2) comment '公帐',
   zt002_date           date comment '公帐到帐时间',
   zt003                decimal(12,2),
   zt003_date           date comment '公帐到帐时间',
   remark               varchar(500),
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by            varchar(50) comment '更新的操作员Login_ID',
   updated_on            datetime comment '更新的时间，同时用作version_id',
   version_id             bigint comment '用于做DAO层的版本控制',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



drop table if exists biz_ar_ap_log;

/*==============================================================*/
/* Table: biz_ar_ap                                             */
/*==============================================================*/
create table biz_ar_ap_log
(
   id                   bigint not null auto_increment comment '标识',
   ar_ap_id             bigint,
   order_id             bigint,
   operation            int comment '-1:减，0:不变，1:加，9:重新汇总(删除应收记录)',
   amount               decimal(12,2) comment '应收应付',
   operator             varchar(50) comment '操作员Login_ID',
   log_on               datetime comment '日志时间',
   operator_name        varchar(250) comment '操作员名字',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;







drop table if exists biz_ar_ap_transaction;

/*==============================================================*/
/* Table: biz_ar_ap_transaction                                 */
/*==============================================================*/
create table biz_ar_ap_transaction
(
   id                   bigint not null auto_increment comment '标识',
   ar_ap_id             bigint,
   order_id             bigint,
   amount               decimal(12,2),
   currency_rate        decimal(6,2),
   entry_date           date,
   account_to           varchar(50),
   invoice_flag         int comment '不开票(0);D/N抬头(1);已开发票(2)',
   company_id           bigint,
   contact_id           bigint,
   remark               varchar(500),
   print_times          int default 0 comment '打印次数，递增1',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by            varchar(50) comment '更新的操作员Login_ID',
   updated_on            datetime comment '更新的时间，同时用作version_id',
   version_id             bigint comment '用于做DAO层的版本控制',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: biz_company                                           */
/*==============================================================*/
drop table if exists biz_company;
create table biz_company
(
   id                   bigint not null auto_increment comment '标识',
   pro_company_id       bigint,
   customer_service_rep bigint comment 'Customer_Service_Representatives 客服代表', 
   customer_service_reps varchar(250),
   default_operator     bigint comment '预设操作员',
   invoice_title        varchar(250) comment '默认的发票抬头',
   invoice_type         int comment '0:不开票、1:普通票、2:增值税票等',
   name_short           varchar(50),
   name_cn              varchar(250),
   name_en              varchar(250),
   company_type         int comment '船代、客户等',
   customer_type        int comment '生产厂商、因内贸易商、境外采购商。。等',
   tip_code             varchar(50),
   address              varchar(500),
   phone                varchar(25),
   fax                  varchar(25),
   country_code         varchar(25),
   ext_s1               varchar(250),
   ext_s2               varchar(250),
   ext_s3               varchar(250),
   ext_s4               varchar(250),
   consignor         text comment '发货人',
   consignee         text comment '收货人',
   notifier          text comment '通知人',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by            varchar(50) comment '更新的操作员Login_ID',
   updated_on            datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table if exists biz_contact;

/*==============================================================*/
/* Table: biz_contact                                           */
/*==============================================================*/
create table biz_contact
(
   id                   bigint not null auto_increment comment '标识',
   company_id           bigint,
   user_id              bigint,
   name_cn              varchar(250),
   name_en              varchar(250),
   contact_type         int default 1 comment '发货人或收货人或空',
   position             int default 9 comment '职位',
   country_code         varchar(5),
   city_code            varchar(5),
   phone                varchar(25),
   mobile               varchar(25),
   fax                  varchar(25),
   qq_account           varchar(25),
   msn_account          varchar(25),
   im_account           varchar(25),
   email                varchar(250),
   post_code            varchar(10),
   address              varchar(500),
   address_bill         varchar(500),
   default_contact      int  default 0,
   is_prepay            int default 0 comment '是否预付',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by            varchar(50) comment '更新的操作员Login_ID',
   updated_on            datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



drop table if exists sys_event_log;


/*==============================================================*/
/* Table: sys_event_log                                       */
/*==============================================================*/
create table sys_event_log  (
   id                 bigint                          not null  auto_increment,
   event_type_code    VARCHAR(8)                     default '',
   desc_              VARCHAR(256),
   user_id            bigint(12)                     default 0,
   user_name          VARCHAR(250),
   thread_id          bigint(12)                     default 0,
   biz_id             bigint(12)                     default 0,
   biz_data           VARCHAR(2500),
   version_id         bigint,
   record_status      char(1),
   created_by         varchar(50),
   created_on         datetime,
   update_by          varchar(50),
   update_on          datetime,
   ext_c1             varchar(150),
   ext_c2             varchar(150),
   ext_c3             varchar(150),
   ext_c4             varchar(150),
   ext_c5             VARCHAR(2500),
   ext_n1             decimal(12,2),
   ext_n2             decimal(12,2),
   constraint PK_SYS_EVENT_LOG primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



drop table if exists biz_invoice_ar_ap;

/*==============================================================*/
/* Table: biz_invoice_ar_ap                                     */
/*==============================================================*/
create table biz_invoice_ar_ap
(
   invocie_detail_id    bigint not null,
   ar_ap_transaction_id bigint not null,
   record_status        char(1),
   primary key (invocie_detail_id, ar_ap_transaction_id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;




drop table if exists biz_invoice_detail;

/*==============================================================*/
/* Table: biz_invoice_detail                                    */
/*==============================================================*/
create table biz_invoice_detail
(
   id                   bigint not null auto_increment comment '标识',
   invoice_id           bigint,
   item_code            varchar(50),
   quantity             decimal(12, 2),
   unit_price           decimal(6,2),
   currency             varchar(5),
   amount               decimal(12, 2),
   remark               varchar(250),
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by            varchar(50) comment '更新的操作员Login_ID',
   updated_on            datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;




drop table if exists biz_invoice;

/*==============================================================*/
/* Table: biz_invoice                                           */
/*==============================================================*/
create table biz_invoice
(
   id                   bigint not null auto_increment comment '标识',
   order_id             bigint,
   invoice_code         varchar(50),
   invoice_number       varchar(50),
   invoice_date         date,
   invoice_month        int,
   industry_type int,
   invoice_title        varchar(250),
   amount               decimal(12,2),
   currency_code             varchar(5),
   signature            varchar(250),
   bank_name            varchar(250),
   bank_account         varchar(250),
   sheet_maker_id       varchar(50),
   sheet_maker_name     varchar(250) comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   version_id           bigint,
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by            varchar(50) comment '更新的操作员Login_ID',
   updated_on            datetime comment '更新的时间，同时用作version_id',
   ext_str_1            varchar(150) comment 'ext_*为扩展字段，暂时保留
            *_str_*为扩展字段类型为string,*_num_*为数字型
            ',
   ext_str_2            varchar(150),
   ext_str_3            varchar(150),
   ext_str_4            varchar(150),
   ext_str_5            varchar(150),
   ext_num_1            decimal(12,2),
   ext_num_2            decimal(12,2),
   ext_num_3            decimal(12,2),
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: 价格参考表                                    */
/*==============================================================*/
drop table if exists biz_price ;
create table biz_price  (
   id            bigint(12)        not null AUTO_INCREMENT,
   pod           VARCHAR(100),
   carrier       VARCHAR(100),
   gp20          VARCHAR(100),
   gp40          VARCHAR(100),
   hq40          VARCHAR(100),
   cy_closing    VARCHAR(100),
   etd           VARCHAR(100),
   tt            VARCHAR(100),
   terminal      VARCHAR(100),
   valid_fm      VARCHAR(100),
   valid_till    VARCHAR(100),	
   routing       VARCHAR(100),
   remark        VARCHAR(200),
   constraint PK_BIZ_PRICE primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



drop table if exists biz_fee_item;

/*==============================================================*/
/* Table: biz_fee_item                                      */
/*==============================================================*/
create table biz_fee_item
(
   id                   bigint not null auto_increment comment '标识',
   pro_fee_item_id  bigint comment '父费项ID',
   code_                varchar(50) comment '费项代码',
   name_cn              varchar(50) comment '费项中文名称',
   name_en              varchar(50) comment '费项英文名',
   order_               int comment '先后顺序',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by           varchar(50) comment '更新的操作员Login_ID',
   updated_on           datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table biz_fee_item comment '会计科目/帐目类型，当前只考虑作两级';















drop table if exists biz_document;

/*==============================================================*/
/* Table: biz_fee_item                                      */
/*==============================================================*/
create table biz_document
(
   id                   bigint not null auto_increment comment '标识',
   order_id             bigint comment '订单ID',
   company_id             bigint comment '公司ID',
   folder_name          varchar(6) comment 'yyyymm作为文档的文件夹，不可改',
   file_uuid            varchar(36) comment '文件的uuid，作为系统文件名称，不可改',
   document_name        varchar(150) comment '文档名称',
   document_type        varchar(1) comment '文档类型',
   desc_                varchar(500) comment '文档描述',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   order_               int comment '记录顺序',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by           varchar(50) comment '更新的操作员Login_ID',
   updated_on           datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table biz_document comment '订单相关的文件记录，记录简要信息及物理位置';



drop table if exists cfg_template;

/*==============================================================*/
/* Table: biz_fee_item                                      */
/*==============================================================*/
create table cfg_template
(
   id                   bigint not null auto_increment comment '标识',
   code_                varchar(50) comment '编码',
   name_                varchar(250) comment '名称',
   title_               varchar(250) comment '标题',
   content_             text comment '模板内容',
   version_             int comment '版本',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   order_               int comment '记录顺序',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by           varchar(50) comment '更新的操作员Login_ID',
   updated_on           datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table cfg_template comment '模板配置表';





drop table if exists biz_message;

/*==============================================================*/
/* Table: biz_fee_item                                      */
/*==============================================================*/
create table biz_message
(
   id                   bigint not null auto_increment comment '标识',
   subject              varchar(250) comment '标题',
   orderId              bigint comment '订单id',
   content              text comment '内容',
   ext_s1               varchar(250) comment '扩展字段1',
   ext_s2               varchar(250) comment '扩展字段2',
   ext_s3               varchar(250) comment '扩展字段3',
   type                 CHAR(1) default '1' NOT NULL comment '系统信息（0）,非系统信息（1）,asm提醒信息（2）,费用确认信息（3）',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by           varchar(50) comment '更新的操作员Login_ID',
   updated_on           datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table biz_message comment '信息表';


drop table if exists biz_message_receive;

/*==============================================================*/
/* Table: biz_fee_item                                      */
/*==============================================================*/
create table biz_message_receive
(
   id                   bigint not null auto_increment comment '标识',
   message_id           bigint not null comment '标识',
   user_id              bigint comment '标识',
   company_id           bigint comment '标识',
   read_on              datetime comment '读取时间',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by           varchar(50) comment '更新的操作员Login_ID',
   updated_on           datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table biz_message_receive comment '信息接收表';


drop table if exists cfg_mark_it;

/*==============================================================*/
/* Table: cfg_mark_it                                      */
/*==============================================================*/
create table cfg_mark_it
(
   id                   bigint not null auto_increment comment '标识',
   user_id              bigint comment '用户标识',
   color                varchar(10) comment '颜色',
   text                 varchar(100) comment '内容',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by           varchar(50) comment '更新的操作员Login_ID',
   updated_on           datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table cfg_mark_it comment '标签表';







drop table if exists biz_related_party;
create table biz_related_party
(
   id                   bigint not null auto_increment comment '标识',
   company_id           bigint,
   name_short           varchar(50),
   name_cn              varchar(250),
   name_en              varchar(250),
   type_                int comment '付款人、收款人等',
   contact              varchar(50),
   address              varchar(500),
   phone                varchar(25),
   fax                  varchar(25),
   country_code         varchar(25),
   city_code            VARCHAR(5),
   invoice_type         int comment '0:不开票、1:普通票、2:增值税票等',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by            varchar(50) comment '更新的操作员Login_ID',
   updated_on            datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*
 * 用于记录i18n
 * */
create table cfg_resource (
   Key_               VARCHAR(100),
   VALUE_               VARCHAR(1024),
   VALUE_en               VARCHAR(1024),
   constraint PK_CFG_RESOURCE primary key (Key_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




drop table if exists fm_document;

/*==============================================================*/
/* Table: biz_fee_item                                      */
/*==============================================================*/
create table fm_document
(
   id                   bigint not null auto_increment comment '标识',
   catalog_id             bigint comment '预留，用于文件分类',
   folder_name          varchar(6) comment 'yyyymm作为文档的文件夹，不可改',
   file_uuid            varchar(36) comment '文件的uuid，作为系统文件名称，不可改',
   name_                varchar(250) comment '文档名称',
   code_                varchar(50) comment '文档编码',
   type_                varchar(1) comment '文档类型',
   size_                bigint comment '文档大小',
   tags_                varchar(500) comment '标签列表',
   desc_                varchar(500) comment '文档描述',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   order_               int comment '记录顺序',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by           varchar(50) comment '更新的操作员Login_ID',
   updated_on           datetime comment '更新的时间，同时用作version_id',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
