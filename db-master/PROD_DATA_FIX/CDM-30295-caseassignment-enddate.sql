/*
   Issue Description: CDM-30295
   Category/ Module  : Assignment
   Root cause: user wants to update the assignment enddate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

update caseassignment set enddate= '2023-03-16 00:00:00',updatedby ='CDM-30295',updatedon = now() where caseassignmentid = '1e7186a2-448f-40de-9d75-26d8ab65dfb8';