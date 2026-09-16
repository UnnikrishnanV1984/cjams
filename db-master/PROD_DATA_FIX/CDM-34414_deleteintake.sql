/*
   Issue Description: CDM-34414
   Category/ Module  : inatke delete
   Root cause: user wants to delete intake as it was created in error
   Pull request# for code fix: 5389
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34414'
where objectid = 'I221010241291' and activeflag = 1;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34414'
where intakenumber = 'I221010241291' and activeflag = 1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34414'
where intakenumber = 'I221010241291' and activeflag = 1;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34414'
where intakenumber = 'I221010241291' and activeflag = 1;