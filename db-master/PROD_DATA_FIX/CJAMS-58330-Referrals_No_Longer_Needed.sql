/*
   Issue Description: CJAMS-58330
   Category/ Module  : 
   Root cause: User requested to remove intake from pending dashboard
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/ 


update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-40089'
where intakenumber in ('I251013231371','I251013229370');

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-40089'
where objectid  in ('I251013231371','I251013229370');

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-40089'
where intakenumber in ('I251013231371','I251013229370');

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-40089'
where intakenumber  in ('I251013231371','I251013229370');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-40089'
where intakenumber  in ('I251013231371','I251013229370');
