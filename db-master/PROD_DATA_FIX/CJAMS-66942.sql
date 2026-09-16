/* 
    Issue Description: CJAMS-66942
   Category/ Module  : Case close issue
   Root cause: Service Log end date to datafix:6/26/2023.
   Fix provided: data fix is done to end date the servicelog as requested
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 
*/



update tb_service_log
set end_dt ='2023-06-26',
    update_user_id ='CJAMS-66942', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2350475') and delete_sw='N' ;