
/*
   Issue Description: CDM-43739
   Category/ Module  :  Case Assignment
   Root cause: user requeseted to update end date
   Pull request# for code fix: 
   Reason why no related code fix: User Error
   Status of the code fix if already submitted and expected prod fix date: 
*/


update caseassignment set enddate = '2025-01-13 00:00:00', updatedby = 'CDM-43739',updatedon = now()
where caseassignmentid = '4f5c278e-8faf-4d9e-b0a9-b8fa846a34ad' and enddate is null;

update caseassignment set enddate = '2025-01-13 00:00:00', updatedby = 'CDM-43739',updatedon = now()
where caseassignmentid = 'cf25b687-b5ff-4f07-a21c-3baf7ca8465f' and enddate is null;