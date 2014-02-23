drop table if exists sys_user;

drop table if exists sys_organization;

drop table if exists sys_organization_privilege;

drop table if exists sys_privilege;

drop table if exists sys_user_organization;

drop table if exists cfg_dict;

drop table if exists cfg_message;

drop table if exists sys_op_log;

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
