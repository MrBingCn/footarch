--
-- Table structure for table `system_organization`
--
DROP TABLE IF EXISTS system_organization;
CREATE TABLE system_organization (
  organization_id NUMBER(12,0) NOT NULL,
  pro_organization_id NUMBER(12,0) default NULL,
  name_ varchar(50) default NULL,
  desc_ varchar(2500) default NULL,
  constraint  system_organization_pk primary key (ORGANIZATION_ID)
);

--
-- Dumping data for table `system_organization`
--
delete from system_organization
INSERT INTO system_organization VALUES ('2',NULL,'fadd','sdaf');
INSERT INTO system_organization VALUES ('3','2','fds','sdf');
INSERT INTO system_organization VALUES ('4','3','sdfff','sdf');
INSERT INTO system_organization VALUES ('5','2','12','12');
INSERT INTO system_organization VALUES ('6','2','test','test');
INSERT INTO system_organization VALUES ('8','6','t','t');
INSERT INTO system_organization VALUES ('9',NULL,'System Manage','');

/*!40000 ALTER TABLE `system_organization` ENABLE KEYS */;

--
-- Table structure for table `system_organization_privilege`
--

DROP TABLE IF EXISTS system_organization_privilege;
CREATE TABLE system_organization_privilege (
  organization_id NUMBER(12,0) NOT NULL,
  privilege_id NUMBER(12,0) NOT NULL,
  constraint sys_organization_privilege_pk primary key (ORGANIZATION_ID, privilege_id)
);

--
-- Dumping data for table `system_organization_privilege`
--


/*!40000 ALTER TABLE `system_organization_privilege` DISABLE KEYS */;
INSERT INTO system_organization_privilege VALUES ('5','6');
INSERT INTO system_organization_privilege VALUES ('5','5') ;
INSERT INTO system_organization_privilege VALUES ('5','4') ;
INSERT INTO system_organization_privilege VALUES ('5','1') ;
INSERT INTO system_organization_privilege VALUES ('6','3') ;
INSERT INTO system_organization_privilege VALUES ('6','9') ;
INSERT INTO system_organization_privilege VALUES ('9','17');
INSERT INTO system_organization_privilege VALUES ('9','16');
INSERT INTO system_organization_privilege VALUES ('9','15');
INSERT INTO system_organization_privilege VALUES ('8','9') ;
INSERT INTO system_organization_privilege VALUES ('9','14');
INSERT INTO system_organization_privilege VALUES ('9','13');
INSERT INTO system_organization_privilege VALUES ('9','12');
INSERT INTO system_organization_privilege VALUES ('9','11');
INSERT INTO system_organization_privilege VALUES ('9','21');
INSERT INTO system_organization_privilege VALUES ('9','19');
INSERT INTO system_organization_privilege VALUES ('9','18');
INSERT INTO system_organization_privilege VALUES ('9','20');
INSERT INTO system_organization_privilege VALUES ('9','22');
INSERT INTO system_organization_privilege VALUES ('9','23');

/*!40000 ALTER TABLE `system_organization_privilege` ENABLE KEYS */;

--
-- Table structure for table `system_privilege`
--

DROP TABLE IF EXISTS system_privilege;
CREATE TABLE system_privilege (
  privilege_id NUMBER(12,0) NOT NULL,
  pro_privilege_id NUMBER(12,0) default NULL,
  code_ varchar(50) default NULL,
  name_ varchar(50) default NULL,
  url_ varchar(250) default NULL,
  desc_ varchar(2500) default NULL,
  constraint  system_privilege_pk primary key (privilege_id)
);

--
-- Dumping data for table `system_privilege`
--


/*!40000 ALTER TABLE `system_privilege` DISABLE KEYS */;
delete from system_privilege;
INSERT INTO system_privilege VALUES ('1',NULL,'1','1',NULL,'1')                                      ;
INSERT INTO system_privilege VALUES ('2',NULL,'2','2',NULL,'2')                                      ;
INSERT INTO system_privilege VALUES ('3',NULL,'3','3',NULL,'3')                                      ;
INSERT INTO system_privilege VALUES ('4','1','11','11',NULL,'11')                                    ;
INSERT INTO system_privilege VALUES ('5','1','12','12',NULL,'12;;;#$$%%@#@')                         ;
INSERT INTO system_privilege VALUES ('6','1','13','13',NULL,'13hk')                                  ;
INSERT INTO system_privilege VALUES ('7','2','21','21',NULL,'121')                                   ;
INSERT INTO system_privilege VALUES ('8','2','22','22',NULL,'22')                                    ;
INSERT INTO system_privilege VALUES ('9','3','32','32',NULL,'32')                                    ;
INSERT INTO system_privilege VALUES ('10','3','31','31',NULL,'31')                                   ;
INSERT INTO system_privilege VALUES ('11',NULL,'1','System Mangement',NULL,'')                        ;
INSERT INTO system_privilege VALUES ('12','11','101','User Management',NULL,'User Management')       ;
INSERT INTO system_privilege VALUES ('13','11','102','User Create',NULL,'')                          ;
INSERT INTO system_privilege VALUES ('14','11','103','User Update',NULL,'')                          ;
INSERT INTO system_privilege VALUES ('15','11','104','User Delete',NULL,'')                          ;
INSERT INTO system_privilege VALUES ('16','11','111','Org Management',NULL,'')                       ;
INSERT INTO system_privilege VALUES ('17','11','112','Org Create',NULL,'')                           ;
INSERT INTO system_privilege VALUES ('18','11','113','Org Update',NULL,'')                           ;
INSERT INTO system_privilege VALUES ('19','11','114','Org Delete',NULL,'')                           ;
INSERT INTO system_privilege VALUES ('21','11','122','Privilege Create',NULL,'')                     ;
INSERT INTO system_privilege VALUES ('20','11','121','Privilege Management',NULL,'')                 ;
INSERT INTO system_privilege VALUES ('22','11','123','Privilege Update',NULL,'')                     ;
INSERT INTO system_privilege VALUES ('23','11','124','Privilege Delete',NULL,'');

/*!40000 ALTER TABLE `system_privilege` ENABLE KEYS */;

--
-- Table structure for table `system_user`
--

DROP TABLE IF EXISTS system_user;
CREATE TABLE system_user (
  user_id NUMBER(12,0) NOT NULL,
  login_id varchar(50) NOT NULL,
  password_ varchar(50) NOT NULL,
  name_ varchar(50) NOT NULL,
  email_ varchar(50) default NULL,
  REGION varchar(50) default NULL,
  status_ varchar(5) default NULL,
  desc_ varchar(2500) default NULL,
  organization_id NUMBER(12,0) default NULL,
  constraint  system_user_pk primary key (user_id)
);

--
-- Dumping data for table `system_user`
--


/*!40000 ALTER TABLE `system_user` DISABLE KEYS */;
INSERT INTO system_user VALUES ('1','5','C4CA4238A0B923820DCC509A6F75849B','53242','adfadfa@123.com',NULL,NULL,NULL,NULL)    ;
INSERT INTO system_user VALUES ('2','677p','1679091C5A880FAF6FB5E6087EB1B2DC','6vzvzdsafai','22@163.com',NULL,NULL,NULL,NULL);
INSERT INTO system_user VALUES ('10','tt','ACCC9105DF5383111407FD5B41255E23','tt','tt@tt.com',NULL,NULL,NULL,NULL)           ;
INSERT INTO system_user VALUES ('11','admin','21232F297A57A5A743894A0E4A801FC3','admin','admin@163.com',NULL,NULL,NULL,NULL) ;
INSERT INTO system_user VALUES ('8','8p','C9F0F895FB98AB9159F51FD0297E236D','8h','',NULL,NULL,NULL,NULL)                     ;
INSERT INTO system_user VALUES ('9','34ggg','ECCBC87E4B5CE2FE28308FD9F2A7BAF3','3','',NULL,NULL,NULL,NULL)                   ;
INSERT INTO system_user VALUES ('12','3432','6512BD43D9CAA6E02C990B0A82652DCA','?','11@11.com',NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `system_user` ENABLE KEYS */;

--
-- Table structure for table `system_user_organization`
--

DROP TABLE IF EXISTS system_user_organization;
CREATE TABLE system_user_organization (
  organization_id NUMBER(12,0) NOT NULL,
  user_id NUMBER(12,0) NOT NULL,
  constraint  system_user_organization_pk primary key (organization_id, user_id)
);

--
-- Dumping data for table `system_user_organization`
--


/*!40000 ALTER TABLE `system_user_organization` DISABLE KEYS */;
INSERT INTO system_user_organization VALUES ('5','10');
INSERT INTO system_user_organization VALUES ('2','10');
INSERT INTO system_user_organization VALUES ('6','10');
INSERT INTO system_user_organization VALUES ('8','10');
INSERT INTO system_user_organization VALUES ('9','11');

/*!40000 ALTER TABLE `system_user_organization` ENABLE KEYS */;

--
-- Table structure for table `system_user_privilege`
--
/*
DROP TABLE IF EXISTS system_user_privilege;
CREATE TABLE system_user_privilege (
  user_id NUMBER(12,0) NOT NULL,
  privilege_id NUMBER(12,0) NOT NULL,
  constraint  system_user_privilege_pk primary key (privilege_id, user_id)
);
*/
--
-- Dumping data for table `system_user_privilege`
--


DROP TABLE IF EXISTS SYSTEM_DICT;
CREATE TABLE SYSTEM_DICT (
  dict_id NUMBER(12,0) NOT NULL,
  pro_dict_id NUMBER(12,0),
  domain_ varchar(50) default NULL,
  code_ varchar(50) default NULL,
  name_ varchar(250) default NULL,
  desc_ varchar(2500) default NULL,
  flag_ varchar(1) default NULL,
  status_ varchar(1) default NULL,
  order_ NUMBER(5),
  constraint  SYSTEM_DICT_pk primary key (dict_id)
);

-- * 20-40 16 * * *

drop table SYS_TASK_CONFIG;
create table SYS_TASK_CONFIG  (
   TASK_CONFIG_ID       NUMBER(12)                      not null,
   GROUP_ID             NUMBER(6),
   CODE_                VARCHAR(10),
   NAME_                VARCHAR(250),
   COMMAND_TYPE         VARCHAR(250),
   COMMAND_CONTENT      VARCHAR(250),
   COMMAND_PARAMS       VARCHAR(2500),
   TASK_STATUS          CHAR(1),
   TASK_TYPE            VARCHAR(10),
   SCHEDULE_TYPE        VARCHAR(10),
   TRIGGER_PERIOD       NUMBER(12),
   TRIGGER_SCOPE        VARCHAR(250),
   START_ON_HOUR        NUMBER(6),
   START_ON_MINUTE      NUMBER(6),
   CRON_SEQUENCE        VARCHAR(250),
   APP_ID_TYPE          VARCHAR(10),
   APP_ID               VARCHAR(250),
   PRE_TASK_CONFIG_ID   NUMBER(12),
   LAST_TASK_LOG_ID     NUMBER(12),
   DESC_                VARCHAR(2500),
   NEXT_TIME_ON         TIMESTAMP,
   constraint PK_SYS_TASK_CONFIG primary key (TASK_CONFIG_ID)
);

CREATE SEQUENCE TASK_CONFIG_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;


drop table SYS_TASK_LOG;
create table SYS_TASK_LOG  (
   TASK_LOG_ID          NUMBER(12)                      not null,
   TASK_CONFIG_ID       NUMBER(12),
   GROUP_ID             NUMBER(6),
   TASK_STATUS          CHAR(1),
   START_ON             TIMESTAMP,
   END_ON               TIMESTAMP,
   REMARK_               VARCHAR(2500),
   APP_ID               VARCHAR(250),
   UPDATE_ON            TIMESTAMP,
   constraint PK_SYS_TASK_LOG primary key (TASK_LOG_ID)
);

CREATE SEQUENCE TASK_LOG_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;

drop  table SYS_SYNC_BATCH;
create table SYS_SYNC_BATCH
(
    SYNC_BATCH_ID     NUMBER(12)             not null,
    BIZ_ID            NUMBER(12)             null    ,
    SYNC_CONFIG_CODE  VARCHAR(64)            null    ,
    KEY_SHORT_1       NUMBER(6)              null    ,
    KEY_NUMBER_1      NUMBER(12)             null    ,
    KEY_NUMBER_2      NUMBER(12)             null    ,
    KEY_STRING_1      VARCHAR(64)            null    ,
    KEY_STRING_2      VARCHAR(64)            null    ,
    KEY_STRING_3      VARCHAR(64)            null    ,
    PROGRAM_NAME      VARCHAR(64)            null    ,
    SYNC_FLAG         CHAR(1)                null    ,
    ENTRY_DATE        timestamp              null    ,
    PROCESS_DATE      timestamp              null    ,
    TIMES_OF_FAIL     NUMBER(6)              null    ,
    REMARK            VARCHAR(250)           null    ,
    constraint PK_SYNC_BATCH primary key (SYNC_BATCH_ID)
);
create table SYNC_BATCH_BACKUP
(
    SYNC_BATCH_ID     NUMBER(12)             not null,
    BIZ_ID            NUMBER(12)             null    ,
    SYNC_CONFIG_CODE  VARCHAR(64)            null    ,
    KEY_SHORT_1       NUMBER(6)              null    ,
    KEY_NUMBER_1      NUMBER(12)             null    ,
    KEY_NUMBER_2      NUMBER(12)             null    ,
    KEY_STRING_1      VARCHAR(64)            null    ,
    KEY_STRING_2      VARCHAR(64)            null    ,
    KEY_STRING_3      VARCHAR(64)            null    ,
    PROGRAM_NAME      VARCHAR(64)            null    ,
    SYNC_FLAG         CHAR(1)                null    ,
    ENTRY_DATE        timestamp              null    ,
    PROCESS_DATE      timestamp              null    ,
    TIMES_OF_FAIL     NUMBER(6)              null    ,
    REMARK            VARCHAR(250)           null    ,
    constraint PK_SYNC_BATCH_BACKUP primary key (SYNC_BATCH_ID)
);

CREATE SEQUENCE SYNC_BATCH_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;


create table SYS_SYNC_RECORD_BACKUP
(
    SYNC_CONFIG_ID  NUMBER(12)             not null,
    SYNC_BATCH_ID   NUMBER(12)             not null,
    IS_SOURCE       NUMBER(1)              not null,
    CONTENT         VARCHAR(2500)          null    ,
    constraint PK_SYN_RECORD_BACKUP primary key (SYNC_CONFIG_ID, SYNC_BATCH_ID, IS_SOURCE)
);

drop table SYS_SHOP_PROFILE;
create table SYS_SHOP_PROFILE  (
   SHOP_PROFILE_ID      NUMBER(12)                      not null,
   Region_Code        VARCHAR(10),
   Code_              VARCHAR(10),
   Name_              VARCHAR(250),
   Type_              CHAR(1),
   Area_Code          VARCHAR(10),
   Province_Branch_Code VARCHAR(10),
   Province_Branch_Name VARCHAR(250),
   City_Branch_Code   VARCHAR(10),
   City_Branch_Name   VARCHAR(250),
   Return_Area_Code   VARCHAR(10),
   Return_Area_Name   VARCHAR(250),
   Manager_Class      VARCHAR(10),
   Manager_Number     NUMBER(12),
   Establish_Date     TIMESTAMP,
   Sale_Date          TIMESTAMP,
   Shop_Address     VARCHAR(250),
   Phone_Prefix       VARCHAR(25),
   Phone_Number       VARCHAR(25),
   Stock_Control_Flag CHAR(1),
   Home_Delivery_Flag CHAR(1),
   Status_      CHAR(1),
   Record_Status CHAR(1),
   Delivery_Shop_Code VARCHAR(10),
   constraint PK_SYS_SHOP_PROFILE primary key (SHOP_PROFILE_ID)
);

CREATE SEQUENCE SHOP_PROFILE_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;



create table SYS_SHOP_ATTRIBUTE  (
   shop_attribute_id  NUMBER(12)                      not null,
   shop_profile_id    NUMBER(12),
   code_              VARCHAR(250),
   value_             VARCHAR(250),
   constraint PK_SYS_SHOP_ATTRIBUTE primary key (shop_attribute_id)
);

CREATE SEQUENCE SHOP_ATTRIBUTE_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;



/*==============================================================*/
/* Table: SYS_TERMINAL_PROFILE                                  */
/*==============================================================*/
create table SYS_TERMINAL_PROFILE  (
   TERMINAL_PROFILE_ID  NUMBER(12)                      not null,
   Region_Code        VARCHAR(10),
   Shop_Code          VARCHAR(10),
   Code_              VARCHAR(10),
   Type_              CHAR(1),
   Name_              CHAR(10),
   Computer_Name      VARCHAR(250),
   Computer_Mac       VARCHAR(250),
   Computer_IP        VARCHAR(250),
   Times_Of_Relief    NUMBER(12),
   Establish_Date     TIMESTAMP,
   Sale_Date          TIMESTAMP,
   Current_User       NUMBER(12),
   Status_            CHAR(1),
   Business_Record_Status CHAR(1),
   constraint PK_SYS_TERMINAL_PROFILE primary key (TERMINAL_PROFILE_ID)
);


CREATE SEQUENCE TERMINAL_PROFILE_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;



comment on column SYS_TERMINAL_PROFILE.POS_Class is
'0-收银机，1-服务柜台， ''A''- A4纸打印，其余都是小票打印';

comment on column SYS_TERMINAL_PROFILE.Change_Class_Count is
'换班次数';


alter table SYS_TERMILAL_ATTRIBUTE
   drop constraint FK_SYS_TERM_REFERENCE_SYS_TERM;

drop table SYS_TERMILAL_ATTRIBUTE cascade constraints;

/*==============================================================*/
/* Table: SYS_TERMILAL_ATTRIBUTE                                */
/*==============================================================*/
create table SYS_TERMINAL_ATTRIBUTE  (
   terminal_attribute_id NUMBER(12)                      not null,
   terminal_profile_id NUMBER(12),
   code_              VARCHAR(250),
   value_             VARCHAR(250),
   constraint PK_SYS_TERMILAL_ATTRIBUTE primary key (terminal_attribute_id)
);

alter table SYS_TERMILAL_ATTRIBUTE
   add constraint FK_SYS_TERM_REFERENCE_SYS_TERM foreign key (terminal_profile_id)
      references SYS_TERMINAL_PROFILE (TERMINAL_PROFILE_ID);

      
CREATE SEQUENCE TERMINAL_ATTRIBUTE_ID_SEQ MINVALUE 10000 MAXVALUE 999999999999 START WITH 10000 INCREMENT BY 1 CACHE 20;
