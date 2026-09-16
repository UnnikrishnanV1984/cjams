/*
   Issue Description: CDM-26647
   Category/ Module  : case 
   Root cause: it was deleted by glitch.
   Pull request# for code fix: 
   Reason why no related code fix: 
*/


update cjams.intakeservicerequest set activeflag =1, updatedby ='CDM-26647', updatedon =now()

where intakeserviceid  ='7d4a4856-0ce2-48cf-b9ce-d84f982b556b';