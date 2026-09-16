/*
-- CDM-21457 - 

-- Issue Description: Fix personprogramarea updated by
  
-- Root cause: Data fix
-- Pull request#:
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea 
set updatedby = '4d98a0c2-3006-4687-914a-72ae28497f68', updatedon = now()
where personprogramid = 'fc7951a8-c41f-4c61-86de-2c150810e3c4';

