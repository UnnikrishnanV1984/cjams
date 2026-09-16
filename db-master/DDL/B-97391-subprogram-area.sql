alter table tb_service_log add column if not exists agency_sub_program_area_id varchar(30);

comment on column cjams.tb_service_log.agency_sub_program_area_id is 'agency sub-program area key';