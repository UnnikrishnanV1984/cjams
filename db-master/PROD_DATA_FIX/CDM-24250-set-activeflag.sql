/*
-- CDM-24250-- 

-- Issue Description: 
 Unable to remove items on case pending approval inbox

-- Customer Email ID: laura.joiner@maryland.gov

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0 , updatedon =  now(), updatedby = 'CDM-24250'
where routingid in ('b762d07d-261a-4883-908b-26e4dac23a0b','de210a70-facb-46db-822f-a506364d536b') and activeflag = 1;