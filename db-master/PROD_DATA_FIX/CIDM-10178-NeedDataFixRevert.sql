/*
Issue Description: Need data fix to revert (add back) the denied purchase authorization (3684436).
Category/Module: Support
Root cause: revert as part of code fix.
Fix provided: DB query to soft-delete the denied purchase authorization
Data/Code fix ticket#: CIDM-10178
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:   CDM-43997
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating tb_service_purchase_authorization
update tb_service_purchase_authorization
set delete_sw = 'N', update_user_id = 'CIDM-10178', update_ts = now()
where authorization_id = 3684436 and delete_sw = 'Y';