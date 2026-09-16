-- CDM-36295 - Case needs to be screened out
/*
-- Case ID: I231011390477
-- Category/ Module: Decision/Disposition
-- Root cause: user wants to delete intake as there is no person added into the referral
-- Fix Provided:  updated intakedastatus and intakedastaging with active flag to 0. # I231011390477
-- Pull request# N/A
*/

-- Backup
select * from intakedastatus where intakenumber = 'I231011390477' and activeflag=1;

-- Update
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36295'
where intakenumber = 'I231011390477' and activeflag=1;

-- Backup
select * from intakedastaging where intakenumber = 'I231011390477' and activeflag=1;

-- Update
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36295'
where intakenumber = 'I231011390477'and activeflag=1;