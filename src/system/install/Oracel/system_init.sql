
--delete from CFG_DICT where dict_id=-2;
-- domain_=>table_name, code_=>Id, name_=>params, desc_=>sql
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-1, 'Cache_Sql', 'Dict', 'subTable=domain_', 'select code_ as id, name_ , desc_ , domain_ from CFG_DICT where domain_!=''Cache_Sql'' and status_ = ''A'' order by domain_,order_ ', 'A', 1) ;


insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-4, 'Cache_Sql', 'Message', '', 'select code_ as id, value_ from CFG_Message ', 'A', 4) ;

/*
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-2, 'Cache_Sql', 'ShopProfile', 'id=shop_profile_id', 'select * from sys_shop;select * from sys_shop_attr', 'A', 2) ;
  
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-3, 'Cache_Sql', 'TerminalProfile', 'id=terminal_profile_id', 'select * from sys_terminal;select * from sys_terminal_attr', 'A', 3) ;

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-4, 'Cache_Sql', 'Message', '', 'select code_ as id, value_ from SYS_Message ', 'A', 4) ;

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-5, 'Cache_Sql', 'Product', 'id=item_number', 'select * from Product_Product ', 'A', 4) ;
  
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-6, 'Cache_Sql', 'PAYMENT_METHOD', 'id=code_', 'select p.code_, p.name_, p.currency_code, p.desc_ from PAYMENT_METHOD p  left join CURRENCY c on p.currency_code=c.code_ order by c.type_, index_', 'A', 6) ;
  
 
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-7, 'Cache_Sql', 'CURRENCY', 'id=code_', 'select * from CURRENCY order by name_', 'A', 7) ;
*/



-- ==============================================================
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10, 'CM.dictStatus', 'A', '激活-可用', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-11, 'CM.dictStatus', 'C', '取消-不可用', '', 'A', 2);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-13, 'CM.status', 'A', '激活-可用', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-14, 'CM.status', 'C', '取消-不可用', '', 'A', 2);


insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-16, 'CM.status_', '1', '激活-可用', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-17, 'CM.status_', '0', '取消-不可用', '', 'A', 2);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-21, 'CM.yes.no', '1', '是', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-22, 'CM.yes.no', '0', '否', '', 'A', 2);


insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-100, 'FM.Config', 'upload.dir', 'data/upload', '文件上传路目录', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-101, 'FM.Config', 'index.dir', 'data/index', '文件索引目录，全文索引存放', 'A', 2);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-102, 'FM.Config', 'photo.types', 'jpg,jpeg,gif,png,bmp', '图片文件类型', 'A', 3);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-103, 'FM.Config', 'gui.thumbnail.size', '150', 'gui.thumbnail.size', 'A', 4);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-104, 'FM.Config', 'gui.thumbnail.quality', '0.6', 'gui.thumbnail.quality', 'A', 5);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-105, 'FM.Config', 'gui.thumbnail.scale', '4', 'gui.thumbnail.scale', 'A', 6);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-150, 'FM.analysis', 'zh', 'org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-151, 'FM.analysis', 'en', '-', '', 'A', 2);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-160, 'FM.searches', '0', 'com.globalwave.filemanage.searchengine.FulltextSearch', 'com.globalwave.filemanage.searchengine.FulltextSearchOptions', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-161, 'FM.searches', '1', 'com.globalwave.filemanage.searchengine.TagSearch', 'com.globalwave.filemanage.searchengine.SearchOptions', 'A', 2);




insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-170, 'FM.thumbnails', 'jpg', 'com.globalwave.filemanage.thumbnail.ImageThumbnailBuilder', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-171, 'FM.thumbnails', 'jpeg', 'com.globalwave.filemanage.thumbnail.ImageThumbnailBuilder', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-172, 'FM.thumbnails', 'gif', 'com.globalwave.filemanage.thumbnail.ImageThumbnailBuilder', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-173, 'FM.thumbnails', 'png', 'com.globalwave.filemanage.thumbnail.ImageThumbnailBuilder', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-174, 'FM.thumbnails', 'bmp', 'com.globalwave.filemanage.thumbnail.ImageThumbnailBuilder', '', 'A', 1);

/*
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-175, 'FM.thumbnails', 'tif', 'com.globalwave.filemanage.thumbnail.ImageThumbnailBuilder', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-176, 'FM.thumbnails', 'tiff', 'com.globalwave.filemanage.thumbnail.ImageThumbnailBuilder', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-177, 'FM.thumbnails', 'pdf', 'com.globalwave.filemanage.thumbnail.ImageThumbnailBuilder', '', 'A', 1);
*/


-- SystemConfig
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000001, 'SC.shop.type_', '0', '专卖店', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000002, 'SC.shop.type_', '1', '服务网点', '', 'A', 2);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000003, 'SC.shop.type_', 'S', 'MiniShop', '', 'A', 3);


insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000101, 'SC.shop.area_code', 'NC', '华北', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000102, 'SC.shop.area_code', 'SC', '华南', '', 'A', 2);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000103, 'SC.shop.area_code', 'EC', '华东', '', 'A', 3);



insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000201, 'SC.shop.shop_status', '1', '开业', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000202, 'SC.shop.shop_status', '0', '结业', '', 'A', 2);



insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000205, 'SC.terminal.type_', '0', '收银机', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-10000206, 'SC.terminal.type_', '1', '服务柜台', '', 'A', 2);



-- SystemConfig
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-60000001, 'CRM.customer.type_', '0', '客户', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-60000002, 'CRM.terminal.type_', '1', '供应商', '', 'A', 2);


insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-60000006, 'CRM.customer.id_type', '0', '身份证', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-60000007, 'CRM.terminal.id_type', '1', '营业执照', '', 'A', 2);


/*
insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-90000001, 'EPS.capacitance_unit', '1', 'KVA', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-90000011, 'EPS.project.type_', '1', '用户工程', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-90000012, 'EPS.project.type_', '2', '政府工程', '', 'A', 2);


insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-90000021, 'EPS.complete.percentage', '0', '未开始', '', 'A', 1);

insert into CFG_DICT(id, domain_, code_, name_, desc_, status_, order_)
values(-90000022, 'EPS.complete.percentage', '100', '完成', '', 'A', 2);
*/

