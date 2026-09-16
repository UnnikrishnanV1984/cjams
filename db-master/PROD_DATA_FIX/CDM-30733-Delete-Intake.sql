/*
   Issue Description: CDM-30733
   Category/ Module  : Intake
   Root cause: User requested to delete intake
   Pull request# for code fix: 8801
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30733'
where objectid = 'I231010584553';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30733'
where intakenumber = 'I231010584553';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30733'
where intakenumber = 'I231010584553';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30733'
where intakenumber = 'I231010584553';