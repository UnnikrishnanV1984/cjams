/*
   Issue Description: CDM-33912
   Category/ Module  : Assignment
   Root cause: Closed case was displaying as Open , as the case assignment was not enddated
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update caseassignment 
set enddate ='2023-08-17 00:00:00',
updatedby ='CDM-33912',
updatedon =now() 
where caseassignmentid ='e7153b20-f574-4bf9-b0f7-caed1dbbd800';
