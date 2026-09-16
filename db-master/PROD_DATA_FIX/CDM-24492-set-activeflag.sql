/*
-- CDM-24492-- 

-- Issue Description: 
 Unable to remove items on case pending approval inbox

-- Customer Email ID: tara.newcomer2@maryland.gov

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0 , updatedon =  now(), updatedby = 'CDM-24492'
where routingid ='c4aaaa31-03b2-48dc-81ed-f1024c0d5eb0'  and activeflag = 1;