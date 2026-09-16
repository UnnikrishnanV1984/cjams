/*
Issue Description: Need technical investigation on both purchase authorization as user mentioned those purchase auth can not be located under the finance Funding approval dashboard.
Category/Module: Support
Root cause: Due to data glitch request not sent Supervisor.
Fix provided: DB query to updates records in rounting and  tb_service_purchase_authorization tables.
Data/Code fix ticket#: CDM-44126
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:   N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update tb_service_purchase_authorization 
set funding_approval_status_cd = null, funding_approval_dt = null, update_ts = now(), update_user_id = 'CDM-44126'
where authorization_id = 3713333 and delete_sw = 'N' ;

