/*
-- CDM-21063 - 

-- Issue Description: 
 Remove Person
  
-- Customer Email ID:pamela.chandler@maryland.gov

-- Root cause: Data fix to updated the end date
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21063'
where actorid = '1db2128e-1962-471d-8eaf-19a073c4a1f4';

update intakeservicerequestactor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21063'
where intakeservicerequestactorid = '1175ed5e-e756-44c9-a53e-41b874414ef4';

update personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21063'
where personroleid = '65aecae6-b3f5-4da7-8ea6-353193a1d0d4';

update cjams.actorrelationship 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-21063'
where actorrelationshipid = '28dfb1f5-9cb1-40d9-aa30-ed759f39f777';