/*
   Issue Description: CDM-19815
   Category/ Module  : updated Case Assignment end date
   Root cause: user requeseted to end date assignment
   Pull request# for code fix: 4671
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update caseassignment
set enddate = '2022-01-03 00:00:00', updatedon = now(), updatedby = 'CDM-19815'
where caseassignmentid = '0652f09f-a346-4094-b3fb-0db507071d0e';