/*
  Issue Description:  CDM-41447
   Category/ Module  :  Assignments
   Root cause: User request to Data fix to end date the Assignments
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update caseassignment set enddate = '2024-08-16 13:38:00', updatedby = 'CDM-41447', updatedon = now()
where caseassignmentid = '7be6dc6c-a154-43de-b261-328d0b7e7e10' and activeflag = 1; 
