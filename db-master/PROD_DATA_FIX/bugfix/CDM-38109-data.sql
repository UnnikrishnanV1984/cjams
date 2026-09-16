/* 
    Issue Description: CDM-38109
   Category/ Module  : Case Close/Service Log Error
   Root cause: Service Log end date to datafix: 3/31/2024
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

update tb_service_log
set end_dt = '03/31/2024',
    update_ts = now(), 
	update_user_id = 'CDM-38109'  
	where service_log_id ='1990738';