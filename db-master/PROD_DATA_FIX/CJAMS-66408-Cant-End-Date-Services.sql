/*
Issue Description: CJAMS-66408
Root Cause : Please carry out data fix to update the Actual End Date as 04/22/2025 in Service Log (Agency Provider Services)
Data fix :Updated the service log end date
Category/ Module: service
Pull request# N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: N/A

Actual End Date as 04/22/2025
*/

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CJAMS-66408' 
where service_log_id=3103119 and delete_sw = 'N';


update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CJAMS-66408' 
where service_log_id=3076223 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CJAMS-66408' 
where service_log_id=3076224 and delete_sw = 'N';

