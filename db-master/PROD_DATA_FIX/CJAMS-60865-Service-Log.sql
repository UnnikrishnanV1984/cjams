/*
Issue Description:3011182:This service log from 2009 needs to be deleted. It was paid under a sibling. I cannot close the provider case because of this service log. If it can't be deleted, can the authorization link be deleted so the provider case can close.
Root cause: User requet delete  the PA Record for the following, so that the user can able to close the provider.
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#:CJAMS-60865
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update tb_service_purchase_authorization 
set delete_sw  = 'Y' , update_ts = now(),update_user_id = 'CJAMS-60865'
where service_log_id = '177318' and delete_sw = 'N' and authorization_id = '80203';
