/*
Issue Description: CJAMS-68967-Case closure
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
SET end_dt = '2023-05-04'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-68967',
    end_service_reason_cd = '1824'
WHERE service_log_id = '2319623'
    and delete_sw = 'N';
