/*
   Issue Description: CDM-16556
   Category/ Module  :  child welfare 
   Root cause: user wants to remove dummy intakes
   Pull request# for code fix: 
   Reason why no related code fix: 
   user requested removal of dummy intakes
*/

update intakedastaging set activeflag = 0, updatedby = 'CDM-16556', updatedon = now() 
where intakenumber in ('I202100144983', 'I202100144982', 'I202100144980') and activeflag =1; 

update intakedastatus set activeflag =0, updatedby = 'CDM-16556', updatedon = now() 
where intakenumber in('I202100144983', 'I202100144982', 'I202100144980') and activeflag =1;