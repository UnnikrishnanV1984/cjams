/*
   Issue Description: CDM-40968
   Category/ Module  :  Referral 
   Root cause: user wants to delete intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastaging
set activeflag=0, updatedby='CDM-40968', updatedon='now()'
where intakenumber='I241012199463' and activeflag=1;

update intakedastatus
set activeflag=0,updatedby='CDM-40968', updatedon='now()'
where intakenumber='I241012199463' and activeflag=1;