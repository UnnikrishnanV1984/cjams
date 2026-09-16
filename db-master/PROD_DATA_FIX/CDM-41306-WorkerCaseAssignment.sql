/*
Issue Description: Please end-date the worker assignment highlighted below as both Administrative responsibility are not ended when the case is closed.
Category/Module: Error
Root cause: Case was closed before assignments were given end date
Fix provided: DB query to update end date for both assignments
Data/Code fix ticket#: CDM-41306
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating end date in caseassignment
update caseassignment
set enddate = '2024-08-26 16:22:56.397', updatedby = 'CDM-41306', updatedon = now()
where caseassignmentid in ('84141295-e9f2-416b-8f4e-0c3258ad8902', '2a9ad393-9f99-40c8-82f3-b7ec8e90c448') and activeflag = 1;