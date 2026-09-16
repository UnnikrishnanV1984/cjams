/*
   Issue Description: CDM-42637
   Category/ Module  : updated Case Assignment end date
   Root cause: user requeseted to end date Family Responsibility by 05/30/2022
   Pull request# for code fix: NA
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
/*
select * from  caseassignment
where caseassignmentid='cb039b7e-1a4d-4744-b3f6-dca2a3a59f1e' and activeflag=1;
*/

update caseassignment
set enddate='2022-05-30 00:00:00', updatedby='CDM-42637', updatedon=now()
where caseassignmentid='cb039b7e-1a4d-4744-b3f6-dca2a3a59f1e' and activeflag=1;