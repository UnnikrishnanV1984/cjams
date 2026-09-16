/*
Issue Description: Please do the data fix to ended the open worker assignment with 2025-05-06.
Category/Module: Support
Root cause: User can not able to end date after closing the case.
Fix provided: DB query to updates records in caseassignment table.
Data/Code fix ticket#:
Regression Impacts: N/A
Code fix ticket#:   N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--select enddate,startdate,updatedby,* from caseassignment where caseassignmentid = 'eff9ea60-098c-4afb-9290-f7e30317538c' and activeflag = 1;
update caseassignment
set enddate='2025-05-06',updatedby='CJAMS-60550', updatedon=now()
where caseassignmentid='eff9ea60-098c-4afb-9290-f7e30317538c' and activeflag=1;
