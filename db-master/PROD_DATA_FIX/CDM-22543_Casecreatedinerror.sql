/*
   Issue Description: CDM-22543
   Category/ Module  :Case created in error
   Root cause: 3011907:Case #3011907 was created with wrong Head of Household. Case needs to be deleted.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update intakedastatus set activeflag = 0, updatedby = 'CDM-22543', updatedon = now() where intakenumber = 'I221010273972' and activeflag = 1;

update intakedastaging set activeflag = 0, updatedby = 'CDM-22543', updatedon = now() where intakenumber = 'I221010273972' and activeflag = 1;
