/*
-- Issue Description: CDM-36289 - Case needs to be screened out
-- Category/ Module: Intake Referral (Intake Management)
-- Root cause: New intake has been created. I241011862485, this intake is not needed.
-- Fix provided: Fix provided by deleting the intake.
-- Pull request# for code fix: 
-- Reason why no related code fix: 
-- Status of the code fix if already submitted and expected prod fix date: 
*/

-- Backup
select * from intakedastatus where intakenumber = 'I241011862485' and activeflag=1;

-- Update
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36289'
where intakenumber = 'I241011862485' and activeflag=1;


-- Backup
select * from intakedastaging where intakenumber = 'I241011862485' and activeflag=1;

-- Update
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36289'
where intakenumber = 'I241011862485' and activeflag=1;
