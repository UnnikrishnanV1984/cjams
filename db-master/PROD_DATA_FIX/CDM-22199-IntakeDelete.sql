/*
   Issue Description: CDM-22199
   Category/ Module  : delete intake
   Root cause: user wants to delete intake which created bymistake
   Pull request# for code fix: 5409
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22199'
where objectid = 'I221010267345';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22199'
where intakenumber = 'I221010267345';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22199'
where intakenumber = 'I221010267345';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22199'
where intakenumber = 'I221010267345';
