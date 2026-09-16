/*
Issue Description: Please do a data fix to end-date the service log.
Category/ Module: Bug
Root cause: One service log had no end date and was causing issues creating new logs.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-40421
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update tb_service_log
set end_dt = '2023-08-18', end_service_reason_cd = '1824', update_user_id = 'CDM-40421', update_ts = now()
where service_log_id = 1993388;