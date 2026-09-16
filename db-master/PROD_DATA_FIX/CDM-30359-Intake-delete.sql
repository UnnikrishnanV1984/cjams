/*
   Issue Description: CDM-30359
   Category/ Module  : inatke delete
   Root cause: user wants to delete intake as it was created in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30359'
where intakenumber = 'I221010298115';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30359'
where intakenumber = 'I221010298115';