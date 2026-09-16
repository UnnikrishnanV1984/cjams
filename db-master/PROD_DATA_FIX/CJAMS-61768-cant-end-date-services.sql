/*
   Issue Description: CJAMS-61768
   Category/ Module  : service log
   Root cause:user requested to end service log end dates
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log
set end_dt = estimated_end_dt,
	update_ts = now(),
	update_user_id = 'CJAMS-61768'
where service_log_id in (1988049,
	1988050,
	1988051,
	1988052,
	1992224,
	2003479,
	2006360)
and delete_sw = 'N'
and end_dt is null;