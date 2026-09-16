/*
-- CDM-23698 -- 

-- Issue Description: 
 Unable to remove duplicate OOH
  
-- Customer Email ID: jenny.sibila@maryland.gov

-- Root cause: Data fix to remove the duplicate OOH
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservreqchildremoval set activeflag = 0, updatedby ='CDM-23698', updatedon = now()
where intakeservreqchildremovalid = 'a2f74843-8416-4174-b695-e46a8f0afd49' and activeflag = 1;