/* 
    Issue Description: CJAMS-65851
   Category/ Module  : Services:service log
   Root cause:user error, As per system design, the service log can not be ended prior to the 
   latest purchase authorization end date and beyond the selected client program date period.
   Fix provided: Data fix is done to end the respective open service log with 11/21/2024
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update tb_service_log
    set end_dt = '2024-11-21'::date, update_ts = now(), end_service_reason_cd = '1824',update_user_id = 'CJAMS-65851' 
    where service_log_id = 2074863;