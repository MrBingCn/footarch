xxx


-- ========================================
delete from SYS_TASK_CONFIG;
insert into SYS_TASK_CONFIG(TASK_CONFIG_ID, CODE_, COMMAND_TYPE, COMMAND_CONTENT,TASK_TYPE, CRON_SEQUENCE,TASK_STATUS)
values(1, 'TEST', 'J', 'com.globalwave.common.task.TestTask', 'S', '* 0-59 * * * *', 'A');

insert into SYS_TASK_CONFIG(TASK_CONFIG_ID, CODE_, COMMAND_TYPE, COMMAND_CONTENT,COMMAND_PARAMS,TASK_TYPE, TRIGGER_PERIOD,TASK_STATUS)
values(2, 'BST01', 'S', 'O','sourceDbCode=db2&batchDbCode=oracle', 'P', '10', 'A');

insert into SYS_TASK_CONFIG(TASK_CONFIG_ID, CODE_, COMMAND_TYPE, COMMAND_CONTENT,COMMAND_PARAMS,TASK_TYPE, TRIGGER_PERIOD,TASK_STATUS)
values(3, 'BST03', 'S', 'M','sourceDbCode=oracle&syncConfigCode=BATCH_CLEAR_O', 'P', '10', 'A');


insert into SYS_TASK_CONFIG(TASK_CONFIG_ID, CODE_, COMMAND_TYPE, COMMAND_CONTENT,COMMAND_PARAMS,TASK_TYPE, TRIGGER_PERIOD,TASK_STATUS)
values(4, 'BST04', 'S', 'I','sourceDbCode=db2&syncConfigCode=ORDER_SYNC_TEST', 'P', '10', 'A');


-- ===========================   SYNC_CONFIG/SUNC_COLUMNS
delete from SYNC_CONFIG
-- ===========================   
insert into SYNC_CONFIG values(-1, 'ORDER_SYNC_TEST', 'db2', 'oracle', 2, 0, 'MS_DMSORD', 'TEST_ORDER','','','I',1,20,0,0 );

delete from SYNC_COLUMNS where sync_config_id=-1;
insert into SYNC_COLUMNS values(-1,-1,0,'ID','',1,1,0,'transfer_status','');
insert into SYNC_COLUMNS values(-2,-1,0,'ORDER_ID','',1,0,0,'','');

insert into SYNC_COLUMNS values(-3,-1,1,'TMESTM','',0,1,0,'','');
insert into SYNC_COLUMNS values(-4,-1,1,'version_ID','',0,0,0,'','');

insert into SYNC_COLUMNS values(-5,-1,2,'Dist_Number','',0,1,0,'','');
insert into SYNC_COLUMNS values(-6,-1,2,'Dist_Number','',0,0,0,'','');

insert into SYNC_COLUMNS values(-7,-1,3,'Sale_Date','',0,1,0,'','');
insert into SYNC_COLUMNS values(-8,-1,3,'Sale_Date','',0,0,0,'','');

insert into SYNC_COLUMNS values(-9,-1,4,'Process_Date','',0,1,0,'','');
insert into SYNC_COLUMNS values(-10,-1,4,'Process_Date','',0,0,0,'','');

insert into SYNC_COLUMNS values(-11,-1,5,'Process_Time','',0,1,0,'','');
insert into SYNC_COLUMNS values(-12,-1,5,'Process_Time','',0,0,0,'','');

insert into SYNC_COLUMNS values(-13,-1,6,'Staff_Number','',0,1,0,'','');
insert into SYNC_COLUMNS values(-14,-1,6,'Staff_ID','',0,0,0,'','');



-- ===========================   order head
insert into SYNC_CONFIG values(-2, 'ORDER_HEAD_SYNC_5G', 'db2', 'pos5g', 2, 0, 'ms_ordhdr', 'Order_Head','','','O',1,20,0,0 );

delete from SYNC_COLUMNS where sync_config_id=-2;
insert into SYNC_COLUMNS values(-101,-2,0,'ID','',1,1,0,'key_number_1','');
insert into SYNC_COLUMNS values(-102,-2,0,'ORDER_ID','',1,0,0,'','');

insert into SYNC_COLUMNS values(-103,-2,1,'TMESTM','',0,1,0,'','');
insert into SYNC_COLUMNS values(-104,-2,1,'Created_Timestamp','',0,0,0,'','');
                                      
insert into SYNC_COLUMNS values(-105,-2,2,'orddst','',0,1,0,'','');
insert into SYNC_COLUMNS values(-106,-2,2,'Distributor_Number','',0,0,0,'','');
                                      
insert into SYNC_COLUMNS values(-107,-2,3,'saldte','',0,1,0,'','com.globalwave.datasync.convertor.impl.BigDecimal2Date');
insert into SYNC_COLUMNS values(-108,-2,3,'Sale_Date','',0,0,0,'','');
                                      
insert into SYNC_COLUMNS values(-109,-2,4,'cntcde','',0,1,0,'','');
insert into SYNC_COLUMNS values(-110,-2,4,'Shop_Code','',0,0,0,'','');
                                      
insert into SYNC_COLUMNS values(-111,-2,5,'rtrim(char(int(prcdte)))||rtrim(char(int(strtme)))','',0,1,0,'','com.globalwave.datasync.convertor.impl.String2Timestamp');
insert into SYNC_COLUMNS values(-112,-2,5,'Last_Modified_Timestamp','',0,0,0,'','');
                                      
insert into SYNC_COLUMNS values(-113,-2,6,'rtrim(char(int(ordpfx)))||rtrim(char(int(ordnum)))','',0,1,0,'','');
insert into SYNC_COLUMNS values(-114,-2,6,'Order_Number','',0,0,0,'','');

-- ================== order line SYNC
insert into SYNC_CONFIG values(-3, 'ORDER_LINE_SYNC_5G', 'db2', 'pos5g', 2, 0, 'ms_orddtl', 'Order_Line','','','O',1,20,0,1 );


delete from SYNC_COLUMNS where sync_config_id=-3;

insert into SYNC_COLUMNS values(-201,-3,0,'ID','',1,1,0,'key_number_1','');
insert into SYNC_COLUMNS values(-202,-3,0,'order_line_id','',1,0,0,'','');
                                 
insert into SYNC_COLUMNS values(-203,-3,1,'parentid','',0,1,0,'','');
insert into SYNC_COLUMNS values(-204,-3,1,'order_id','',0,0,0,'','');
                                 
insert into SYNC_COLUMNS values(-205,-3,2,'itmnum','',0,1,0,'','');
insert into SYNC_COLUMNS values(-206,-3,2,'sku_item_number','',0,0,0,'','');
                                 
insert into SYNC_COLUMNS values(-207,-3,3,'itmop','',0,1,0,'','');
insert into SYNC_COLUMNS values(-208,-3,3,'unit_orginal_price','',0,0,0,'','');
                                 
insert into SYNC_COLUMNS values(-209,-3,4,'itmop','',0,1,0,'','');
insert into SYNC_COLUMNS values(-210,-3,4,'unit_discount_price','',0,0,0,'','');



-- ================== order line SYNC
insert into SYNC_CONFIG values(-4, 'BATCH_CLEAR_O', 'oracle', 'oracle', 0, 0, 'SYS_SYNC_BATCH', 'SYNC_BATCH_BACKUP','','','M',1,20,0,0 );


delete from SYNC_COLUMNS where sync_config_id=-4;

insert into SYNC_COLUMNS values(-401,-4,0,'*','',0,1,0,'','');
insert into SYNC_COLUMNS values(-402,-4,0,'*','',0,0,0,'','');

insert into SYNC_COLUMNS values(-403,-4,1,'SYNC_BATCH_ID','',1,1,0,'','');
insert into SYNC_COLUMNS values(-404,-4,1,'SYNC_BATCH_ID','',1,0,0,'','');

insert into SYNC_COLUMNS values(-405,-4,2,'SYNC_FLAG','''S''',0,1,1,'','')


-- =====================================
delete from SYS_SYNC_BATCH;
insert into SYS_SYNC_BATCH(SYNC_BATCH_ID, SYNC_CONFIG_CODE, KEY_NUMBER_1, PROGRAM_NAME, ENTRY_DATE, SYNC_FLAG)
values(1, 'ORDER_HEAD_SYNC_5G', 183148, 'Sync', to_date('2011-01-01', 'YYYY-MM-DD'), 'R');

insert into SYS_SYNC_BATCH(SYNC_BATCH_ID, SYNC_CONFIG_CODE, KEY_NUMBER_1, PROGRAM_NAME, ENTRY_DATE, SYNC_FLAG)
values(2, 'ORDER_LINE_SYNC_5G', 307792913, 'Sync', to_date('2011-01-01', 'YYYY-MM-DD'), 'R');

insert into SYS_SYNC_BATCH(SYNC_BATCH_ID, SYNC_CONFIG_CODE, KEY_NUMBER_1, PROGRAM_NAME, ENTRY_DATE, SYNC_FLAG)
values(3, 'ORDER_LINE_SYNC_5G', 294465400, 'Sync', to_date('2011-01-01', 'YYYY-MM-DD'), 'R');


insert into SYS_SYNC_BATCH(SYNC_BATCH_ID, SYNC_CONFIG_CODE, KEY_NUMBER_1, PROGRAM_NAME, ENTRY_DATE, SYNC_FLAG)
values(4, 'ORDER_LINE_SYNC_5G', 294465400, 'Sync', to_date('2011-01-01', 'YYYY-MM-DD'), 'S');





-- ==============================================================

insert into SYNC_CONFIG values(-6, '4G_to_5G_ts_stock', 'db2', 'pos5g', 2, 0, 'ts_stcque', 'tstb_Inventory_Transaction','select TMESTM, WRHCDE, STCNUM, ACTCDE, ACTQTY, int2timestamp(int(SALDTE)), id, '4G' as SRCTYP, 0 as TSFSTS from HS_STCQUE where id>? fetch first 20 rows only with ur','insert into tstb_Inventory_Transaction(id, Modified_Timestamp, Warehouse_Code,Stock_Item_Number,Transaction_Code,Transaction_Quantity,Transaction_Date_Time,Reference_ID,Reference_Source,Transfer_Status) values (TSSQ_INVENTORY_TRANSACTION_ID.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)','I',1,20,0,0 );



---        xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

delete from TEST_ORDER

select count(*) from TEST_ORDER where rownum<100

select key_string_3, entry_date, biz_id, key_short_1, sync_batch_id, remark, sync_config_code, key_number_2, process_date, key_string_2, times_of_fail, program_name, key_string_1, key_number_1, sync_flag, sync_batch_id from SYS_SYNC_BATCH where sync_batch_id>=0  and sync_flag='S' order by sync_batch_id
select biz_id, times_of_fail, key_string_1, key_string_2, program_name, sync_batch_id, key_number_2, key_number_1, key_string_3, sync_config_code, remark, key_short_1, process_date, entry_date, sync_flag, sync_batch_id from SYS_SYNC_BATCH where  1=1  and sync_batch_id>0  and sync_flag='S' 
select * from SYS_SYNC_BATCH

select * from SYNC_CONTROL

delete from SYNC_CONTROL




select key_string_3, entry_date, biz_id, key_short_1, sync_batch_id, remark, sync_config_code, key_number_2, process_date, key_string_2, times_of_fail, program_name, key_string_1, key_number_1, sync_flag, sync_batch_id from SYS_SYNC_BATCH where sync_batch_id>=0  and sync_flag='S' order by sync_batch_id
select * from SYNC_CONFIG 

delete from sys_task_log;
select * from sys_task_log;
delete from SYS_SYNC_RECORD_BACKUP;

select * from SYS_SYNC_BATCH
select * from SYNC_BATCH_backup

delete from SYS_SYNC_RECORD_BACKUP
select * from SYS_SYNC_RECORD_BACKUP


select * from Order_Header
select order_id, created_timestamp, dist_number, sale_date, shop_code, last_modified_timestamp, order_number from Order_Header where  1=1   
select * from sys_task_log 
delete from sys_task_log
select * from SYS_TASK_CONFIG



select * from sys_task_log 
update sys_task_log set task_log_id=task_log_id

select * from SYS_SHOP_ATTRIBUTE

select * from SYS_TERMINAL_ATTRIBUTE
select * from TEST_ORDER
select max(ORDER_ID) from TEST_ORDER

select * from SYNC_CONTROL

delete from SYNC_CONTROL

select id, tmestm, cntcde, stfnum, ordpfx, ordnum, prcdte, strtme, saldte, ordop, bsnrcr from ms_ordhdr  fetch first 20 rows only with ur;

select * from sys_shop_profile


