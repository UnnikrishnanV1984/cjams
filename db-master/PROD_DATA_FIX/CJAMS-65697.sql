
/*Issue:Please proceed with data fix for the below client & provider ID
1) Case ID: 3286395
Client ID: 4215598 (JASPER THOMPSON)
Provider ID: 6089662 (Caliday of Joppatowne), Service: Child Care (Paid), End Date: 01/18/2024
1. Actual End date - 01/18/2024 .
2. Service End Reason - Service Completed.
3. This information needs to be updated on the PDF print.

2) Case ID: 3286395
Client ID: 4215598 (JASPER THOMPSON)
Provider ID: 5007223 (YMCA of Frederick County), Service: Child Care (Paid), End Date: 06/02/2023
1. Actual End date - 06/02/2023.
2. Service End Reason - Service Completed.
3. The same needs to be updated on the PDF print.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_log.
Data/Code fix ticket#: CJAMS-65697
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_service_log tsl set end_dt='2024-01-18',update_user_id ='CJAMS-65697',
update_ts =now(),end_service_reason_cd=1824  where service_log_id in ('2851813') and delete_sw='N';

update tb_service_log tsl set end_dt='2023-06-02',update_user_id ='CJAMS-65697', 
update_ts =now(),end_service_reason_cd=1824 where service_log_id in ('2075108') and delete_sw='N';
