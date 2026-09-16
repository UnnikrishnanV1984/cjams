/*
Issue:3218511:Cannot close the service case due to a service log from 2021 not having an end date from a previous case under Nina Wallace. There is also no pencil icon to edit the service log
Root Cause:The service log was originally saved with an incorrect date. Because the service was linked to a program assignment that is now closed, the system prevented any corrections through the normal screens.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_log.
Data/Code fix ticket#: CJAMS-62167
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
select * from tb_service_log where client_id ='568025'and delete_sw ='N';
*/
update tb_service_log
set start_dt ='2014-06-23',update_user_id ='CJAMS-62167', update_ts =now(),end_service_reason_cd=1824,estimated_end_dt='2016-04-15'
where service_log_id in ('568025') and delete_sw='N' ;