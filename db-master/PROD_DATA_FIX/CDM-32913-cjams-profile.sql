/*
   Issue Description: CDM-32913
   Category/ Module  : Assignments
   Unit Name being incorrectly identified for Assignments
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Unit name should be changed, Need to do data fix.
*/
update caseassignment 
set toteamid ='d5abb69f-8086-4645-bb56-5ef8825d412d',
updatedby ='CDM-32913',
updatedon =now() 
where caseassignmentid  ='9b3cd344-0223-4d43-b9cf-89b5bdfee8af';