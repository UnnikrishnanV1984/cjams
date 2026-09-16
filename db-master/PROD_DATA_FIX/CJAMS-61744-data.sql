/*
Issue Description:3171076:Unable to put an end date so the case can close.
Root cause: User requested to end date the latest purchase authorization to 06/14/2024 for 
Provider ID: 6023696 (Student Shuttle Transportation, Inc.)
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#: CJAMS-61744
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE tb_service_log
SET end_dt = '2024-06-14'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-61744',
    end_service_reason_cd = '1824',estimated_end_dt = '2024-06-14'
WHERE service_log_id in ('3072719')
    and delete_sw = 'N';