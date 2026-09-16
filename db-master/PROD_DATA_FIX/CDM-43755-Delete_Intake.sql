/*
    Issue Description: CDM-43755
-- Category/ Module: Delete Intake
-- Root cause: User wants to remove the intake.
-- Fix Provided: Datafix has been promoted to update the active flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43755'
where intakenumber  = 'I251013201847';

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43755'
where objectid = 'I251013201847';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43755'
where intakenumber = 'I251013201847';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43755'
where intakenumber = 'I251013201847';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43755'
where intakenumber = 'I251013201847';