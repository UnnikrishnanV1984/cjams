/*
 Issue Description: CDM-40953
-- Category/ Module: Delete Intake
-- Root cause: User wants to remove the intake
-- Fix Provided: Datafix has been promoted to update the active flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastaging
set activeflag=0, updatedby='CDM-40953', updatedon='now()'
where intakenumber='I221010275871' and activeflag=1;

update intakedastatus
set activeflag=0,updatedby='CDM-40953', updatedon='now()'
where intakenumber='I221010275871' and activeflag=1;