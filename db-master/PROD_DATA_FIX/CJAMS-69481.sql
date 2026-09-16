/*
Issue Description: CJAMS-69481-Case closure
Category/ Module  : Services:service log
Root cause : There is an open agency provided services available and the selected client program 
             has been ended so data fix is needed to ended the agency provided services with the estimated end date.
Fix provided: Data fix is done to end the respective open service log , so user can proceed with case closure
Pull request# for code fix: 
Is code fix required: N 
Reason why no related code fix: N/A , as its expected behaviour  with open servicelogs case ca not be closed
Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE tb_service_log
SET end_dt = '2024-10-31'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-69481',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('3544832','3544833','3544834')
    and delete_sw = 'N';