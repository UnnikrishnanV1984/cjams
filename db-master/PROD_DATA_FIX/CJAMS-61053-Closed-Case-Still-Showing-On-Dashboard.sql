/*
   Ticket: CJAMS-61053
   Issue Description: Closed case still showing on the dashboard  
   Category/ Module: Case Assignment 
   Root cause: the self case assignment record was created due to a non reproducible glitch in the application
   Pull request# for code fix: NA
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Intake is still in progress status and has not been submitted for supervisor approval. Need to do data fix
*/

UPDATE caseassignment
SET activeflag = 0, updatedby= 'CJAMS-61053', updatedon = now()
WHERE caseassignmentid = '0266782d-053d-4c7e-8fb8-abea72c021a2';