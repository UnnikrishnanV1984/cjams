/*
  Issue Description:  CDM-42123
   Category/ Module  : Assignments
   Root cause: User request to end date the assignments
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update caseassignment
set enddate = '2024-09-23 00:00:00',
updatedon = now(),
updatedby = 'CDM-42123'
where caseassignmentid = '8b4f96da-4870-4a77-b402-b939407cfe87';