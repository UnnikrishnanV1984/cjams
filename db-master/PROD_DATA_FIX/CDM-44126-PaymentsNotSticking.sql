
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

update routing 
set tosecurityusersid = '403b02a6-f942-481c-b471-c5c8517fb150', updatedby = 'CDM-44126', updatedon = now(), routingstatustypeid = 41,remarks = 'Forwarded to Payment Approval'
where routingid = 'c2fd0e49-d760-4138-b56d-92adaf7149ec' and activeflag = 1;

update routing 
set tosecurityusersid = '403b02a6-f942-481c-b471-c5c8517fb150', updatedby = 'CDM-44126', updatedon = now(), routingstatustypeid = 40
where routingid = '33b6c5ac-69d4-4693-bff5-e3a435392080' and activeflag = 1;

update tb_service_purchase_authorization 
set funding_approval_status_cd = null, funding_approval_dt = null, update_ts = now(), update_user_id = 'CDM-44126'
where authorization_id = 3713333 and delete_sw = 'N' ;
