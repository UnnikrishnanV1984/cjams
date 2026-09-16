-- CDM-9375
update tb_service_log set end_dt = '2020-10-09', update_ts = now(),update_user_id = 'CDM-9375' where
service_log_id in (1961199,1961073) and client_id = 4493322 and case_id = 3307881;


-- CDM-12115
update tb_service_log set end_dt = '2020-07-30', update_ts = now(),update_user_id = 'CDM-12115'
where service_log_id in (976373) and client_id = 4420636 and case_id = 3165019;