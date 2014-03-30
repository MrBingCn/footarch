insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (1, 'ADMIN', '', '', 'admin', null, null, 'admin', 'C4CA4238A0B923820DCC509A6F75849B', null, null, '2012-07-16 10:03:54', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 1, null, 'A', null, null, null, null, null, 1);


insert into sys_role (id, pro_role_id, code_, name_, desc_) values (1, 0, 'ADMIN', '系统管理员', null);


/* system */
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1, 0, '1', '功能权限', null, null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1010, 1, '1010', '查询询价单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1020, 1, '1020', '新建询价单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1030, 1, '1030', '修改询价单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1070, 1, '1070', '查询订单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1071, 1, '1071', '修改订单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2040, 1, '2040', '报表统计', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2050, 1, '2050', '基础数据管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2060, 1, '2060', '企业管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2070, 1, '2070', '用户管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2130, 1, '2130', '日志查询', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2140, 1, '2140', '部门管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2150, 1, '2150', '角色管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2160, 1, '2160', '消息管理', '', null);

insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (3000, 1, '3000', '应收应付管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (3001, 1, '3001', '费用管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (3010, 1, '3010', '应收应付修改', '', '主要用于控制应收应付界面关于费用增减元素的显示');
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (3020, 1, '3020', '收款应款修改', '', '主要用于控制应收应付界面关于费用支付元素的显示');

insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (4001, 1, '4001', '产品管理', '', null);


insert into sys_user_role (role_id, user_id) values (1, 1);


insert into sys_role_privilege (role_id, privilege_id) select 1, id from sys_privilege;

