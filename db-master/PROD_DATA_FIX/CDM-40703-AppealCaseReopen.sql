/*
Issue Description: User needs to reopen the appeal for this CPS-IR case-231020873082
Category/Module: Error
Root cause: Appeal case is not finalized yet, so it needs to be reopened
Fix provided: DB query to reopen the appeals case
Data/Code fix ticket#: CDM-40703
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Reverting appeal status in routing
update routing
set activeflag = 1, updatedby = 'CDM-40703', updatedon = now()
where routingid = '445b7c2c-4506-421b-989b-dbe644e492c8' and activeflag = 0;