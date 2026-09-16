/*
-- CDM-20598 - 

-- Issue Description: 
 Missing Investigation Findings
  
-- Customer Email ID: quintin.mcdonald@maryland.gov

-- Root cause: Data fix updated the activeflag to 1
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequestactor set activeflag =1, updatedby = 'CDM-20598', updatedon = now() where intakeservicerequestactorid = 'a84da7eb-9894-4a4d-b732-07cca2e665b9' and activeflag = 0;