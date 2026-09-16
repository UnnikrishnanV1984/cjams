/*
Issue Description: Please remove the highlighted case connect review from the user dashboard.
Category/Module: Error
Root cause: Case seems to have been closed after review was submitted
Fix provided: DB query remove case connect review request
Data/Code fix ticket#: CDM-41143
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Removing the review request from routing
update routing
set activeflag = 0, updatedby = 'CDM-41143', updatedon = now()
where routingid = 'e6b153f8-a85e-4ae0-bb8a-3f65f707c5d9' and activeflag = 1;