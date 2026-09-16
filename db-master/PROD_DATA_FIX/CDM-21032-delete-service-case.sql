/*
-- CDM-21032 - 

-- Issue Description: 
 Remove Service Case
  
-- Customer Email ID:kathryn.morton@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case Number: 211030012555 --

update servicecase set activeflag =0, updatedby = 'CDM-21032', updatedon = now() where servicecaseid = 'd5d9b87c-19a1-4e7d-988f-c6103514df54';