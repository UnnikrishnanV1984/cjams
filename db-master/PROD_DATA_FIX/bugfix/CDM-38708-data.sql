/* 
    Issue Description: CDM-38708
   Category/ Module  : Closed Case
   Root cause: Case has been completed/closed on 04/17/2024 and the caseworker assignment is not ended with the case closure approval date.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update caseassignment
set enddate = '2024-04-17 09:00:00', updatedon = now(), updatedby = 'CDM-38708'
where caseassignmentid = '87519210-4d32-4a3b-ac2e-241d7c430b7e'; 