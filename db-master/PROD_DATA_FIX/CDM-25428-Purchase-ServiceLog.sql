/*
   Issue Description: CDM-25428
   Category/ Module  : Purchase Auth and Service log 
   Root cause: User requested to end date
   Pull request# for code fix: 6727
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/
update tb_service_purchase_authorization    
set sprvsr_approval_status_cd = '3281', -- Denied
    update_ts = now(), 
    update_user_id = 'CDM-25428'
where authorization_id = 518483
    and delete_sw = 'N';

update tb_service_log set end_dt = '2019-08-30', update_user_id = 'CDM-25428', update_ts = now() 
where service_log_id = 945922;

update tb_service_log set end_dt = '2020-06-08', update_user_id = 'CDM-25428', update_ts = now() 
where service_log_id  = 1958951;