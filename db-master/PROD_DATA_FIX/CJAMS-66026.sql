/* 
    Issue Description: CJAMS-66026
   Category/ Module  : Services:service log
   Root cause: This is not a defect. User requested to end the service log date
   FIx provided: Data fix is done to update the service log end date as 04/30/2026. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update tb_service_log
set end_dt ='2026-04-30',
    update_user_id ='CJAMS-66026', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('977659') and delete_sw='N' ;