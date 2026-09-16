/*
 Issue Description: CDM-40089
-- Category/ Module: Delete Intake
-- Root cause: User wants to remove the intake as the worker has created another intake and connected with existing service case.
-- Fix Provided: Datafix has been promoted to update the active flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42843'
where intakenumber  = 'I241013179806';

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42843'
where objectid = 'I241013179806';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42843'
where intakenumber = 'I241013179806';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42843'
where intakenumber = 'I241013179806';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-42843'
where intakenumber = 'I241013179806';