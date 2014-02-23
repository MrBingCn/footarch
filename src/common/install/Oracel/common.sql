--
-- Table structure for table `system_organization`
--
DROP TABLE IF EXISTS COMMON_CATALOG;
CREATE TABLE COMMON_CATALOG (
  catalog_id NUMBER(12,0) NOT NULL,
  pro_catalog_id NUMBER(12,0) default NULL,
  root_id NUMBER(12,0) default NULL,
  name_ varchar(50) default NULL,
  desc_ varchar(2500) default NULL,
  is_folder NUMBER(1,0) default NULL,
  level_ NUMBER(5,0) default NULL,
  index_ NUMBER(5,0) default NULL,
  ext_c1 varchar(250) default NULL,
  ext_c2 varchar(500) default NULL,
  ext_c3 varchar(2500) default NULL,
  ext_d1 timestamp default NULL,
  ext_d2 timestamp default NULL,
  ext_n1 NUMBER(12,2) default NULL,
  ext_n2 NUMBER(12,2) default NULL,
  ext_n3 NUMBER(12,2) default NULL,
  constraint  COMMON_CATALOG_pk primary key (catalog_id)
);
select * from PRODUCT_PRODUCT
select * from COMMON_VIEW

delete from COMMON_VIEW;
insert into COMMON_VIEW(view_id,search_view_id,edit_view_id, name_, code_, type_,create_enable,update_enable,delete_enable,index_) values(-1,-2,-3, '产品查询', '001','G',1,1,1,1);
insert into COMMON_VIEW(view_id, name_, code_,type_,index_) values(-2, '产品查询表单', '002','S',1000);
insert into COMMON_VIEW(view_id, name_, code_, table_name,type_,index_) values(-3, '产品编辑', '003', 'PRODUCT_PRODUCT','E',1001);


insert into COMMON_VIEW(view_id,search_view_id,edit_view_id, name_, code_, type_,create_enable,update_enable,delete_enable,index_) values(-6,-7,-8, '事件类型查询', '004','G',1,1,1,2);
insert into COMMON_VIEW(view_id, name_, code_,type_,index_) values(-7, '事件类型查询表单', '005','S',1000);
insert into COMMON_VIEW(view_id, name_, code_, table_name,type_,index_) values(-8, '事件类型编辑', '006', 'COMMON_EVENT_TYPE','E',1001);

insert into COMMON_VIEW(view_id,search_view_id,name_, code_, type_,before_sql_1,index_) values(-10,-11, '事件日志查询', '010','G','select * from (select l.event_log_id, l.create_on, l.event_type_code, t.name_, t.type_, l.user_id, l.biz_id, l.biz_data from COMMON_EVENT_LOG l left join COMMON_EVENT_TYPE t on l.event_type_code = t.event_type_code) ',3);
insert into COMMON_VIEW(view_id, name_, code_,type_,index_) values(-11, '事件日志表单', '011','S',1000);

DROP TABLE  COMMON_VIEW;
CREATE TABLE COMMON_VIEW (
  view_id NUMBER(12,0) NOT NULL,
  edit_view_id NUMBER(12,0) default NULL,
  search_view_id NUMBER(12,0) default NULL,
  name_ varchar(50) default NULL,
  code_ varchar(50) default NULL,
  type_ varchar(1) default null,
  index_ NUMBER(5,0) default NULL,
  table_name varchar(50) default NULL,
  privilege_code varchar(50) default NULL,
  before_sql_1 varchar(2500) default NULL,
  before_sql_2 varchar(2500) default NULL,
  before_sql_3 varchar(2500) default NULL,
  after_sql_4 varchar(2500) default NULL,
  after_sql_5 varchar(2500) default NULL,
  after_sql_6 varchar(2500) default NULL,
  create_enable NUMBER(1,0) default 0, -- 可增加
  update_enable NUMBER(1,0) default 0, -- 可编辑
  delete_enable NUMBER(1,0) default 0, -- 可删除
  ext_c1 varchar(250) default NULL,
  ext_c2 varchar(500) default NULL,
  ext_c3 varchar(2500) default NULL,
  ext_d1 timestamp default NULL,
  ext_d2 timestamp default NULL,
  ext_n1 NUMBER(12,2) default NULL,
  ext_n2 NUMBER(12,2) default NULL,
  ext_n3 NUMBER(12,2) default NULL,
  constraint COMMON_VIEW primary key (view_id)
);


CREATE SEQUENCE COMMON_VIEW_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;

delete from COMMON_FIELD;
--insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable,index_) values(-1,-1,'product name','name_', 0, 1) ;
--insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable,index_) values(-2,-1,'product Desc','short_desc', 0, 2) ;
--insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable,index_) values(-3,-1,'ID','product_id', 0, 0) ;
--insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable,index_) values(-4,-1,'CATALOG_ID','catalog_id', 0, 3) ;
--insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable,index_) values(-5,-1,'MAIN_PHOTO_ID','main_photo_id', 0, 4) ;

insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, operator, min_length, max_length,index_) values(-10,-2,'产品名称','name_', 0, 12, 'like', '2', '50',0) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, operator,index_) values(-11,-2,'描述','short_desc', 1, 12, 'like',1) ;

insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, min_length, max_length,index_) values(-20,-3,'产品名称','name_', 0, 12, '2', '50',0) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_,index_) values(-21,-3,'描述','short_desc', 0, 12,1) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_,is_primary_key,default_,index_, is_visible) values(-22,-3,'PK','product_id',1,'PRODUCT_PRODUCT_ID_SEQ',5,0) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_,default_,index_) values(-23,-3,'目录标识','catalog_id', 0, -5,100,3) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_,default_,index_) values(-24,-3,'主图片标识','main_photo_id', 0, -5,200,4) ;




insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, operator, max_length,index_) values(-110,-7,'事件代码','event_type_code', 1, 12, 'like', 50,0) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, operator, max_length,index_) values(-111,-7,'事件名称','name_', 1, 12, 'like', 50,1) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, operator, max_length,index_) values(-112,-7,'事件类型','type_', 1, 12, 'like', 5,2) ;

  
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length, is_primary_key) values(-120,-8,'事件代码','event_type_code', 0, 12, 1, 50, 1) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) values(-121,-8,'事件类型','type_', 0, 12, 2, 5) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) values(-122,-8,'事件名称','name_', 0, 12, 3, 50) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) values(-124,-8,'事件级别','level_', 0, 12, 4, 5) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) values(-125,-8,'描述','desc_', 1, 12, 5, 2500) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) values(-126,-8,'源模块','source_module', 1, 12, 6,50) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) values(-127,-8,'源类','source_class', 1, 12, 7,50) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) values(-128,-8,'源方法','source_method', 1, 12, 8,50) ;



  
insert into COMMON_FIELD(field_id, view_id, name_, code_, index_) values(-140,-10,'事件标识','event_log_id', 0) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, index_) values(-141,-10,'事件产生时间','create_on', 1) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, index_) values(-142,-10,'事件代码','event_type_code', 2) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, index_) values(-143,-10,'事件名称','name_', 3) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, index_) values(-144,-10,'事件类型','type_', 4) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, index_) values(-145,-10,'用户ID','user_id', 5) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, index_) values(-146,-10,'业务标识','biz_id', 6) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, index_) values(-147,-10,'业务数据','biz_data', 7) ;

insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, operator, max_length,index_) values(-148,-11,'事件代码','event_type_code', 1, 12, 'like', 50,0) ;
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, operator, max_length,index_) values(-149,-11,'事件类型','type_', 1, 12, 'like', 5,1) ;





DROP TABLE COMMON_FIELD;
CREATE TABLE COMMON_FIELD (
  field_id NUMBER(12,0) NOT NULL,
  view_id NUMBER(12,0) default NULL,
  name_ varchar(50) default NULL,
  code_ varchar(50) default NULL,
  type_ NUMBER(5,0) default NULL,
  desc_ varchar(2500) default NULL,
  size_ NUMBER(5,0) default NULL,
  format_ varchar(50) default NULL, -- 用于显示
  default_ varchar(50) default NULL, -- pk时，代表Seq
  min_length NUMBER(5,0) default NULL,
  max_length NUMBER(5,0) default NULL,
  min_value varchar(50) default NULL,
  max_value varchar(50) default NULL,
  rule_1 varchar(50) default NULL,
  rule_2 varchar(50) default NULL,
  rule_3 varchar(50) default NULL,
  is_nullable NUMBER(1,0) default 0,
  is_primary_key NUMBER(1,0) default 0,
  is_visible NUMBER(1,0) default 1,
  create_enable NUMBER(1,0) default 0, -- 可增加
  update_enable NUMBER(1,0) default 0, -- 可编辑
  operator varchar(50) default NULL,
  right_format_example varchar(50) default NULL,
  input_type varchar(50) default NULL,
  input_params varchar(250) default NULL,
  index_ NUMBER(5,0) default NULL,
  ext_c1 varchar(250) default NULL,
  ext_c2 varchar(500) default NULL,
  ext_c3 varchar(2500) default NULL,
  ext_d1 timestamp default NULL,
  ext_d2 timestamp default NULL,
  ext_n1 NUMBER(12,2) default NULL,
  ext_n2 NUMBER(12,2) default NULL,
  ext_n3 NUMBER(12,2) default NULL,
  constraint  COMMON_FIELD_pk primary key (field_id)
);


CREATE SEQUENCE COMMON_FIELD_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;



/*
Ø 日志id log_id
Ø 日志分类（track、info、error、data、warning、debug、fatal） type_
Ø 记录时间戳 timestamp
Ø 所属模块 module
Ø 调用类名称 class
Ø 调用方法名称 method
Ø 操作人id user_id
Ø 用户操作事件 event_name
Ø 线程号 thread_id
Ø 当前业务类型 biz_type
Ø 当前单据类型 order_type
Ø 描述信息   desc_
Ø 异常错误栈信息 track_info
Ø 业务数据（实体bean对象，数据日志使用） biz_data*/
DROP TABLE COMMON_EVENT_TYPE;
CREATE TABLE COMMON_EVENT_TYPE (
  event_type_code varchar(50) not NULL,
  type_ varchar(5) default NULL,
  name_ varchar(50) default NULL,
  level_ varchar(5) default NULL,
  desc_ varchar(2500) default NULL,
  source_module varchar(50) default NULL,
  source_class varchar(50) default NULL,
  source_method varchar(50) default NULL,
  constraint  COMMON_EVENT_TYPE_pk primary key (event_type_code)
);

DROP TABLE COMMON_EVENT_LOG;
CREATE TABLE COMMON_EVENT_LOG (
  event_log_id NUMBER(12,0) NOT NULL,
  event_type_code varchar(50) default NULL,
  create_on timestamp default current_timestamp,
  user_id varchar(50) NOT NULL,
  user_name varchar(50) NULL,
  thread_id varchar(50) NULL,
  biz_id varchar(50)  NULL,
  biz_data varchar(2500) default NULL,
  ext_c1 varchar(250) default NULL,
  ext_c2 varchar(250) default NULL,
  ext_c3 varchar(250) default NULL,
  ext_c4 varchar(500) default NULL,
  ext_c5 varchar(2500) default NULL,
  ext_d1 timestamp default NULL,
  ext_d2 timestamp default NULL,
  ext_n1 NUMBER(12,2) default NULL,
  ext_n2 NUMBER(12,2) default NULL,
  constraint  COMMON_EVENT_LOG_pk primary key (event_log_id)
);

CREATE SEQUENCE COMMON_EVENT_LOG_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;

drop table SYNC_CONFIG;

create table SYNC_CONFIG
(
    SYNC_CONFIG_ID      NUMBER(12)             not null,
    SYNC_CONFIG_CODE    VARCHAR(64)            null    ,
    SOURCE_DB_CODE      VARCHAR(64)            null    ,
    DEST_DB_CODE        VARCHAR(64)            null    ,
    SOURCE_DB_TYPE      NUMBER(6)              null    ,
    DEST_DB_TYPE        NUMBER(6)              null    ,
    SOURCE_TABLE        VARCHAR(64)            null    ,
    DEST_TABLE          VARCHAR(64)            null    ,
    SELECT_SQL          VARCHAR(1000)          null    ,
    INSERT_SQL          VARCHAR(1000)          null    ,
    MODE_TYPE           CHAR(1)                null    ,
    DIRECTION           NUMBER(6)              null    ,
    FETCH_SIZE          NUMBER(6)              null    ,
    IS_LOG              NUMBER(1)              null    ,
    constraint PK_SYNC_CONFIG primary key (SYNC_CONFIG_ID)
)/
CREATE SEQUENCE SYNC_CONFIG_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;


drop table SYNC_COLUMNS
create table SYNC_COLUMNS
(
    SYNC_COLUMNS_ID     NUMBER(12)             not null,
    SYNC_CONFIG_ID      NUMBER(12)             null    ,
    LINE_NUMBER         NUMBER(6)              null    ,
    SYNC_COLUMNS_CODE   VARCHAR(64)          null    ,
    DEFAULT_VALUE       VARCHAR(64)          null    ,
    IS_PK               NUMBER(1)              null    ,
    IS_SOURCE           NUMBER(1)              null    ,
    IS_FILTER           NUMBER(1)              null    ,
    REF_COLUMNS_CODE     VARCHAR(64)          null    ,
    CONVERTOR           VARCHAR(100)         null    ,
    constraint PK_SYNC_COLUMNS primary key (SYNC_COLUMNS_ID)
)/

CREATE SEQUENCE SYNC_COLUMNS_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;




create table SYNC_CONTROL
(
    SYNC_CONTROL_ID     NUMBER(12)             not null,
    SOURCE_DB_CODE      VARCHAR(64)            not null,
    SOURCE_TABLE        VARCHAR(64)            not null,
    CURRENT_LONG_ID     NUMBER(12)             null    ,
    CURRENT_STRING_ID   VARCHAR(64)            null    ,
    STATUS              VARCHAR(1)             null    ,
    START_ON            TIMESTAMP              null    ,
    END_ON              TIMESTAMP              null    ,
    ERROR_EVENT_LOG_ID  NUMBER(12)             null    ,
    ERROR_TIMES         NUMBER(6)              null    ,
    constraint PK_SYNC_CONTROL primary key (SYNC_CONTROL_ID)
)

CREATE SEQUENCE SYNC_CONTROL_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20

delete from TEST_ORDER
create table TEST_ORDER
(
  ORDER_ID                  NUMBER(11)     not null ,
  version_ID                TIMESTAMP  null ,
  Dist_Number               NUMBER(11)  null    ,
  Sale_Date                 NUMBER(7) null      ,
  Process_Date              NUMBER(7)  null    ,
  Process_Time              NUMBER(6) null      ,
  Staff_ID                  varchar(10) null ,    
  constraint P_Key_DMSORD_TEST primary key (ORDER_ID)
) ;



create table SYS_Message
(
    code_         VARCHAR(50)            not null,
    locale_       VARCHAR(64)            not null,
    value_        VARCHAR(500)            not null,
    constraint PK_SYNC_CONTROL primary key (code_)
)

