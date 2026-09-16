/*
Issue Description: CDM-31269
Root Cause :Service log end date is future date in service log
Data fix :Updated the service log end date
Category/ Module: service
Pull request# N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_service_log set end_dt=null,update_ts=now(),update_user_id='CDM-31269' where service_log_id=927075;

