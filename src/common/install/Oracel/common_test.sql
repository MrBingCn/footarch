
insert into COMMON_VIEW(view_id, name_, code_,type_,index_) 
values(-10000, 'Shop模板', 'SHOP_A','A',1000);

select * from COMMON_VIEW where view_id=-10000;
delete from COMMON_VIEW where view_id=-10000;

delete from COMMON_FIELD where field_id=-10101
insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) 
values(-10100,-10000,'邮编','post_code', 0, 12, 1, 50) ;

insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length, input_type, input_params) 
values(-10101,-10000,'自定义状态','status', 0, 12, 2, 50, 'CodeComboBox', 'CM.dictStatus:id:name_') ;

select * from COMMON_FIELD

CodeComboBox

select * FROM SYS_Shop_Attribute WHERE  shop_profile_id = ?  
--insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) values(-10101,-10000,'','type_', 0, 12, 2, 5) ;
--insert into COMMON_FIELD(field_id, view_id, name_, code_, is_nullable, type_, index_, max_length) values(-10102,-10000,'事件名称','name_', 0, 12, 3, 50) ;
select * from ( select row_.*, rownum rownum_ from ( select * from (Select * from COMMON_VIEW) a  order by index_ asc ) row_ where rownum <= -1) where rownum_ > 0

select * from common_view where code_='system_dict'
   10031        10030          10032 system_dict system_dict G          0 NULL        NULL           select * from system_dict NULL         NULL         NULL        NULL        NULL                    1             1             1 NULL   NULL   NULL   NULL   NULL     NULL   NULL   NULL

update common_view set privilege_code='10100' where view_id=10031