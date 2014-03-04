drop table if exists biz_address;
drop table if exists biz_order;
drop table if exists biz_order_items;
drop table if exists biz_order_payment;

/*==============================================================*/
/* Table: 地址表                                                                                                                                */
/*==============================================================*/
create table biz_address  (
   id                bigint(12) not null AUTO_INCREMENT,
   user_id           bigint(12) not null,
   name              VARCHAR(50) not null,
   mobile            VARCHAR(20),
   state             VARCHAR(50),
   city              VARCHAR(50),
   area              VARCHAR(50),
   address           VARCHAR(250),
   zip_code          VARCHAR(6),
   is_default        char(1) default '0' NOT NULL comment '0:非默认，1：默认',
   status            char(1) default '0' NOT NULL comment '0:正常，1：已删除',
   
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   
   constraint PK_BIZ_ADDRESS primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: 订单主表                                                                                                                            */
/*==============================================================*/
create table biz_order  (
   id                bigint(12) not null AUTO_INCREMENT,
   user_id           bigint(12) not null,
   address_id        bigint(12),
   time_place        datetime comment '提交订单时间',
   time_pay          datetime comment '支付时间',
   time_checkout     datetime comment '出账时间',
   total_product     decimal(12,2) default 0.00 not null comment '商品总金额',
   total_shipping    decimal(12,2) default 0.00 not null comment '运费总金额',
   total_adjustment  decimal(12,2) default 0.00 not null comment '整单调整金额',
   total             decimal(12,2) default 0.00 not null comment '整单付款总金额',
   
   order_agent_level int comment '下订单的代理等级，1:省级代理，2:市级代理，3:区级代理，4:终端代理，5:预留代理',
   
   ar_amount_0       decimal(12,2) default 0.00 not null comment '零级代理/台湾工厂的 应收金额',
   
   agent_id_1        bigint(12) comment '一级代理/省级代理 的 id',
   ar_amount_1       decimal(12,2) default 0.00 not null comment '一级代理/省级代理 的 应收金额',
   
   agent_id_2        bigint(12) comment '二级代理/市级代理 的 id',
   ar_amount_2       decimal(12,2) default 0.00 not null comment '二级代理/市级代理 的 应收金额',
   
   agent_id_3        bigint(12) comment '三级代理/区级代理 的 id',
   ar_amount_3       decimal(12,2) default 0.00 not null comment '三级代理/区级代理 的 应收金额',
   
   agent_id_4        bigint(12) comment '四级代理/终端代理 的 id',
   ar_amount_4       decimal(12,2) default 0.00 not null comment '四级代理/终端代理 的 应收金额',
   
   agent_id_5        bigint(12) comment '五级代理/预留代理 的 id',
   ar_amount_5       decimal(12,2) default 0.00 not null comment '五级代理/预留代理 的 应收金额',
   
   sale_id           bigint(12) comment '销售员，预留，用于提成，出报表',
   sale_name         varchar(250) comment '销售员，预留，用于提成，出报表',
   commission        decimal(12,2) default 0.00 not null comment '佣金；回扣',
   
   
   comments          varchar(250) comment '备注',
   payment_type      CHAR(2) default '-1' NOT NULL comment '付款类型:线上支付（-1），线下支付（1）', 
   status            CHAR(1) default 'P' NOT NULL comment '订单状态: 购物车（T）,已提交（M）,已支付（C），已审核（A），已打包（P），已发货（D），已取消（X）',
   status_payment    CHAR(1) default '0' NOT NULL comment '支付状态:未支付（0），已支付（1）', 
   status_checkout   CHAR(1) default '0' NOT NULL comment '出账状态:未出帐（0），可出帐（1），已出帐（2）', 
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   
   constraint PK_BIZ_ORDER primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: 订单明细表                                                                                                                            */
/*==============================================================*/
create table biz_order_items  (
   id                bigint(12) not null AUTO_INCREMENT,
   order_id          bigint(12) not null,
   catentry_id       bigint(12) not null comment '商品id',
   name              varchar(50) comment '商品名称',
   ffmcentert_id     bigint(12) comment '仓库id',
   list_price        decimal(12,2) not null comment '吊牌价',
   price             decimal(12,2) not null comment '售价',
   quantity          int default 1 not null, 
   adjustment        decimal(12,2) default 0.00 not null comment '调整金额',

   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   
   constraint PK_BIZ_ORDER_ITEMS primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: 付款明细表                                                                                                                            */
/*==============================================================*/
create table biz_order_payment  (
   id                bigint(12) not null AUTO_INCREMENT,
   order_id          bigint(12) not null,
   expected_amount   decimal(12,2) default 0.00 not null comment '',
   approving_amount  decimal(12,2) default 0.00 not null comment '',
   approved_amount   decimal(12,2) default 0.00 not null comment '',
   pay_system_name   varchar(50) comment '支付渠道',
   time_pay          datetime comment '支付时间',
   status            CHAR(1) default '0' NOT NULL comment '状态: 正常(0)，删除(1)',
    
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   
   constraint PK_BIZ_ORDER_PAYMENT primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





/*==============================================================*/
/* Table: 产品分类                                                                                                                            */
/*==============================================================*/

create table biz_product_category  (
    id                 bigint(12)                     not null AUTO_INCREMENT,
    pro_product_category_id bigint(12)  comment '该分类的父id，取值于该表的 cat_id字段', 
    name_cn            VARCHAR(250)  comment '分类名称 ',
    name_en            VARCHAR(250)  comment '分类名称 ',
    keywords_         varchar(250)  comment '分类的关键字，可能是为了搜索 ',
    desc_             varchar(2500)  comment '分类描述 ',
    order_            int comment '该分类在页面显示的顺序，数字越大顺序越靠后；同数字，id在前的先显示', 
    is_show_in_nav    int comment '是否显示在导航栏，0，不；1，显示在导航栏 ',
    is_show           int comment '是否在前台页面显示，1，显示；0，不显示 ',
   
    record_status     CHAR(1) default 'A' NOT NULL,
   
    created_by         varchar(50) comment '创建的操作员Login_ID',
    created_on         datetime comment '创建的时间',
    updated_by         varchar(50) comment '更新的操作员Login_ID',
    updated_on         datetime comment '更新的时间，同时用作version_id',
    version_id         bigint comment '用于做DAO层的版本控制',
    constraint PK_biz_product_category primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*==============================================================*/
/* Table: 产品                                                                                                                         */
/*==============================================================*/
create table biz_product  (
    id                 bigint(12)   not null AUTO_INCREMENT,
    product_category_id bigint(12)  comment '商品所属商品分类id，取值 ecs_category的cat_id ',
    brand_id bigint(12)  comment '品牌id，取值于ecs_brand 的 brand_id ',
    
    code_ varchar(50)  comment '商品的唯一货号 ',
    name_cn varchar(250)  comment '商品的CN名称 ',
    name_en varchar(250)  comment '商品的EN名称 ',
    short_desc varchar(250)  comment '商品的简短描述 ',
    full_desc text  comment '商品的详细描述 ',
    keywords_ varchar(250)  comment '商品关键字，放在商品页的关键字中，为搜索引擎收录用 ',
    main_photo_uuid varchar(250)  comment '商品在前台显示的微缩图片，如在分类筛选时显示的小图片 ',
    
    click_count int  comment '商品点击数 ',
    provider_name varchar(250)  comment '供货人的名称，程序还没实现该功能 ',
    weight_ decimal(12,2)  comment '商品的重量，以千克为单位 ',
    
    market_price decimal(12,2)  comment '市场售价 ',
    selling_price decimal(12,2)  comment '本店售价 ',
    
    promote_price decimal(12,2)  comment '促销价格 ',
    promote_start_on datetime  comment '促销价格开始日期 ',
    promote_end_on datetime  comment '促销价结束日期 ',
    
    inventory_total_quantity int  comment '商品库存数量 ',
    inventory_safety_quantity int  comment '商品报警数量 ',
    
    record_status     CHAR(1) default 'A' NOT NULL,
   
    created_by         varchar(50) comment '创建的操作员Login_ID',
    created_on         datetime comment '创建的时间',
    updated_by         varchar(50) comment '更新的操作员Login_ID',
    updated_on         datetime comment '更新的时间，同时用作version_id',
    version_id         bigint comment '用于做DAO层的版本控制',
    constraint PK_biz_product primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*==============================================================*/
/* Table: 产品图片                                                                                                                          */
/*==============================================================*/
create table biz_product_photo  (
   id                   bigint not null auto_increment comment '标识',
   product_id             bigint comment 'product ID',
   folder_name          varchar(6) comment 'yyyymm作为文档的文件夹，不可改',
   file_uuid            varchar(36) comment '文件的uuid，作为系统文件名称，不可改',
   document_name        varchar(150) comment '文档名称',
   document_type        varchar(1) comment '文档类型',
   desc_                varchar(500) comment '文档描述',
   record_status        char(1) comment '记录状态，用于逻辑删除
            A-Active
            C-Cancel',
   order_               int comment '记录顺序',
   version_id           bigint comment '版本号，保留，数据更新时，用于“乐观锁”，放置时间的long(java)形式',
   created_by           varchar(50) comment '创建的操作员Login_ID',
   created_on           datetime comment '创建的时间',
   updated_by           varchar(50) comment '更新的操作员Login_ID',
   updated_on           datetime comment '更新的时间，同时用作version_id',
   primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

