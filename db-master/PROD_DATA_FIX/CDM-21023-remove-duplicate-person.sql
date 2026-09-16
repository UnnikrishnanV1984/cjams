/*
-- CDM-21023 - 

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
updatedby = 'CDM-21023'
where actorid = '7d5a7e05-52ea-4cda-8db4-dd66a0a6c8ee';

update intakeservicerequestactor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21023'
where intakeservicerequestactorid = '2530a173-c1af-45cd-8213-d774d89405d8';

update personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21023'
where personroleid = '734537db-3a62-46cd-9665-eef99afc7cd0';

update cjams.actorrelationship 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21023'
where actorrelationshipid = 'f0132c81-b757-4522-b85e-7785263f714e';