/*
  Issue Description: CDM-41238
   Category/ Module  :  Assignment
   Root cause: User requested to end date 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

update caseassignment
set enddate = '2014-03-22 00:00:00', updatedby = 'CDM-41238', updatedon = now()
where caseassignmentid = '2888ff42-8fe3-49bb-a593-c484b4fe03a0' and activeflag = 1;