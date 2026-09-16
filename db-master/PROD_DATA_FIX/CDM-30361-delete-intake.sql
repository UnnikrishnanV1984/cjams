/*
   Issue Description: CDM-30361
   Category/ Module  : Intake
   Root cause: User requested to delete the intake 
   Pull request# for code fix:8650
   Reason why no related code fix: 
    requested a data fix to resolve
*/


update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30361'
where objectid = 'I231010564818';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30361'
where intakenumber = 'I231010564818';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30361'
where intakenumber = 'I231010564818';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30361'
where intakenumber = 'I231010564818';