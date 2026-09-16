/*
Issue Description:211030009732:I am trying to close this case and it is not allowing me to end date the service log for this daycare bill. I think because the end date is past the adoption date. Can you assist with this so I can close the case?
Root cause: As per system design, the service log can not be ended prior to the latest approved purchase authorization end date.
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#:CJAMS-61253
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE tb_service_log
SET end_dt = '2025-06-25'::date ,estimated_end_dt = '2025-06-25',
    update_ts = now(),
    update_user_id = 'CJAMS-61253',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('2562234')
    and delete_sw = 'N';