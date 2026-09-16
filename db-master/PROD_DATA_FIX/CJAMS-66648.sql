
/*
Issue Description: IHFS-Service Log
   Category/ Module: Service Log 
Root cause: User Requests to update service log end date with 2024-07-08.
Fix Provided: Updated the service log end date 
Code/Data fix ticket#: CJAMS-66648
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Update to correct the end date in service log through DB.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update:Query: updated the endate in person program, update investigation findings
*/
update tb_service_log
set end_dt='2024-07-08',
end_service_reason_cd='1824',
update_ts=now(),
update_user_id='CJAMS-66648'
where service_log_id in ('2954820', '2954787') and client_id='1273681' and delete_sw = 'N';

update tb_service_log
set end_dt='2024-07-08',
end_service_reason_cd='1824',
update_ts=now(),
update_user_id='CJAMS-66648'
where service_log_id= '2954853' and client_id='1295671' and delete_sw = 'N';