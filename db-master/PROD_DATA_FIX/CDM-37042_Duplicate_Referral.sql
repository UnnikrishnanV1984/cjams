/*
   Issue Description: CDM-37042
   Category / Module: Duplicate Referral
   Root cause: There was a CJAMS error during entry and a new referral was entered.
   			   This is a duplicate referral. need this to be deleted.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
*/


update IntakeDAStaging 
set activeflag = 0, updatedby = 'CDM-37042', updatedon = now() 
where intakenumber = 'I231011356940' and activeflag = 1;

update intakedastatus 
set activeflag = 0, updatedby = 'CDM-37042', updatedon = now() 
where intakenumber = 'I231011356940' and activeflag = 1;
