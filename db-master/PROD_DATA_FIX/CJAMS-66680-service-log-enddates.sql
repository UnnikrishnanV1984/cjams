/*
   Issue Description: CJAMS-66680
   Root cause: Cannot complete GAP closing checklist due to wrong service log end dates with no pencil
   Fix Provided: Fix was done by updating the end dates as suggested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- select end_dt,* from tb_service_log where service_log_id='3633194';

update tb_service_log
set end_dt='2025-03-31', update_user_id='CJAMS-66680', update_ts =now()
where service_log_id='3633194' and end_dt ='2027-03-31';

-- select end_dt,* from tb_service_log where service_log_id='3633229';

update tb_service_log
set end_dt ='2025-05-31', update_user_id='CJAMS-66680', update_ts =now()
where service_log_id='3633229' and end_dt ='2026-03-12';