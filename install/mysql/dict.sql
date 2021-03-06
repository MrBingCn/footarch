
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100001, 0, 'Cache_Sql', 'Organization', 'isSCM=Y', 'select id, name_, pro_organization_id,record_status,level_ from sys_organization order by level_, order_, name_', null, 'A', 7, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100002, 0, 'Cache_Sql', 'Privilege', '', 'select id, name_ from sys_privilege ', null, 'A', 6, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100003, 0, 'Cache_Sql', 'Message', '', 'select code_ as id, value_ from cfg_message ', null, 'A', 4, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100005, 0, 'Cache_Sql', 'cfg_items', 'isSCM=Y', 'select i.id id, i.name name from cfg_items i', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100006, 0, 'Cache_Sql', 'cfg_subject', 'subTable=domain_&isSCM=Y', 'select s.id as domain_,i.id id, i.name name from cfg_subject s, cfg_items i where i.sub_id=s.id and i.record_status=''A'' order by i.sequence', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100007, 0, 'Cache_Sql', 'Dict', 'subTable=domain_&isSCM=Y', 'select code_ as id, name_ , desc_ , domain_, ext_s1, ext_s2, ext_s3,ext_s4,ext_s5 from cfg_dict where domain_!=''Cache_Sql'' and status_ = ''A'' order by domain_,order_ ', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100009, 0, 'Cache_Sql', 'Resource_en', '', 'select key_ as id, value_en as value_ from cfg_resource ', null, 'A', 16, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100010, 0, 'Cache_Sql', 'Resource', '', 'select key_ as id, value_ as value_ from cfg_resource ', null, 'A', 15, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100011, 0, 'Cache_Sql', 'ProProductCategory', 'isSCM=Y', 'select id, name_cn, record_status from biz_product_category where pro_product_category_id is null or pro_product_category_id=0 order by order_, name_cn', null, 'A', 12, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-9100012, 0, 'Cache_Sql', 'ProductCategory', 'isSCM=Y', 'select id, pro_product_category_id, name_cn, record_status from biz_product_category order by pro_product_category_id, order_, name_cn', null, 'A', 12, null, null, null, null, null);

insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-3000009, 0, 'SYS.ActionName', '/system/user_logout', '用户登出', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-3000008, 0, 'SYS.ActionName', '/system/user_login', '用户登录', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-3000007, 0, 'SYS.ActionName', 'add', '添加', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-3000006, 0, 'SYS.ActionName', 'get', '读取', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-3000005, 0, 'SYS.ActionName', 'query', '查询', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-3000004, 0, 'SYS.ActionName', 'list', '查询列表', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-3000003, 0, 'SYS.ActionName', 'delete', '删除', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-3000002, 0, 'SYS.ActionName', 'update', '更新', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-3000001, 0, 'SYS.ActionName', 'create', '创建', '', null, 'A', 1, null, null, null, null, null);


insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-901, 0, 'DEV.js.config', 'min_mode', 'min.', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-902, 0, 'FM.Config', 'upload.dir', 'data/upload', '文件上传路目录', null, 'A', 1, null, null, null, null, null);

insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-223, 0, 'sys.mail.config', 'mail.smtp.auth.password', '密码', '', null, 'A', 2, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-222, 0, 'sys.mail.config', 'mail.smtp.auth.user', '用户', 'xiangrong@126.com', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-221, 0, 'sys.mail.config', 'mail.mailrouter.net', 'SMTP服务器', 'smtp.163.com', null, 'A', 0, null, null, null, null, null);

insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-26, 0, 'CM.lang', 'en', 'English', '', null, 'A', 2, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-25, 0, 'CM.lang', 'cn', '中文', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-22, 0, 'CM.yes.no', '0', '否', '', null, 'A', 2, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-21, 0, 'CM.yes.no', '1', '是', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-17, 0, 'CM.status_', '0', '取消-不可用', '', null, 'A', 2, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-16, 0, 'CM.status_', '1', '激活-可用', '', null, 'A', 1, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-14, 0, 'CM.status', 'C', '取消-不可用', '', null, 'A', 2, null, null, null, null, null);
insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-13, 0, 'CM.status', 'A', '激活-可用', '', null, 'A', 1, null, null, null, null, null);



insert into cfg_dict (id, pro_dict_id, domain_, code_, name_, desc_, flag_, status_, order_, ext_s1, ext_s2, ext_s3, ext_s4, ext_s5) values (-101, 0, 'CM.protectProfits', 'Global', '8', '全局保护利润', null, 'A', 1, null, null, null, null, null);




INSERT INTO `cfg_dict` (`id`, `pro_dict_id`, `domain_`, `code_`, `name_`, `desc_`, `status_`, `order_`) VALUES ('-600000001', '0', 'BIZ.Report.report_type', '101', 'AgentProfit', '代理利润表', 'A', '101');
