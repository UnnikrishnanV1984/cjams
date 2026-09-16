/*
   Issue Description: CDM-29578: update supervisor
   Category/ Module  : User Profile
   Pull request# for code fix: 
   Reason why no related code fix: User wants to remove case from dashboard
   Status of the code fix if already submitted and expected prod fix date: 

*/
UPDATE cjams.userprofile
SET supervisorid='a27e7788-7fa1-4745-82fd-b9d4ca5f672c', updatedby='CDM-29578', updatedon=now()
WHERE securityusersid='d8597a86-a804-4bc0-bf65-66f7be621da2' and email='fred.cohen1@maryland.gov';