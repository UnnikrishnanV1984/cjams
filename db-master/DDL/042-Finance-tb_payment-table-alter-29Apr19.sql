alter table tb_payment_receipt 
drop column if exists create_ts ;

alter table tb_payment_receipt 
drop column if exists update_ts ;

alter table tb_payment_receipt 
add column  create_ts  timestamp without time zone;

alter table tb_payment_receipt 
add column   update_ts  timestamp without time zone;