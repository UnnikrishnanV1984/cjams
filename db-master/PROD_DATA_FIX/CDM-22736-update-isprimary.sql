/*
-- CDM-22736- 

-- Issue Description: 
 Unable to set the Head of Household
  
-- Customer Email ID: noa.davis@maryland.gov

-- Root cause: Data fix to set the Head of Household
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequestactor set isprimary = true, updatedby = 'CDM-22736', updatedon = now() 
    where intakeservicerequestactorid = 'f292d9eb-6043-45b0-b979-a581cc2f42fe';