/*
   Issue Description: CDM-26832
   Category/ Module  : inatke delete
   Root cause: user wants to delete intake as it was created in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26832'
where objectid = 'I221010329627';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26832'
where intakenumber = 'I221010329627';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26832'
where intakenumber = 'I221010329627';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26832'
where intakenumber = 'I221010329627';



