/*
-- CDM-22977 --

-- Issue Description: 
 Unable to remove the child removal
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove the child removal
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-22977', updatedon = now
where intakeservreqchildremovalid = 'cf616b81-6c43-4054-b981-3e90293b159f';

update personprogramarea set activeflag = 0, updatedby = 'CDM-22977', updatedon = now
where personprogramid = 'c2625aef-63fa-43e1-b895-d798f512dae6';