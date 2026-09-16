/*
-- CDM-30675 
-- Issue Description: 
 Soft delete the contact
-- Customer Email ID: alexandra.chinn@maryland.gov
-- Root cause: Data fix to set active flag to zero to soft delete the contact
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE progressnote
SET activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30675'
WHERE progressnoteid = 'c114a6c9-7c11-403e-9da0-35c0daf25c50';


UPDATE progressnotedetail
SET activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30675'
WHERE progressnoteid = 'c114a6c9-7c11-403e-9da0-35c0daf25c50';

