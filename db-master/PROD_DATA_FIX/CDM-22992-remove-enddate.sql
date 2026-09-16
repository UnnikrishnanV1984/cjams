/*
-- CDM-22992- 

-- Issue Description: 
 Unable to remove the end date
  
-- Customer Email ID: heather.ruark1@maryland.gov

-- Root cause: Data fix to set the enddate
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 2021-06-29 12:00:25    REUNIF
update intakeservreqchildremoval  set exitdate  = null,removalexitreason = NULL,
updatedby = 'CDM-22992', updatedon = now() where 
intakeservreqchildremovalid  = '977b97f3-e4ff-43e2-bad3-d0850970b2a6';


update intakeservreqchildremoval  set activeflag = 0,
updatedby = 'CDM-22992', updatedon = now() where 
intakeservreqchildremovalid = '3cd524dc-0189-49b3-897f-0ef9d76b6569' and activeflag = 1;