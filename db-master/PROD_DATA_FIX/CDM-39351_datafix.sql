/*
   Issue Description: CDM-39351
   Category/ Module  :Assignments
   Root cause:  family assignment with 6/3 was throwing error stating that the start date should not be greater than the end date. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update caseassignment 
set startdate ='2024-06-03 04:00:00.000', 
updatedby = 'CDM-39351', updatedon = now() 
where caseassignmentid ='e0e39e2b-9ea3-4f6f-a16b-934ec993019b' and activeflag =1;

update caseassignment
 set startdate ='2024-06-03 04:00:00.000',enddate ='2024-06-03 04:00:00.000',
  updatedby = 'CDM-39351', updatedon = now() 
  where caseassignmentid ='28ffac18-7c83-4c35-b529-f30d12669ae6' and activeflag =1;
