/* 
    Issue Description: CJAMS-66101
   Category/ Module  : Services:service log
   Root cause: This is not a defect. As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.
   FIx provided: Data fix is done to update the service log end date as 11/30/2014. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update tb_service_log
set end_dt ='2014-11-30',
    update_user_id ='CJAMS-66101', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('610027') and delete_sw='N' ;