/*
 Issue Description: CJAMS-58628
-- Category/ Module: Delete Intake
-- Root cause: User wants to remove the intake.
-- Fix Provided: Datafix has been promoted to update the active flag.
-- Pull request# N/A
-- Reason why no related code fix: User Error
*/

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58628'
where intakenumber  = 'I251013251805';

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58628'
where objectid = 'I251013251805';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58628'
where intakenumber = 'I251013251805';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58628'
where intakenumber = 'I251013251805';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58628'
where intakenumber = 'I251013251805';