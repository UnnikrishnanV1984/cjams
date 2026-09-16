/*
  Issue Description:  CDM-43911
   Category/ Module  :  Assignments
   Root cause: User request to Data fix to end date the Assignments
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update caseassignment set enddate = '2025-01-08 00:00:00', updatedby = 'CDM-43911', updatedon = now()
where caseassignmentid = 'c4567b2e-ada0-48e5-ba6c-1691c3915136' and activeflag = 1; 
