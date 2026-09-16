
/*
   Issue Description: CDM-26521
   Category/ Module  : Referral needs to be expunged 
   Root cause: user wants to delete this intake I221010278464
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    intakedastaging
set
    activeflag = 0,
    updatedby = 'CDM-26521',
    updatedon = now()
where
    intakenumber = 'I221010278464'
    and activeflag = 1;



update
    intakedastatus
set
    activeflag = 0,
    updatedby = 'CDM-26521',
    updatedon = now()
where
    intakenumber = 'I221010278464'
    and activeflag = 1;