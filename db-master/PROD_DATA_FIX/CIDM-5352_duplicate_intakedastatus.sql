/*
-- CIDM-5352 
-- Issue Description: Duplicate row in intakedastatus table for same intake with activeflag as 1
*/

update intakedastatus
set activeflag = 0, updatedby = 'CIDM-5352', updatedon = now()
where intakedastatusid = '95345012-eeef-4629-a8ca-9df2df34b26b'; 