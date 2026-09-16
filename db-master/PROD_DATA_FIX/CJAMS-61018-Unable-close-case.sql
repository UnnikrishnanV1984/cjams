
/*
Issue Description:211030011918:We are unale to close this case due to "all service logs have been completed with an "actual" start/end date" requirement. I was able to add the actual end date for the service logs we submitted for the family while they have been in "Family Preservation" services but a glitch is preventing me from adding an end date for one of the service logs submitted by OOH and it is confliciting with the OOH program end date as well
Root cause: As per system design, the service log can not be ended prior to the latest approved purchase authorization end date.
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#:CJAMS-61018
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE tb_service_log
SET end_dt = '2025-07-28'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-61018',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('3528111')
    and delete_sw = 'N';