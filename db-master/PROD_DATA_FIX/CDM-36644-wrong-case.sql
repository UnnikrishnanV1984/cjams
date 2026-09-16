/*
-- CDM-36644

-- Issue Description: Soft delete the contact
-- Root cause: User has requested to remove the contact note.
-- Fix provided: Data fix to set active flag to zero to soft delete the contact.
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Backup
select progressnoteid,activeflag,witsid,* from ProgressNote where progressnoteid= 'a2bfcc42-affb-4e6d-8a08-e85637363d2c';
-- Update
update
    ProgressNote
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36644'
where
    progressnoteid= 'a2bfcc42-affb-4e6d-8a08-e85637363d2c';

-- Backup
select activeflag,* from progressnotedetail where progressnoteid= 'a2bfcc42-affb-4e6d-8a08-e85637363d2c';
-- Update
update
    progressnotedetail
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36644'
where
    progressnoteid= 'a2bfcc42-affb-4e6d-8a08-e85637363d2c';