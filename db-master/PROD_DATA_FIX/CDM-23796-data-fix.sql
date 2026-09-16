/*
-- CDM-23796-- 

-- Issue Description: 
 Unable to remove items on case pending approval inbox

-- Customer Email ID: abbey.niland@maryland.gov

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-23796', updatedon = now() 
where routingid = '28047512-2192-4c34-901b-92e9d19a905d' and activeflag = 1;