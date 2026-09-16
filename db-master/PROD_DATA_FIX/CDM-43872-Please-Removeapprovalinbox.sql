/*
Issue Description: Please remove the below 'Closed' cases from the Approval Inbox.
Category/Module: Error
Root cause:  user is unable to approve or delete some of these assessments as the case is closed
Fix provided: DB query to redirect the request back to the correct supervisor
Data/Code fix ticket#: CDM-43872
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


--routing update

update routing
set activeflag = 0 ,updatedon = now(), updatedby = 'CDM-43872'
where activeflag =1 and objectid in  ('1b61e04b-cb4e-4e72-943c-3b9aa47efdf1','d9cb3894-09e5-407b-ad85-1be65d6bdc20','4fd874e8-7d2b-4090-92bc-93532fb4904b');
