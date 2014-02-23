-- [E][xx][yy][mm][abcd] ;

-- 1~999常用提示
insert into cfg_message(code_, value_) 
values('1', '[{0}]输入不能为空！' );


insert into cfg_message(code_, value_) 
values('97', '已经成功创建记录！' );
insert into cfg_message(code_, value_) 
values('98', '已经成功更新记录！' );
insert into cfg_message(code_, value_) 
values('99', '已经成功删除记录！' );


-- 1000~1999系统级
insert into cfg_message(code_, value_, value_en) 
values('1000', '未登陆或已经超时，请重新登陆！', 'Login session timeout, please login again!' );

insert into cfg_message(code_, value_) 
values('1001', '当前用户没有操作权限！' );

insert into cfg_message(code_, value_) 
values('1031', '父权限不存在，本操作无效！' );

insert into cfg_message(code_, value_) 
values('1032', '子权限存在，本操作无效！' );

insert into cfg_message(code_, value_) 
values('1051', '父组织不存在，本操作无效！' );

insert into cfg_message(code_, value_) 
values('1052', '子组织存在，本操作无效！' );

insert into cfg_message(code_, value_) 
values('1061', '父角色不存在，本操作无效！' );

insert into cfg_message(code_, value_) 
values('1062', '子角色存在，本操作无效！' );

insert into cfg_message(code_, value_) 
values('1101', '用户不存在！' );

insert into cfg_message(code_, value_) 
values('1102', '用户被锁定，不能进行任何操作！' );

insert into cfg_message(code_, value_) 
values('1103', '用户没有操作权限，本次操作被禁止！' );

insert into cfg_message(code_, value_, value_en) 
values('1104', '用户密码不正确！', 'Password is not correct!' );

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
values('1198', '密码' );

insert into cfg_message(code_, value_) 
values('1199', '登录标识' );


insert into cfg_message(code_, value_) 
values('1211', '当前用户为海外联系人，请通过联系人方式删除！' );

insert into cfg_message(code_, value_) 
values('1212', '当前要删除的用户中包括海外联系人，这些用户，请通过联系人方式删除！' );

insert into cfg_message(code_, value_) 
values('1301', '字典表中已经存在[{0}]-[{1}]的定义，请修改编码再保存！' );



insert into cfg_message(code_, value_) 
values('E0001020001', '未能找到编号为%s的终端，请检查！' );

insert into cfg_message(code_, value_) 
values('E0001020002', '终端[%s]非活动状态，不能使用！' );

insert into cfg_message(code_, value_) 
values('E0001020003', '终端[%s]已开业，无需要重复开业！' );

insert into cfg_message(code_, value_) 
values('E0001020004', '终端[%s]已结业，无需要重复结业！' );

insert into cfg_message(code_, value_) 
values('E0001020005', '终端[%s]还没有开业，请先开业后再登录！' );

insert into cfg_message(code_, value_) 
values('E0001020006', '当前用户[%s]已经登录终端[%s]，不能登录其它终端！' );

insert into cfg_message(code_, value_) 
values('E0001020007', '当前仍未结业的终端如下：%s！' );

insert into cfg_message(code_, value_) 
values('E0001020008', '該員工所使用的终端未到使用日期,請核實後登入！' );

insert into cfg_message(code_, value_) 
values('E0001020009', '销售日期应该在%D之后！' );

insert into cfg_message(code_, value_) 
values('E0001020010', ' 店铺[%s]未开业状态下，终端不能开业！' );




insert into cfg_message(code_, value_) 
values('E0001030001', '未能找到编号为%s的店铺，请检查！' );

insert into cfg_message(code_, value_) 
values('E0001030002', '店铺[%s]非活动状态，不能使用！' );

insert into cfg_message(code_, value_) 
values('E0001030003', '店铺[%s]已开业，无需要重复开业！' );

insert into cfg_message(code_, value_) 
values('E0001030004', '店铺[%s]已结业，无需要重复结业！' );

insert into cfg_message(code_, value_) 
values('E0001030005', '該員工所在中心未到使用日期,請核實後登入！' );

insert into cfg_message(code_, value_) 
values('E0001030009', '销售日期应该在%D之后！' );


insert into cfg_message(code_, value_) 
values('E0101010001', '最多只有一条记录被更新！' );

insert into cfg_message(code_, value_) 
values('E0101010002', '最多只有一条记录被删除！' );

insert into cfg_message(code_, value_) 
values('E0101010003', '没有找到视图配置！' );


insert into cfg_message(code_, value_) 
values('E0101020001', '没有找到任务配置！' );




insert into cfg_message(code_, value_) 
values('101000', '请输入正确的顾客编号！' );

insert into cfg_message(code_, value_) 
values('101001', '没有找到顾客信息，请重新输入！' );

insert into cfg_message(code_, value_) 
values('101002', '顾客编号已经被使用，请重新输入！' );


insert into cfg_message(code_, value_) 
values('201000', '未能找到产品，产品编号是[%s]！' );
/*
create table cfg_message
(
    code_         VARCHAR(50)            not null,
    locale_       VARCHAR(64)            not null,
    value_        VARCHAR(500)            not null,
    constraint PK_SYNC_CONTROL primary key (code_)
)
*/