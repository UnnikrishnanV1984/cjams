/*
Issue: Two items in Pending approving will not leave after being approved. 
Category/Module: Bug
Root cause: Data error seems to keep approved approval requests in pending dashboard
Fix provided: DB query to remove approved requests from pending dashboard
Data/Code fix ticket#: CDM-42562
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating routing
update routing 
set activeflag = 0, updatedby = 'CDM-42562', updatedon = now()
where routingid in ('7b9964ca-48f4-4fa9-a954-08ee80399a9e', '456674e8-75a5-42af-92ea-ad8502d0618e') and activeflag = 1;