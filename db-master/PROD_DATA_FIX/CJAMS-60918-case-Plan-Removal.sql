/*
Issue Description:The case plan review requests are still available in Caseworker's and Supervisor's dashboard for 2 cases. Both are in approved status but did not got removed from the pending approval dashboard after approval.
Root cause: User request to delete the pending approval dashboard.
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-60918
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update routing 
set activeflag = 0 ,updatedby='CJAMS-60918', updatedon=now()
where routingid in ('c33e1b37-080f-4f50-8350-f9c21faf5c9a','234a9636-9de7-4fb0-96a6-4a502fc9d89d') and activeflag =1;