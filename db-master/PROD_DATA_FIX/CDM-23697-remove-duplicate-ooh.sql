/*
-- CDM-23697 -- 

-- Issue Description: 
 Unable to remove duplicate OOH
  
-- Customer Email ID: jenny.sibila@maryland.gov

-- Root cause: Data fix to remove the duplicate OOH
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservreqchildremoval set activeflag =0, updatedby = 'CDM-23967', updatedon = now()
where intakeservreqchildremovalid = '45715f69-3844-4fea-abbc-6f9c26e404d9' and activeflag = 1;