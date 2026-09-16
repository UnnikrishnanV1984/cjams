/*
   Issue Description: CDM-40402
   Category/ Module  : updated Case Assignment end date
   Root cause: user requeseted to end date assignment
   Pull request# for code fix: 4671
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update caseassignment
set enddate='2024-07-09 00:00:00', updatedby='CDM-40402', updatedon=now()
where caseassignmentid='fddd6bcf-4add-499d-b161-330d0a16f4de' and activeflag=1;