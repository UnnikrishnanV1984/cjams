/*
-- CDM-19602 - 

-- Issue Description: 
 Soft delete the contact
  
-- Customer Email ID:gail.giles@maryland.gov

-- Root cause: Data fix to set active flag to zero to soft delete the contact
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update progressnote set activeflag = 0,updatedon = now(), updatedby = 'CDM-19602' where progressnoteid = '68698359-fe71-4623-b35d-658be1c32b8a';

update progressnotedetail set activeflag = 0,updatedon = now(), updatedby = 'CDM-19602' where progressnoteid = '68698359-fe71-4623-b35d-658be1c32b8a';

