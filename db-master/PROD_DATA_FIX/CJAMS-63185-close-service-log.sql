/*
  Issue Description:
   Category/ Module  :  Service Log
   Root cause: Service Log end date missing
   Fix provided : dbquery is provided to do the datafix to end the service log.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update tb_service_log 
set end_dt = '2025-11-03',
	update_ts = now(),
	update_user_id = 'CJAMS-63185'
where service_log_id in (3791783,3791785)
	and delete_sw = 'N'
	and case_id = '251030565291';