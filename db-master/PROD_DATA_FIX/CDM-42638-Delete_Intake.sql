/*
 Issue Description: CDM-42638
-- Category/ Module: Delete Intake
-- Root cause: User wants to remove the intake.
-- Fix Provided: Datafix has been promoted to update the active flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/


-- I202000488841
update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber  = 'I202000488841';

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where objectid = 'I202000488841';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000488841';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000488841';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000488841';

-- I202000269105
update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber  = 'I202000269105';

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where objectid = 'I202000269105';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000269105';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000269105';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000269105';

-- I202000267247
update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber  = 'I202000267247';

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where objectid = 'I202000267247';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000267247';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000267247';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000267247';

-- I202000166212
update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber  = 'I202000166212';

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where objectid = 'I202000166212';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000166212';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000166212';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42638'
where intakenumber = 'I202000166212';

