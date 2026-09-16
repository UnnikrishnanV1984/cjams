/*
Issue Description: Please remove the related case from the supervisor approval inbox.
Category/Module: Bug
Root cause: Seems like a data glitch caused multiple approval requests for this
Fix provided: DB query to deactivate the duplicate approval request
Data/Code fix ticket#: CDM-43367
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Glitch
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in routing
update routing 
set activeflag = 0, updatedby = 'CDM-43367', updatedon = now()
where routingid = '68d05af6-8732-49d9-8a90-59dd71d7d2e2' and activeflag = 1;