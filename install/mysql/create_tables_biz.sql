drop table if exists biz_address;
drop table if exists biz_order;
drop table if exists biz_order_items;
drop table if exists biz_order_payment;

/*==============================================================*/
/* Table: 地址表                                                                                                                                */
/*==============================================================*/
create table biz_address  (
   id                bigint(12) not null AUTO_INCREMENT,
   name              VARCHAR(50) NOT NULL,
   mobile            VARCHAR(20),
   state             VARCHAR(50),
   city              VARCHAR(50),
   area              VARCHAR(50),
   address           VARCHAR(250),
   zip_code          VARCHAR(6),
   status            char(1) default '0' NOT NULL comment '0:正常，1：已删除',
   
   created_by        varchar(50) comment '创建的操作员Login_ID',
   created_on        datetime comment '创建的时间',
   updated_by        varchar(50) comment '更新的操作员Login_ID',
   updated_on        datetime comment '更新的时间，同时用作version_id',
   version_id        bigint comment '用于做DAO层的版本控制',
   
   constraint PK_BIZ_ADDRESS primary key (id)
} ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
   total             decimal(12,2) default 0.00 not null comment '整单总金额',
   comments          varchar(250) comment '备注',
   payment_type      CHAR(1) default '0' NOT NULL comment '付款类型:线上支付（0），线下支付（1）', 
   status            CHAR(1) default '0' NOT NULL comment '订单状态: ',
   status_payment    CHAR(1) default '0' NOT NULL comment '支付状态:未支付（0），已支付（1）', 
   status_checkout   CHAR(1) default '0' NOT NULL comment '出账状态:未出帐（0），可出帐（1），已出帐（1）', 
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
   ffmcentert_id     bigint(12) comment '仓库id',
   price             decimal(12,2) not null comment '单价',
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