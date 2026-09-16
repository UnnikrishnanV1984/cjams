/*
   Issue Description: CDM-21039
   Category/ Module  : Delete Referrals  
   Root cause: user wants to remove this duplicate intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
 -- This is a draft QA

update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-21039', updatedon = now() 
where intakenumber in ('I221010247039') and activeflag=1;


update cjams.intakedastatus  
set activeflag = 0, updatedby = 'CDM-21039', updatedon = now() 
where intakenumber in ('I221010247039') and activeflag=1;