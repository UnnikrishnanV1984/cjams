/*
   Issue Description: CDM-20356
   Category/ Module  : Delete Referrals  
   Root cause: user wants to remove this duplicate intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-20356', updatedon = now() 
where intakenumber in ('I221010237763', 'I202100144906') and activeflag=1;

update cjams.intakedastatus 
set activeflag =0, updatedby = 'CDM-20356', updatedon = now() 
where intakenumber in ('I221010237763', 'I202100144906') and activeflag=1;