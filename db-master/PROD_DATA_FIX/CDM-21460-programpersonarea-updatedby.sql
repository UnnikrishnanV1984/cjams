/*
-- CDM-21460 - 

-- Issue Description: Fix personprogramarea updated by

-- Root cause: Data fix
-- Pull request#:
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea 
set updatedby = '4d98a0c2-3006-4687-914a-72ae28497f68', updatedon = now()
where personprogramid = '6ccf370e-120e-4b7e-ab9c-2984069505ae';
