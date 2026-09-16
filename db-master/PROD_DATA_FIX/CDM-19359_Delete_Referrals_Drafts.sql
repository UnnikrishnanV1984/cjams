/*
   Issue Description: CDM-19359
   Category/ Module  : Delete Referrals  
   Root cause: user wants to remove unused drafts
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from intakedastatus where intakenumber in ('I211010218792','I211010221018','I211010221501','I211010221017');

update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-19359', updatedon = now() 
where intakenumber in ('I211010218792','I211010221018','I211010221501','I211010221017')
and insertedby = 'ecbae51c-ea05-4f05-bd78-67461d1b7e64' and activeflag = 1; 

update cjams.intakedastatus 
set activeflag =0, updatedby = 'CDM-19359', updatedon = now() 
where intakenumber in ('I211010218792','I211010221018','I211010221501','I211010221017')
and insertedby = 'ecbae51c-ea05-4f05-bd78-67461d1b7e64' and activeflag = 1;