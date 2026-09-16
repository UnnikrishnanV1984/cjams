/* 
    Issue Description: CJAMS-61004
   Category/ Module  : Service Log End date  Error
   Root cause: User Error, wrong program assignement and Service Log end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

update tb_service_log
set end_dt = '2025-07-24' ,
	estimated_end_dt = '2025-07-24',
	update_ts = now(),
	update_user_id = 'CJAMS-61004'
where service_log_id = 3737557
	and delete_sw = 'N';