/*
-- CDM-22799- 

-- Issue Description: 
 Unable to remove duplicate persons
  
-- Customer Email ID: rosa.barrientos@montgomerycountymd.gov

-- Root cause: Data fix to remove duplicate persons
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-22799', updatedon = now() 
where intakeservicerequestactorid in ('040fe218-fa1e-4d3a-a4c6-a3e60d687a79',
'68f1ba56-0a4e-4611-8bcc-8f3d8b75c81a','f9caf1e6-163a-4841-8f74-cd80fdc9cd85',
'd098ceda-3c8f-40cf-af11-cb6b041a5f35') and activeflag = 1;