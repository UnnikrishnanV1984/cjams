/*
   Issue Description: CDM-30141
   Category/ Module  : delete case
   Root cause: user wants to delete the case  it was created in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

UPDATE intakedastaging
SET activeflag = 0, updatedby = 'CDM-30141', updatedon = now()
WHERE intakenumber = 'I221010302189';


UPDATE intakedastatus
SET activeflag = 0, updatedby = 'CDM-30141', updatedon = now()
WHERE intakenumber = 'I221010302189';
