/*
   Issue Description: CDM-19357
   Category/ Module  : Delete Referrals  
   Root cause: user wants to remove unused drafts
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from intakedastatus where intakenumber in ('I211010218786','I211010218675');

update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-19357', updatedon = now() 
where intakenumber in ('I211010218786','I211010218675')
and insertedby = '114a224a-7890-46bd-866c-0a5a6f021a86' and activeflag = 1; 

update cjams.intakedastatus 
set activeflag =0, updatedby = 'CDM-19357', updatedon = now() 
where intakenumber in ('I211010218786','I211010218675')
and insertedby = '114a224a-7890-46bd-866c-0a5a6f021a86' and activeflag = 1;