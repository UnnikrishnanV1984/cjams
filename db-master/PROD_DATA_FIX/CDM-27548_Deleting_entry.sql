/*
   Issue Description: CDM-27548
   Category/ Module  : Deleting entry of user
   Root cause:N/A case needs to be deleted
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/




update intakedastaging set activeflag = 0, updatedon = now(), updatedby = 'CDM-27548' where id = '5662875';

update intakedastatus set activeflag = 0, updatedon = now(), updatedby = 'CDM-27548' where intakenumber = 'I221010351226';