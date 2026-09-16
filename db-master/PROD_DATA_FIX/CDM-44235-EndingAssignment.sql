/*
Issue Description: Please do the data fix to ended the open worker assignment with 02/10/2025.
Category/Module: Support
Root cause: User can not able tomadd end date after closing the case.
Fix provided: DB query to updates records in caseassignment table.
Data/Code fix ticket#:CDM-44235
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:   N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--update caseassignment
update caseassignment
set enddate = '2025-02-10 00:00:00', updatedby = 'CDM-44235', updatedon = now()
where caseassignmentid = 'a7db11e5-6907-40fc-a75d-d96d9b7c0626' and activeflag = 1;