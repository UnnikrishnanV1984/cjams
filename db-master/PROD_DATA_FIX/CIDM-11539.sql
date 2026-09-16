/*
Issue Description: CIDM-11539
Root Cause : system is validating the active program assignment (GAP) instead of the program assignment (Out of Home) which is added in the service log, this needs a code fix. Proceeding with the data fix to update the Actual End DateS For all out of home services(Agency Provider Services)
Data fix :Data fix is done to Update the service log end date
Is code fix Required: Y -CDM-44868
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: N/A


*/

----------------------------------------------------------------
update tb_service_log 
set end_dt='2025-08-01',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3702387 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-20',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3712910 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-05-20',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3693747 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3693749 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3693748 and delete_sw = 'N';

-----------------------------------------------------------
update tb_service_log 
set end_dt='2025-08-01',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3702389 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-20',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3712912 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3702388 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3693760 and delete_sw = 'N';

-------------------------------------------------------------

update tb_service_log 
set end_dt='2025-08-12',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796051 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-12-31',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796050 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-12',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796047 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-12',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796054 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-11',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796046 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-09',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3704212 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-02',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3701229 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-02',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3701228 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3701227 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3701226 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-12',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796049 and delete_sw = 'N';

--------------------------------------------------------------------------------



update tb_service_log 
set end_dt='2025-08-12',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796058 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-12-31',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796057 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-12',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796053 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-12',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796056 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-11',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3796052 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-09',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3704211 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-06-02',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3701225 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3693759 and delete_sw = 'N';

update tb_service_log 
set end_dt='2025-04-22',update_ts=now(),update_user_id='CIDM-11539' 
where service_log_id=3693750 and delete_sw = 'N';



