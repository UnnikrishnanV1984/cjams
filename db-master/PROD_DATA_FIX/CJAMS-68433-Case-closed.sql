/*
   Ticket: CJAMS-68433
   Category/ Module: Case Assignment 
   Root cause: the self case assignment record was created due to a non reproducible glitch in the application
   Pull request# for code fix: NA
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Intake is still in progress status and has not been submitted for supervisor approval. Need to do data fix
*/

UPDATE caseassignment
SET  enddate ='2023-06-28 00:23:25', updatedby= 'CJAMS-68433', updatedon = now()
WHERE caseassignmentid = 'e6c40524-cb5a-4b9c-b876-b6aa9a73acb4' and activeflag = 1;