
/*
Issue Description: CJAMS-67643
Category/Module: service plan
Root cause: Unable to add a end date to a service. 
Fix provided: Data fix has been promoted to end the Open Service Log with Actual End Date as 01/23/2026.  
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/


update tb_service_log
set end_dt='2026-01-23', end_service_reason_cd ='1824', update_user_id='CJAMS-67643', update_ts=now()
where client_id='4360576' AND case_id='241030421304' and service_log_id ='4009987';