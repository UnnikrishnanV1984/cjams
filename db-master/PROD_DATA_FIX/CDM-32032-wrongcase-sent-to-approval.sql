/*
   Issue Description: CDM-320032
   Category/ Module  : Permanancy Plan
   Root cause: case was sent to wrong person for approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 


update routing
 set fromsecurityusersid = '628da123-2ce7-4c64-b7b4-d9949fd8c23a',
tosecurityusersid ='4b8d30e9-1b01-47cb-9cdf-9308451bf98a',
insertedby ='628da123-2ce7-4c64-b7b4-d9949fd8c23a',
teamid ='13021883-e81b-49f1-8556-4e048236e271',
updatedby ='CDM-32032',
updatedon=now() 
where routingid = '2dab4d78-6555-4abb-9425-432c6c134c33';