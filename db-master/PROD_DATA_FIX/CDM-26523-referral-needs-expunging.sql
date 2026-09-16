
/*
   Issue Description: CDM-26523
   Category/ Module  : Referral needs to be expunged 
   Root cause: user wants to delete this intake I202000381185
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    intakedastaging
set
    activeflag = 0,
    updatedby = 'CDM-26523',
    updatedon = now()
where
    intakenumber = 'I202000381185'
    and activeflag = 1;



update
    intakedastatus
set
    activeflag = 0,
    updatedby = 'CDM-26523',
    updatedon = now()
where
    intakenumber = 'I202000381185'
    and activeflag = 1;