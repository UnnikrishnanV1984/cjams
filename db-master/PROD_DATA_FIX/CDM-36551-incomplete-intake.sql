/*
-- Issue Description: CDM-36551 - Incomplete intake #I202000668745
-- Category/ Module: Intake Referral (Intake Management)
-- Root cause: Worker is no longer employed with the department so the intake should be deleted
-- Fix provided: Fix provided by deleting the intake.
-- Pull request# for code fix: 
-- Reason why no related code fix: 
-- Status of the code fix if already submitted and expected prod fix date: 
*/

-- Backup
select * from intakedastatus where intakenumber = 'I202000668745' and activeflag=1;

-- Update
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36551'
where intakenumber = 'I202000668745' and activeflag=1;


-- Backup
select * from intakedastaging where intakenumber = 'I202000668745' and activeflag=1;

-- Update
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36551'
where intakenumber = 'I202000668745' and activeflag=1;