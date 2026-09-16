alter table cjams.tb_service_log add column if not exists end_service_subcategory_reason varchar(10);
comment on column cjams.tb_service_log.end_service_subcategory_reason is 'Subcategory for End Reason';

alter table cjams.tb_service_log add column if not exists end_reason_desc_tx varchar(500);
comment on column cjams.tb_service_log.end_reason_desc_tx is 'Justification for End Reason';