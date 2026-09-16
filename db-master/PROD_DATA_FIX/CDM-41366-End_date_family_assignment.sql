/*
   Issue Description: CDM-41366
   Category/ Module  : updated End date administration assignment
   Root cause: user requeseted to end date assignment
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update caseassignment
set enddate='2024-07-05 00:00:00', updatedby='CDM-41366', updatedon=now()
where caseassignmentid='c24bc872-709f-4fca-b256-2600099b2173' and activeflag=1;
