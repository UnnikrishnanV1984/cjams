/* 
    Issue Description: CDM-38482
   Category/ Module  : Service Log End date  Error
   Root cause: Service Log end date to datafix: 12/03/2018
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

update tb_service_log
set end_dt = '12/03/2018',
    update_ts = now(), 
	update_user_id = 'CDM-38482',
    end_service_reason_cd= '1824'  
	where service_log_id ='892112';