/* 
    Issue Description: CJAMS-66466
   Category/ Module  : Services:service log
   Root cause: This is not a defect.We have implemented the new Service Log feature to stop the submission of duplicate service log requests that lead to duplicate payments.
   FIx provided: Data fix is done to update the service log end date as 2023-11-02. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update tb_service_log
set end_dt ='2023-11-02',
    update_user_id ='CJAMS-66466', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2775840') and delete_sw='N' ;