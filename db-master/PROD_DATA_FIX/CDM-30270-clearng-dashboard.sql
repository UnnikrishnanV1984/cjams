/*
   Issue Description: CDM-30270
   Category/ Module  : Dashboard
   Root cause: user wants to remove the intake from dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

update intakedastaging
 set status = 'Complete', 
 updatedby = 'CDM-30270', 
 updatedon = now() 
 where intakenumber in('I231010555541','I221010285178','I211010199969','I202000112027') and activeflag = 1;