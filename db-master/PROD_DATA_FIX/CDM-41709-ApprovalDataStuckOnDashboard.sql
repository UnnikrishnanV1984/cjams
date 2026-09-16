/*
Issue Description: Please remove the highlighted approval request from the supervisor dashboard.
Category/Module: Bug
Root cause: Request was stuck in dashboard despite approval
Fix provided: DB query to deactivate stuck approval request
Data/Code fix ticket#: CDM-41709
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating record in routing
update routing 
set activeflag = 0, updatedby = 'CDM-41709', updatedon = now()
where routingid = 'd347bdff-e5eb-4735-ade4-9a7fd484d489' and activeflag = 1;