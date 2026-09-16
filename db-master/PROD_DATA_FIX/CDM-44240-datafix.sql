/*
  Issue Description:  CDM-44240
   Category/ Module  :  Assignments
   Root cause: User request to Data fix to end date the Assignments
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/


update caseassignment set enddate = '2025-02-06 00:00:00', updatedby = 'CDM-44240', updatedon = now()
where caseassignmentid = '2867edc9-52c6-4390-8598-711a409bccf3' and activeflag = 1; 