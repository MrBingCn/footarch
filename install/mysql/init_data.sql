/* system */
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1, 0, '1', '功能权限', null, null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1010, 1, '1010', '查询询价单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1020, 1, '1020', '新建询价单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1030, 1, '1030', '修改询价单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1070, 1, '1070', '查询订单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1071, 1, '1071', '修改订单', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1080, 1, '1080', '查看订单基本信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1090, 1, '1090', '修改订单基本信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1110, 1, '1110', '查看订单客户信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1120, 1, '1120', '修改订单客户信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1130, 1, '1130', '查看订单装箱信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1140, 1, '1140', '修改订单装箱信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1150, 1, '1150', '查看订单报关信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1160, 1, '1160', '修改订单报关信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1170, 1, '1170', '查看订单运费信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (1180, 1, '1180', '修改订单运费信息', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2040, 1, '2040', '报表统计', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2050, 1, '2050', '基础数据管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2060, 1, '2060', '企业管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2070, 1, '2070', '用户管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2080, 1, '2080', '船公司管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2090, 1, '2090', '联系人查询', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2091, 1, '2091', '联系人修改', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2100, 1, '2100', '国家管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2110, 1, '2110', '费项管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2120, 1, '2120', '港口管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2130, 1, '2130', '日志查询', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2140, 1, '2140', '部门管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2150, 1, '2150', '角色管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (2160, 1, '2160', '消息管理', '', null);

insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (3000, 1, '3000', '应收应付管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (3001, 1, '3001', '费用管理', '', null);
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (3010, 1, '3010', '应收应付修改', '', '主要用于控制应收应付界面关于费用增减元素的显示');
insert into sys_privilege (id, pro_privilege_id, code_, name_, url_, desc_) values (3020, 1, '3020', '收款应款修改', '', '主要用于控制应收应付界面关于费用支付元素的显示');

insert into sys_role (id, pro_role_id, code_, name_, desc_) values (-2, 0, '', '总经理', null);
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (21, 0, '', '分公司经理', null);
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (1, 0, '', '系统管理员', null);
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (2, 0, '', '客服', null);
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (3, 0, '', '操作员', null);
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (5, 0, '', '报表管理员', '');
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (6, 0, '', '外部角色:客户', '');
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (7, 0, '', '外部角色:船代', '');
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (8, 0, '', '外部角色:报关行', '');
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (12, 0, '', '外部角色:海外代理', '');
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (13, 0, '', '外部角色:车队', '');
insert into sys_role (id, pro_role_id, code_, name_, desc_) values (14, 0, '', '外部角色:仓库', '');


insert into sys_role_privilege (role_id, privilege_id) values (-2, 1010);
insert into sys_role_privilege (role_id, privilege_id) values (-2, 1020);
insert into sys_role_privilege (role_id, privilege_id) values (-2, 1030);
insert into sys_role_privilege (role_id, privilege_id) values (-2, 1070);
insert into sys_role_privilege (role_id, privilege_id) values (-2, 1080);
insert into sys_role_privilege (role_id, privilege_id) values (-2, 1110);
insert into sys_role_privilege (role_id, privilege_id) values (-2, 1130);
insert into sys_role_privilege (role_id, privilege_id) values (-2, 1150);
insert into sys_role_privilege (role_id, privilege_id) values (-2, 1170);

insert into sys_role_privilege (role_id, privilege_id) values (21, 1010);
insert into sys_role_privilege (role_id, privilege_id) values (21, 1020);
insert into sys_role_privilege (role_id, privilege_id) values (21, 1030);
insert into sys_role_privilege (role_id, privilege_id) values (21, 1070);
insert into sys_role_privilege (role_id, privilege_id) values (21, 1080);
insert into sys_role_privilege (role_id, privilege_id) values (21, 1110);
insert into sys_role_privilege (role_id, privilege_id) values (21, 1130);
insert into sys_role_privilege (role_id, privilege_id) values (21, 1150);
insert into sys_role_privilege (role_id, privilege_id) values (21, 1170);

insert into sys_role_privilege (role_id, privilege_id) values (1, 1010);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1020);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1030);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1070);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1071);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1080);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1090);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1100);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1110);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1120);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1130);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1140);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1150);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1160);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1170);
insert into sys_role_privilege (role_id, privilege_id) values (1, 1180);
insert into sys_role_privilege (role_id, privilege_id) values (1, 2040);
insert into sys_role_privilege (role_id, privilege_id) values (1, 2050);
insert into sys_role_privilege (role_id, privilege_id) values (1, 2060);
insert into sys_role_privilege (role_id, privilege_id) values (1, 2070);
insert into sys_role_privilege (role_id, privilege_id) values (2, 1010);
insert into sys_role_privilege (role_id, privilege_id) values (2, 1020);
insert into sys_role_privilege (role_id, privilege_id) values (2, 1030);
insert into sys_role_privilege (role_id, privilege_id) values (2, 1070);
insert into sys_role_privilege (role_id, privilege_id) values (2, 1080);
insert into sys_role_privilege (role_id, privilege_id) values (2, 1110);
insert into sys_role_privilege (role_id, privilege_id) values (2, 1130);
insert into sys_role_privilege (role_id, privilege_id) values (2, 1150);
insert into sys_role_privilege (role_id, privilege_id) values (2, 1170);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1010);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1020);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1030);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1070);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1080);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1090);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1110);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1120);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1130);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1140);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1150);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1160);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1170);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1071);
insert into sys_role_privilege (role_id, privilege_id) values (3, 1180);
insert into sys_role_privilege (role_id, privilege_id) values (5, 2040);
insert into sys_role_privilege (role_id, privilege_id) values (6, 1010);
insert into sys_role_privilege (role_id, privilege_id) values (6, 1020);
insert into sys_role_privilege (role_id, privilege_id) values (6, 1030);
insert into sys_role_privilege (role_id, privilege_id) values (6, 1070);
insert into sys_role_privilege (role_id, privilege_id) values (6, 1080);
insert into sys_role_privilege (role_id, privilege_id) values (6, 1110);
insert into sys_role_privilege (role_id, privilege_id) values (6, 1130);
insert into sys_role_privilege (role_id, privilege_id) values (6, 1150);
insert into sys_role_privilege (role_id, privilege_id) values (6, 1170);


insert into sys_organization
(id,pro_organization_id,name_,desc_)
values
(1,0,'事业部','事业部');
insert into sys_organization
(id,pro_organization_id,name_,desc_,leader_id)
values
(2,1,'市场部','市场部','10');
insert into sys_organization
(id,pro_organization_id,name_,desc_)
values
(3,1,'海外部','海外部');


insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (1, 'ADMIN', '', '', 'admin', null, null, 'admin', 'A4C785C0A2609BF9742CC810D9DEB86C', null, null, '2012-07-16 10:03:54', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 1, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (2, 'customer', '', '', 'customer', null, null, '客户', 'A4C785C0A2609BF9742CC810D9DEB86C', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 270, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (3, 'cd', '', '', 'cd', null, null, '船代', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 168, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (4, 'bg', '', '', 'bg', null, null, '报关', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, -299, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (5, 'hwdl', '', '', 'hwdl', null, null, '海外代理', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 2, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (6, 'car', '', '', 'car', null, null, '车队', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, -699, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (7, 'ck', '', '', 'ck', null, null, '仓库', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, -599, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (8, 'kf1', '', '', 'kf1', null, null, '客服1', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 1, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (9, 'kf2', '', '', 'kf2', null, null, '客服2', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 1, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (10, 'kfm', '', '', 'kfm', null, null, '客服主管', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 1, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (11, 'op1', '', '', 'ck', null, null, '操作员1', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 1, null, 'A', null, null, null, null, null, null);
insert into sys_user (id, login_id, Region_Code, Shop_Code, name_cn, name_en, email_, desc_, password_, old_password_1, old_password_2, Password_Changed_On, Effective_Date, Expired_Date, Supervisor_Flag, Lock_Flag, Lock_Count, company_id, organization_id, status_, type_, created_by, created_on, updated_by, updated_on, version_id) values (12, 'op2', '', '', 'ck', null, null, '操作员2', '21232F297A57A5A743894A0E4A801FC3', null, null, '2012-08-31 14:22:06', '2012-07-16 10:03:54', '2013-01-01 00:00:00', null, null, null, 1, null, 'A', null, null, null, null, null, null);


insert into sys_user_role (role_id, user_id) values (1, 1);
insert into sys_user_role (role_id, user_id) values (6, 2);
insert into sys_user_role (role_id, user_id) values (7, 3);
insert into sys_user_role (role_id, user_id) values (8, 4);
insert into sys_user_role (role_id, user_id) values (12, 5);
insert into sys_user_role (role_id, user_id) values (13, 6);
insert into sys_user_role (role_id, user_id) values (14, 7);
insert into sys_user_role (role_id, user_id) values (2, 8);
insert into sys_user_role (role_id, user_id) values (2, 9);
insert into sys_user_role (role_id, user_id) values (2, 10);
insert into sys_user_role (role_id, user_id) values (3, 11);
insert into sys_user_role (role_id, user_id) values (3, 12);


