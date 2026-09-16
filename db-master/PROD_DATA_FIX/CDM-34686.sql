/*
 * CDM-34686 - Names listed are incorrect
 * Customer Email ID:missy.langham@maryland.gov
 * Customer Name:Missy Langham
 * Focus Area:Assessments: Other
 * Description - 231021171279:In Phiona Rogers case, I'm trying to write in a contact note and the "involved persons" are names in another case. 
 * Update and Replace the  person contacted and Subject of the contact with  Person ID# 201950539 ( Phiona Rogers )  from CPS-AR : 231021171279, 
 * contact note of October 5, SSA team has approved it
 * 
 */

--select cjamspid,  * from person where personid = '63f456b4-c5ea-46b8-8f06-25e2ed161971'; -- Kaelyn
--select personid, * from person where cjamspid = '201950539'; -- 73e4488f-64f3-4f1f-8087-b3b21e0780bf
--select intakeservicerequestactorid ,* from contactparticipant where contactparticipantid = 'f7401a22-7243-4066-b87c-0650ec87bfa0'; -- 750ba56b-92b2-4ab5-b9d4-d1d9fd63cc92 -- ea0354f9-8775-4f81-a5fe-08b4750e3e9d
--select personid ,* from intakeservicerequestactor where intakeservicerequestactorid = '750ba56b-92b2-4ab5-b9d4-d1d9fd63cc92';
--select * from intakeservicerequestactor where personid = '73e4488f-64f3-4f1f-8087-b3b21e0780bf' and activeflag =1; -- ea0354f9-8775-4f81-a5fe-08b4750e3e9d
UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='ea0354f9-8775-4f81-a5fe-08b4750e3e9d'::uuid, updatedby = 'CDM-34686', updatedon = now() 
WHERE contactparticipantid='f7401a22-7243-4066-b87c-0650ec87bfa0'::uuid;

select focusperson  ,* from progressnote where progressnoteid = 'd5d2004b-6b41-438d-a7f4-0d47df92b4c5';
UPDATE cjams.progressnote
SET focusperson='{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"ea0354f9-8775-4f81-a5fe-08b4750e3e9d","participantid":"750ba56b-92b2-4ab5-b9d4-d1d9fd63cc92","firstname":"Phiona","lastname":"Rogers","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}'::json, updatedby = 'CDM-34686', updatedon = now() 
WHERE progressnoteid='d5d2004b-6b41-438d-a7f4-0d47df92b4c5'::uuid;
