
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


CREATE SEQUENCE SYSTEM_DICT_ID_SEQ MINVALUE 100000 MAXVALUE 999999999999 START WITH 100000 INCREMENT BY 1 CACHE 50;
