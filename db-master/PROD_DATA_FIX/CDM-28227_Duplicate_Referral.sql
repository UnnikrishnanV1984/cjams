/*
   Issue Description: CDM-28227
   Category/ Module  :Duplicate Referral
   Root cause:This is a duplicate referral. I need this to be deleted.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update IntakeDAStaging set activeflag = 0, updatedby = 'CDM-28227', updatedon = now() where intakenumber = 'I221010341262' and activeflag=1;
update intakedastatus set activeflag = 0, updatedby = 'CDM-28227', updatedon = now() where intakenumber = 'I221010341262' and activeflag=1;