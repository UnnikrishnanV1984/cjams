-- DROP TABLE IF EXISTS cjams.tb_provider_closure_history;

CREATE TABLE cjams.tb_provider_closure_history (
history_id int4 NOT NULL,
provider_id int4 NOT NULL,
open_dt date NULL,
close_dt date NULL,
close_reason_cd varchar(5) NULL,
comments_tx varchar(500) NULL,
open_staff_id int4 NULL,
open_supervisor_id int4 NULL,
close_staff_id int4 NULL,
close_supervisor_id int4 NULL,
create_ts timestamp NULL,
create_user_id varchar(25) NOT NULL,
update_ts timestamp NULL,
update_user_id varchar(25) NOT NULL,
delete_sw bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
approval_status_cd bpchar(5) NULL
);