
/*
   Issue Description: CDM-26522
   Category/ Module  : Referral needs to be expunged 
   Root cause: user wants to delete this intake I221010244191
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    intakedastaging
set
    activeflag = 0,
    updatedby = 'CDM-26522',
    updatedon = now()
where
    intakenumber = 'I221010244191'
    and activeflag = 1;



update
    intakedastatus
set
    activeflag = 0,
    updatedby = 'CDM-26522',
    updatedon = now()
where
    intakenumber = 'I221010244191'
    and activeflag = 1;