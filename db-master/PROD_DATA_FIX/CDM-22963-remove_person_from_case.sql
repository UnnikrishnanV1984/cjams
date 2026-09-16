/*
-- CDM-22963 
-- Issue Description: Duplicate person to be removed from the case
*/

update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-22963'
where personid in ('aaa3c0bd-9820-40ba-adc4-95b66e14b33c', '9494a4d4-2874-4327-b199-7ebc26559311');

update cjams.intakeservicerequestactor
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-22963'
where personid in ('aaa3c0bd-9820-40ba-adc4-95b66e14b33c', '9494a4d4-2874-4327-b199-7ebc26559311');

update cjams.personrole p  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-22963'
where personid in ('aaa3c0bd-9820-40ba-adc4-95b66e14b33c', '9494a4d4-2874-4327-b199-7ebc26559311');

update cjams.actorrelationship a2 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-22963'
where intakeservicerequestactorid in (select  intakeservicerequestactorid from intakeservicerequestactor where personid in ('aaa3c0bd-9820-40ba-adc4-95b66e14b33c', '9494a4d4-2874-4327-b199-7ebc26559311'));

update contactparticipant 
set intakeservicerequestactorid = '8758bf76-08f5-4874-b50d-6932b12254d9',
	updatedon = now(),
	updatedby = 'CDM-22963'
where contactparticipantid in ('a6d26b1f-51d1-4714-b0bb-a8e1a4d1fa70',
'06306e44-cc07-43b9-996b-bc6436914dcb',
'87beb167-96fb-44da-baee-9ca2245e6964',
'afa9e46a-f58d-4fda-bd44-89fbc7fca773',
'99f06959-5bd9-41cd-b02d-57ac2c5ae922',
'8027c3ce-efc6-4406-838d-c13d984d60a0',
'22f2e172-0fa3-43c8-a32e-1f4d50c281d5');

update assessment
set submissiondata = replace(replace(replace(submissiondata::text, 'arabella keith', 'Arabella Rose Keith'), '200904907', '200905778'), 'Chastity Keith', 'Chastity L Keith')::json, updatedby = 'CDM-22963', updatedon = now()
where assessmentid = 'b371cf17-87b6-4b37-9319-184ad571e523';

update intakeservicerequestactor set intakenumber = 'I221010271976', updatedby = 'CDM-22963', updatedon = now() 
where intakeservicerequestactorid IN ('8758bf76-08f5-4874-b50d-6932b12254d9', '0b3047fc-48a0-498a-8aa4-1b5810778fac');

update investigationallegation
set activeflag = 0, updatedby = 'CDM-22963', updatedon = now()
where investigationallegationid = 'fc0af0ea-d8f3-455c-86dd-c5d3e55a2c6a';

update investigationallegationmaltreators
set intakeservicerequestactorid = '8758bf76-08f5-4874-b50d-6932b12254d9', updatedby = 'CDM-22963', updatedon = now() 
where investigationallegationmaltreatorsid = 'e648bec6-5c85-49c3-bca1-a2505ff3b129';

update assessment
set submissiondata = replace(submissiondata::text, 'Chastity Keith', 'Chastity L Keith')::json, updatedby = 'CDM-22963', updatedon = now()
where assessmentid = 'fad43cdc-34a8-4147-9dbc-1111e685d9cc';
