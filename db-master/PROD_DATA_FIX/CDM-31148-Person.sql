
/*
   Issue Description: CDM-31148
   Category/ Module  : User wants to delete the person 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31148'
where actorid in('bb5d19e1-a8ec-4863-9723-0a77c14796ef');

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31148'
where intakeservicerequestactorid in('603f46a1-b738-407c-9b9e-7ec07d01f130','65b7619c-9771-436a-a8c9-c6fde9ec4bb4','f7ae3e1e-19a9-4935-a00e-54c091630073') ;

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31148'
where personroleid  in('ec849cd9-a820-4b23-afe1-dfbb56b37724');

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31148'
where actorrelationshipid in('67d494f8-f21b-413d-9f3b-72e4ac44333b','b5711a48-40ed-47af-b7f8-2a3fcb7bec36','a8a141c5-26eb-4c0a-aa8a-4543232ffc6f','5c2e3cf8-2875-49b3-a20a-75cbbe45a6e4','ed100bf8-04ca-49e8-a31c-53dddd11d009') ;






--updating new person details 

UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='fccdd20b-8e21-4a09-898c-0cf830b65ce8';

UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='2f184d70-0420-4bf7-aee1-abfe55cf9a9e';

UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='67b8f749-5359-4dad-b44f-e906d1ac54df';

UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='6daef8ea-d744-4bd9-b915-993b15b5591b';


UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='87cbfd84-9026-4dee-bb5d-d2e8262b0e9c';


UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='8c836ddf-f3bb-4663-acce-90767d9604f5';


UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='d6f27722-a7f7-45b3-bbf6-38a0b0cc5161';

UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='e35e4fd6-fd1c-4d14-893f-0ef4a89a56b2';

UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='a86b3609-d893-43c6-b081-f53fecc2e9bb';


UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='a167ab55-df8b-447b-97cd-02a672d8d354';



UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='10830a4a-977c-483f-9f88-356254622d6a';


UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='757e5ed1-59f5-46e8-b041-576a13425a5c';


UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ca9b4bee-76a0-45fa-8645-359ee676175e', participantid='ca9b4bee-76a0-45fa-8645-359ee676175e',
updatedby='CDM-31148', updatedon=now()
WHERE contactparticipantid='757e5ed1-59f5-46e8-b041-576a13425a5c';



--CANSF

update assessment 
set submissiondata = replace(submissiondata::text, '"houseHoldName": "HEATHER THOMPSON",' , '"houseHoldName": "HEATHER A THOMPSON",')::json 
where assessmentid ='fee314c4-7219-4a56-91b0-63f7f102dedc';


update assessment 
set submissiondata = replace(submissiondata::text, '"houseHoldName": "HEATHER THOMPSON",' , '"houseHoldName": "HEATHER A THOMPSON",')::json 
where assessmentid ='dad031ff-dd65-4bdb-89ef-f38ce18f1380';

--MIFRA
update assessment 
set submissiondata = replace(submissiondata::text, '"houseHoldHeadName": "HEATHER THOMPSON",' , '"houseHoldHeadName": "HEATHER A THOMPSON",')::json 
where assessmentid ='66fe71d0-8c2b-45fb-8119-d7d9a249cd9b';

update assessment 
set submissiondata = replace(submissiondata::text, 'HEATHER THOMPSON' , 'HEATHER A THOMPSON')::json
where assessmentid ='66fe71d0-8c2b-45fb-8119-d7d9a249cd9b';


update assessment 
set submissiondata = replace(submissiondata::text, 'HEATHER  THOMPSON' , 'HEATHER A THOMPSON')::json
where assessmentid ='66fe71d0-8c2b-45fb-8119-d7d9a249cd9b';

--Safec
update assessment 
set submissiondata = replace(submissiondata::text, '"headofhouseholdname": "HEATHER THOMPSON ",' , '"headofhouseholdname": "HEATHER A THOMPSON",')::json 
where assessmentid ='dcf0e781-7656-49b7-958d-93833ba1cd7c';

update assessment 
set submissiondata = replace(submissiondata::text, '"headofhouseholdname": "HEATHER THOMPSON ",' , '"headofhouseholdname": "HEATHER A THOMPSON",')::json 
where assessmentid ='fad329a6-4ce6-438d-bdd2-296c1b1b360e';

update assessment 
set submissiondata = replace(submissiondata::text, '"headofhouseholdname": "HEATHER THOMPSON ",' , '"headofhouseholdname": "HEATHER A THOMPSON",')::json 
where assessmentid ='fd57eb24-4668-4330-908a-6c21813ffcbf';
