/*
  Issue Description:  CDM-41368
   Category/ Module  :  Assignments
   Root cause: User request to Data fix to end-date the Administrative Responsibility with 06/21/2024
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update caseassignment
set enddate='2024-06-21 00:00:00', updatedby='CDM-41368', updatedon=now()
where caseassignmentid='f72073c5-a09f-4af8-a5a3-4e0b96fa0da6' and activeflag=1;