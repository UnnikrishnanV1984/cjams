/*
   Issue Description: CJAMS-63398
   Category/ Module  : Intake
   Root cause: User requested to update the Estimated End date and the Actual End date for the Service In case 221030015632
   Fix provided: Data fix has been done to update the Estimated End date and the Actual End date for the Service In case 221030015632
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/

update tb_service_log
set end_dt ='2024-01-31',
    update_user_id ='CJAMS-63398', 
    update_ts =now(),
    estimated_end_dt='2024-01-31',
    end_service_reason_cd = '1824'
where service_log_id in ('2658862') and delete_sw='N' ;
