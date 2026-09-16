/*
   Issue Description: CDM-21921
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
    updatedby = 'CDM-21921'
where objectid = 'I221010241819';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-21921'
where intakenumber = 'I221010241819';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-21921'
where intakenumber = 'I221010241819';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-21921'
where intakenumber = 'I221010241819';