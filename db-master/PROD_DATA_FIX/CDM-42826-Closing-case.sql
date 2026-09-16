/*
Issue Description: Please do the Data fix remove purchase authorization.
Category/Module: User Error
Root cause: application does not allow case to be closed with an active purchase authorization.
Fix provided: DB query to insert missing participant into the note
Data/Code fix ticket#: CDM-42826
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--update tb_service_purchase_authorization
update tb_service_purchase_authorization
set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-42826'
where authorization_id in ('3075308');