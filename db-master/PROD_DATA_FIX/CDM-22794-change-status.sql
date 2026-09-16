/*
-- CDM-22794- 

-- Issue Description: 
 Unable to change the status
  
-- Customer Email ID: brittany.brendel@maryland.gov

-- Root cause: Data fix to change the status
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 642f18b0-ef6e-4d4b-9871-acc0734f3f5a
UPDATE intakeservicerequest 
SET intakeserreqstatustypeid ='c8dbf10f-843d-4b40-97ca-288d750463da', 
    updatedby = 'CDM-22794',
    updatedon = now() 
WHERE intakeserviceid = '2203bad4-523c-41b1-97d1-b7ae60b719db';