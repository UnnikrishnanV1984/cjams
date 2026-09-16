/*
Issue Description: 241030430895:I am attempting to close out a case however it is stating that the actual end date needs to be ended however it won't allow a date to go in there. 
Root cause: As per system design, the service log can not be ended prior to the latest approved purchase authorization end date.
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#:CJAMS-61006
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE tb_service_log
SET end_dt = '2025-08-15'::date ,estimated_end_dt = '2025-08-15',
    update_ts = now(),
    update_user_id = 'CJAMS-61006',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('3555163')
    and delete_sw = 'N';