/*
Issue Description: Provider Rosemary Thomas (6198559) home was closed in error. Please update the provider status to active (1791) and update user and timestamp.
Category/Module: Status change
Root cause: Provider home was closed in error
Fix provided: DB queries to update provider status to active from closed in tb_provider table
Data/Code fix ticket#:CJAMS-65789
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
select provider_id,provider_status_cd from tb_provider where provider_id=6198559; 

*/

update tb_provider 
set provider_status_cd = '1791', 
	update_user_id='CJAMS-65798', 
	update_ts=now() 
where provider_id = 6198559 
and provider_status_cd = '1794';