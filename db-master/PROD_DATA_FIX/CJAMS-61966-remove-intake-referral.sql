-- CJAMS-61966 - Delete intake referral
/*
-- Issue Description: User request to delete intake referral # I251013250025.
-- Intake#: I251013250025
-- Category/ Module: delete intake referral
-- Root cause: User request to delete intake referral # I251013250025.
-- Fix Provided: Datafix has been provided to soft delete the intake referral# I251013250025 by updating activeflag. 
-- Regression Impacts: N/A
-- Is Code fix Required?: (Yes/No) No
-- Code fix ticket#: (If Yes) N/A
-- Reason why no related code fix: This doesn't require a code fix as its user error.
*/

update intakedastaging 
set activeflag=0, updatedby='CJAMS-61966', updatedon=now()
where intakenumber='I251013250025' and activeflag=1;

update intakedastatus 
set activeflag=0, updatedby='CJAMS-61966', updatedon=now()
where intakenumber='I251013250025' and activeflag=1;