/*
 Issue Description: CDM-40954
-- Category/ Module: Delete Intake
-- Root cause: User wants to remove the intake.
-- Fix Provided: Datafix has been promoted to update the active flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-40954'
where intakenumber = 'I241012979837';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-40954'
where intakenumber = 'I241012979837';