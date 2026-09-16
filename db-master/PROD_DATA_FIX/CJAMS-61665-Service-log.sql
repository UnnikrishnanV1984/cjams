
/*
Issue Description:3296501:I am unable to end date this service log in order to close the case. 
Root cause: As per system design, the service log can not be ended prior to the latest approved purchase authorization end date.
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#:CJAMS-61289
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--2024-09-26
UPDATE tb_service_log
SET end_dt = '2025-08-05'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-61665',
    end_service_reason_cd = '1824',estimated_end_dt = '2025-08-05'
WHERE service_log_id in ('2698744')
    and delete_sw = 'N';