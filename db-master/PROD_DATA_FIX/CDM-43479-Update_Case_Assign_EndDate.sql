/*
   Issue Description: CDM-43479
   Category/ Module  : Assessment
   Root cause: User requested to update assignment end date 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  User error.
   
*/


update caseassignment
set enddate='2024-12-23 00:00:00', updatedby='CDM-43479', updatedon=now()
where caseassignmentid='c066ecec-8375-4bc8-bf09-aea2b54ae1d2' and activeflag=1;