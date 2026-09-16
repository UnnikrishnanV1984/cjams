/*
-- CDM-21086 - 

-- Issue Description: 
 Delete Duplicate Person from Persons Involved
  
-- Customer Email ID:kathryn.mcallister@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21086'
where actorid = '8ecea52e-dfad-42c4-9cf4-4e3e3b6b5f3f';

update intakeservicerequestactor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21086'
where intakeservicerequestactorid = '43fe9c92-b1cb-4604-b9a6-7549f1a9afbd';

update personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21086'
where personroleid = 'f0ed03f0-fcdd-4a65-bdc5-6b936dcc0b80';

update actorrelationship 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21086'
where actorrelationshipid = '43165419-0e93-4e99-9f5e-d89c27acfcf7';