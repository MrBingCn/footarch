/* system */
insert into cfg_message(code_, value_) 
values('1', '[{0}]输入不能为空！' );

insert into cfg_message(code_, value_) 
values('95', '已经成功发送信息！' );
insert into cfg_message(code_, value_) 
values('96', '操作成功！' );
insert into cfg_message(code_, value_) 
values('97', '已经成功创建记录！' );
insert into cfg_message(code_, value_) 
values('98', '已经成功更新记录！' );
insert into cfg_message(code_, value_) 
values('99', '已经成功删除记录！' );

/* 100~120 for DB*/
insert into cfg_message(code_, value_) 
values('100', '数据库操作异常！' );

insert into cfg_message(code_, value_) 
values('101', '需要操作的记录已经被其它程序更新，请重新查询数据后再做操作！[表名：{0}, {1}]' );


insert into cfg_message(code_, value_) 
values('102', '编码已经被使用，保存失败，请使用其它编码后再进行保存！' );

insert into cfg_message(code_, value_) 
values('103', '数据为系统保留数据，不能修改与删除！' );

insert into cfg_message(code_, value_) 
values('104', '数据为系统保留数据，不能删除！' );



/* 1000~1200 for User*/
insert into cfg_message(code_, value_) 
values('1000', '未登陆或已经超时，请重新登陆！' );

insert into cfg_message(code_, value_) 
values('1001', '当前用户没有操作权限！' );


insert into cfg_message(code_, value_) 
values('1101', '用户不存在！' );

insert into cfg_message(code_, value_) 
values('1102', '用户被锁定，不能进行任何操作！' );

insert into cfg_message(code_, value_) 
values('1103', '用户没有操作权限，本次操作被禁止！' );

insert into cfg_message(code_, value_) 
values('1104', '用户密码不正确！' );

insert into cfg_message(code_, value_) 
values('1105', '非终端用户，不能登录终端！' );

insert into cfg_message(code_, value_) 
values('1106', '用户已经成功登录！' );

insert into cfg_message(code_, value_) 
values('1107', '用户已经成功更改密码！' );

insert into cfg_message(code_, value_) 
values('1108', '密码为空，更改密码失败！' );

insert into cfg_message(code_, value_) 
values('1109', '原密码不正确，更改密码失败！' );

insert into cfg_message(code_, value_) 
values('1110', '用户登录标识已经被使用，请使用其它登录标识！' );

insert into cfg_message(code_, value_) 
values('1111', '用户被冻结，不能进行任何操作！' );

insert into cfg_message(code_, value_) 
values('1112', '用户非激活状态，不能登录！' );


insert into cfg_message(code_, value_) 
values('1113', '用户已经成功登出！' );


insert into cfg_message(code_, value_) 
values('1198', '密码' );

insert into cfg_message(code_, value_) 
values('1199', '登录标识' );


/* 1201~1250 for dump*/
insert into cfg_message(code_, value_) 
values('1201', '第{0}页，第{1}行，第{2}列不能为空！' );
insert into cfg_message(code_, value_) 
values('1202', '第{0}页，第{1}行，第{2}列必须为数字！' );
insert into cfg_message(code_, value_) 
values('1210', '第{0}页，第{1}行，第{2}列的值未能读取！' );
insert into cfg_message(code_, value_) 
values('1211', '第{0}条数据未能写入数据库，原因为{1}！' );



/* 22001 to 23000 for order */

insert into cfg_message(code_, value_) 
values('22001', '根据查询条件，未能获取报表数据！' );




INSERT INTO `cfg_resource` (`Key_`, `VALUE_`, `VALUE_en`)
VALUES ('CompanyName', '红葳足弓矫正有限公司', 'footarch');