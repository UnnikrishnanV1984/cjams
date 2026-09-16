/*
Issue Description: Please remove the Permanency Plan Review request from the supervisor dashboard.
Category/Module: Bug
Root cause: The case was closed but the review request remained in the approval inbox.
Fix provided: DB query dectivate Permanency Plan Review request
Code/Data fix ticket#: CDM-40843
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue, code is fine. 
Backup before update/ delete:Query:
*/

--Deactivating PP review request in routing
update routing 
set activeflag = 0, updatedby = 'CDM-40843', updatedon = now()
where routingid = 'a683e3d4-0fc9-4024-8edc-95f391a70423' and activeflag = 1;