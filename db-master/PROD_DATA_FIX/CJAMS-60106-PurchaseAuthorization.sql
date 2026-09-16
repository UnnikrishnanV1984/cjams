/*
Issue Description: 3215156:Need to close out a service log form 2012 in order to end a service provider - please advise
Category/Module: Support
Root cause: user request delete draft authorization.
Fix provided: DB query to soft-delete the denied purchase authorization
Data/Code fix ticket#: CJAMS-60106
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:   CDM-43997
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating tb_service_purchase_authorization
update tb_service_purchase_authorization
set delete_sw = 'Y', update_user_id = 'CJAMS-60106', update_ts = now()
where authorization_id = 271196 and delete_sw = 'N';


