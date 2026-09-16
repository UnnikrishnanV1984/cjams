DROP table if exists cjams.tb_payment_history;

CREATE TABLE cjams.tb_payment_history (
	payment_history_id int8 NOT NULL,
	payment_id int4 NULL,
	object_id varchar(50) NULL,
	object_key varchar(50) NULL,
	create_ts timestamp NULL,
	create_user_id varchar(50) NOT NULL,
	update_ts timestamp NULL,
	update_user_id varchar(50) NOT NULL,
	delete_sw bpchar(1) NULL,
	effective_end_dt timestamp NULL
);

DROP SEQUENCE  IF EXISTS sequence_tb_payment_history CASCADE; 
CREATE SEQUENCE sequence_tb_payment_history
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER  TABLE tb_payment_history ALTER COLUMN payment_history_id  SET DEFAULT nextval('sequence_tb_payment_history'::regclass);

alter table gapratesrevision 
drop column if exists gaprateid;

alter table gapratesrevision 
add column if not exists gaprateid  integer;

alter table gapratesrevision 
drop column if exists guardiansubsidyid;

alter table gapratesrevision 
add column if not exists guardiansubsidyid  integer;


