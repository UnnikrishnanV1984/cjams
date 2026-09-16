/*
Issue Description: Please remove the case connect (241022705019) review request from the supervisor dashboard.
Category/Module: Bug
Root cause: Request was stuck in dashboard despite approval
Fix provided: DB query to deactivate stuck approval request
Data/Code fix ticket#:CDM-41844
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating record in routing
update routing
set activeflag = 0, updatedby = 'CDM-41844', updatedon = now()
where routingid = '265122bf-4926-4a1c-9f86-9a57e2bad738' and activeflag = 1;