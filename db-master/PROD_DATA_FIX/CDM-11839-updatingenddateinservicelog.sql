-- CDM-11839
update tb_service_log set end_dt = '2021-01-14', update_ts = now(),update_user_id = 'CDM-11839' where service_log_id in (947355,
946004,
942825,
910918,
883390,
879501) and client_id = 4268067 and case_id = 3129183