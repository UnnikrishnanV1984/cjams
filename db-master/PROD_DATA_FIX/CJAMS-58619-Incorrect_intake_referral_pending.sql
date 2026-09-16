/*
 Issue Description: CJAMS-58619
-- Category/ Module: Delete Intake
-- Root cause: User wants to remove the intake.
-- Fix Provided: Datafix has been promoted to remove the intake.
-- Pull request# N/A
-- Reason why no related code fix: User Error
*/


update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58619'
where intakenumber  = 'I251013251076';

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58619'
where objectid = 'I251013251076';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58619'
where intakenumber = 'I251013251076';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58619'
where intakenumber = 'I251013251076';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58619'
where intakenumber = 'I251013251076';
