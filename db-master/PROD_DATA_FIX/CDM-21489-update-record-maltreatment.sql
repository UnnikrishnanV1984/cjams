/*
-- CDM-21489 - 

-- Issue Description: 
 Data fix to update/edit record maltreatment
  
-- Customer Email ID: briana.stern3@maryland.gov

-- Root cause: Data fix to update/edit record maltreatment
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select isnegrh_treatmenthealthrisk,* from intakeservicerequestsdm i where intakeservicerequestsdmid = '216ad4d6-a8c6-43d8-9a15-427491c228df';


update intakeservicerequestsdm set isnegrh_treatmenthealthrisk = true, updatedon = now(), updatedby = 'CDM-21489'
where intakeservicerequestsdmid = '216ad4d6-a8c6-43d8-9a15-427491c228df';