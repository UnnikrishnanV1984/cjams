/*
Issue Description: 3166115:preventing provider closure (outstanding purchase authorization) 
Category/Module: User Request
Root cause: User Request, Case is closed so need data fix to remove the draft purchase authorization 
Fix provided: DB query to remove the draft PA.
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Request
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update tb_service_purchase_authorization
set delete_sw = 'Y', update_ts = now(), update_user_id = 'CJAMS-62927'
where authorization_id = '212779';
-- no records in payment header and details