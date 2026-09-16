/*
 Issue Description: CJAMS-58022
-- Category/ Module: Delete Intake
-- Root cause: User requested to remove intake
-- Fix Provided: Datafix has been promoted to remove the intake.
-- Pull request# N/A
-- Reason why no related code fix: User Error
*/

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58022'
where intakenumber  = 'I231010545536' and activeflag = 1;

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58022'
where objectid = 'I231010545536' and activeflag = 1;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58022'
where intakenumber = 'I231010545536' and activeflag = 1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58022'
where intakenumber = 'I231010545536' and activeflag = 1;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58022'
where intakenumber = 'I231010545536' and activeflag = 1;
