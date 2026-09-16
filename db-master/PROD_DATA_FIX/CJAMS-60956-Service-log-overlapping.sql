/* 
    Issue Description: CJAMS-60956
   Category/ Module  : Service Log End date  Error
   Root cause: Service Log end date to datafix: 2019-07-17
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

update tb_service_log
set end_dt = '2019-07-17' ,
	update_ts = now(),
	end_service_reason_cd = '1824',
	update_user_id = 'CJAMS-60956'
where service_log_id = 942652
	and delete_sw = 'N';