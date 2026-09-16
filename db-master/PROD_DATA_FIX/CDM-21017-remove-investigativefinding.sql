/*
-- CDM-21017 - 

-- Issue Description: 
 Missing Investigation Findings
  
-- Customer Email ID: hanna.mcwilliams2@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update investigationmaltreatmentactor
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-21017'
where investigationmaltreatmentactorid = 'ea774d6d-5659-4ad4-b89c-fdf7317fed2a'