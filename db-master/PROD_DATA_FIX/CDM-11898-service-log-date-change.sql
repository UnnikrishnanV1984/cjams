update tb_service_log set end_dt = null, update_ts = now(), update_user_id = 'CDM-11898' where service_log_id = '981142';

update tb_service_purchase_authorization set end_dt = '2020-05-08', update_ts = now(), update_user_id = 'CDM-11898' where authorization_id = '758350';