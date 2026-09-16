/* 
    Issue Description: CJAMS-61065
   Category/ Module  : Service Log End date  Error
   Root cause: Service Log end date to datafix: 2025-06-30
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/
--select end_dt ,end_service_reason_cd ,* from tb_service_log tsl where service_log_id = '3727535';
update tb_service_log
set end_dt = '2025-06-30',
	estimated_end_dt = '2025-06-30',
	update_ts = now(),
	update_user_id = 'CJAMS-60940'
where service_log_id = 3727535
	and delete_sw = 'N';