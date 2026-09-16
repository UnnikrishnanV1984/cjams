/*
-- Issue Description: 241022070838:Trisha Yoder dob 1/1/1919 should be deleted from the record. She is HOH and is already in the case.
-- Root cause: Change requested by user.
-- Fix Provided: Updated actor,intakeservicerequestactor, personrole, personroletype, actorrelationship tables to soft delete person with cjamspid as 202987537 who is associated with case 241022070838.
*/

update cjams.intakeservicerequestactor  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38888'
where intakeservicerequestactorid in ('07cd6f24-8c14-4bfe-b378-78da0c983c28', '81402285-b8de-4581-afc8-052109ade1a7')
and activeflag = 1;

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38888'
where actorid ='d1af6705-69f6-4723-a136-8b4195d0419c'
and activeflag = 1;

update cjams.personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38888'
where personroleid  = '94d9252b-48b3-4d32-96df-3dd2c5d1198b'
and activeflag = 1;


update cjams.personroletype 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38888'
where personroleid  = '94d9252b-48b3-4d32-96df-3dd2c5d1198b'
and activeflag = 1;


update cjams.actorrelationship 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38888'
where intakeservicerequestactorid in ('07cd6f24-8c14-4bfe-b378-78da0c983c28', '81402285-b8de-4581-afc8-052109ade1a7')
and activeflag = 1;