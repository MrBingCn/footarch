CREATE SCHEMA `loss` DEFAULT CHARACTER SET utf8 ;

CREATE INDEX index_status ON biz_order(agent_id,sales_id,op_operator,bus_id,spe_id,record_status,broker_end_date,status)
CREATE INDEX index_message ON biz_message_receive(user_id,company_id,read_on)
