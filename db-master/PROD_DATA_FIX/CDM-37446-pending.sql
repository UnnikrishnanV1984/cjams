/*
   Issue Description: CDM-37446
   Category/ Module  : Dashboard
   Root cause: user wants to remove the intake from dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

update intakedastaging 
set status = 'Complete', updatedby = 'CDM-37446', updatedon = now() 
where status ='pending' and intakenumber ='I241012053897' and activeflag =1;