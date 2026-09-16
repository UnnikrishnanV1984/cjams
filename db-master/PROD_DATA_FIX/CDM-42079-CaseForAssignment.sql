/*
Issue Description: Assigning it to dev to remove the case from assign tab
Category/Module: Bug
Root cause: Supervisor able to view the case in the Assign Case tab even though its assigned to case worker
Fix provided: DB query to remove the case from Assign Case tab
Data/Code fix ticket#: CDM-42079
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating assignment in routing
update routing
set activeflag = 0, updatedby = 'CDM-42079', updatedon = now()
where routingid = 'bb0a59c0-18da-4c1b-8540-1388d6949e09' and activeflag = 1;