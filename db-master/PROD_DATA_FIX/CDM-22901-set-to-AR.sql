/*
-- CDM-22901- 

-- Issue Description: 
 Unable to update the case to AR
  
-- Customer Email ID: corey.magee@montgomerycountymd.gov

-- Root cause: Data fix to set the case to AR
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-22901' where personprogramid = 'eef7e290-b8d5-4ab2-a02f-6b69ed4de15d';

update personprogramarea set subprogramkey = 'AR', updatedon = now(), updatedby = 'CDM-22901' where personprogramid in ('71481703-366d-4976-abc7-23238b34f652', '1c817214-23f1-48a5-afdb-6bf639ffcaea');
