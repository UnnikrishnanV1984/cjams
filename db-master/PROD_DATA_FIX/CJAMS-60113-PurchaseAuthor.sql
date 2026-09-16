/*
Issue Description: 3264608:I am attempting to end a purchase authorization for the date of the last service log end date, 6/20/25. This date extends beyond the date of the case being open. The case closed on 4/19/25. CJAMS will not allow me to end the purchase auth with a date beyond case opening; however the preapproved service log is dated for June. 
Category/Module: Support
Root cause: As per system design, the service log can not be ended prior to the latest approved purchase authorization end date.
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#:CJAMS-60113 
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE tb_service_log
SET end_dt = '2025-06-20'::date ,estimated_end_dt = '2025-06-20',
    update_ts = now(),
    update_user_id = 'CJAMS-60113',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('3316568')
    and delete_sw = 'N';