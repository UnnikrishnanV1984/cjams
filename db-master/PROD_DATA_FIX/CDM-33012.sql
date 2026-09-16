/*
   Issue Description: CDM-33012
   Category/ Module  : person
   Root cause: user want to update data Person ID 200668368 with Person ID 1040860
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update intakeservicerequestactor i set isheadofhousehold=false ,updatedby = 'CDM-33012', updatedon = now()
where intakeservicerequestactorid ='9cb8baff-86b3-4c41-80ee-e8f086826ec9';
update intakeservicerequestactor i set isheadofhousehold=false ,updatedby = 'CDM-33012', updatedon = now()
where intakeservicerequestactorid ='d8687ade-bdaa-4503-8e8b-5ce5c9b38a0f';




update intakeservicerequestactor i set isheadofhousehold=true ,updatedby = 'CDM-33012', updatedon = now()
where intakeservicerequestactorid ='2b82088b-af2b-432d-8271-144defd97e68';


update contactparticipant set intakeservicerequestactorid='2b82088b-af2b-432d-8271-144defd97e68',updatedby = 'CDM-33012', updatedon = now()
where contactparticipantid in ('6b6cd1bf-cf85-4ebf-a288-9d910ecfb09c','ed4a6db9-49d7-48e6-a570-7b852b75c905',
'ad15b9f3-a908-40bb-983a-fc252c008706','27977e40-2264-459a-9a53-2303a5a212a1','20758e0f-b9a8-4729-9bdf-1b8de39e8f29',
'b4e04d6f-8581-446c-9b40-4b595338778b','a82d8dc4-7999-4bc2-a54e-9e4a8ea881d8',
'53480f14-ffa7-447f-a5e3-2a64bd506bb5','13a8c2ea-c9e9-41a2-a44b-4ea2165ed83f','33820e95-3282-4410-908a-fc63e1d8cb45',
'dc05225f-de7b-4056-aa44-95158ab63968','e4bb91ed-5975-4b1f-81a2-ee0faa137349','7cbb3090-93df-42df-8548-7d4be9326ec2',
'ce063375-4620-4c7a-9116-2987dbdd7661','5b00ae94-7c79-4b90-ad0d-e3fc44d9385a','c6fd9cea-3895-40dc-9eae-370232c9f53a',
'4ec8e950-e3cd-4a23-a92a-e2e38e828a68','d5976cfe-1e75-4d3f-8b31-7f104bdbdc42','52b71d3e-6c7d-4159-8c13-559949c044c1',
'ed22e9e0-c696-4e90-bcd6-742edf44db8a','0c5954fb-858f-49ea-92fd-1358028834ee','bffd8f10-114d-466a-9bd6-b00457b54fdb',
'eb86035a-80d1-4846-bbad-db707271f083','852ac009-1843-496f-85d9-95cb83375484','2fb08aa6-d42f-4d7f-bcb8-2617cb9a0ebf',
'52716707-4f6b-4f3e-a5a1-5627eaac4c3a','53480f14-ffa7-447f-a5e3-2a64bd506bb5',
'13a8c2ea-c9e9-41a2-a44b-4ea2165ed83f','33820e95-3282-4410-908a-fc63e1d8cb45','dc05225f-de7b-4056-aa44-95158ab63968','3dd0e304-0974-4587-9709-27f60e0ea8d9',
'226376fd-edec-4177-8603-c4b0c7c0e5b2');


 update progressnote set focusperson = jsonb_set(focusperson::jsonb, '{focuspersonjson}', 		 
			jsonb_set((focusperson->'focuspersonjson')::jsonb, '{0}', 
			(focusperson->'focuspersonjson'->0)::jsonb||('{"intakeservicerequestactorid":"2b82088b-af2b-432d-8271-144defd97e68","firstname":"DANIE''L","lastname": "STEVENS"}')::jsonb))
			,updatedby = 'CDM-33012', updatedon = now()
where progressnoteid in ('6355964f-84ba-4c86-8559-b47f4711cdc2','c4867e3f-c3a8-4f6c-8d42-23d5a28f26f7','3dd0e304-0974-4587-9709-27f60e0ea8d9',
'9203c992-b145-42b9-8310-1bf1843d24d5','2e1b9a2c-89a5-41d6-b01e-cd9389d14949','378f128a-ae99-47b9-ac43-590c9ee49871',
'72718e5d-2332-4d81-bb62-cbd7c522b375','70b69ad8-23d3-4e25-a7b2-a18bb9cc9da0','cd897d11-dbc1-4521-9967-f8b55ba2f51c',
'104c3733-0f25-4cd8-bd25-3aa6ea601c44','2c53190f-2e42-4852-9242-357259e3a9b3',
'f423e5ea-507c-4355-8d25-e69a7726eb68');


update progressnote set focusperson = jsonb_set(focusperson::jsonb, '{focuspersonjson}', 		 
			jsonb_set((focusperson->'focuspersonjson')::jsonb, '{1}', 
			(focusperson->'focuspersonjson'->1)::jsonb||('{"intakeservicerequestactorid":"2b82088b-af2b-432d-8271-144defd97e68","firstname":"DANIE''L","lastname": "STEVENS"}')::jsonb))
			,updatedby = 'CDM-33012', updatedon = now()
where progressnoteid in ('22217355-9a7a-4a22-b666-3ab462075bfc','438f89d1-53a1-4959-a195-b76032f5aeb9','68706c07-83b1-4217-b985-29c98e10ff31');

 update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{headofhouseholdname}','["DANIE''L W STEVENS"]')
where assessmentid in('3eb3f23f-7b1b-480f-ac61-b7979f18a50d','66cb1e5e-4043-4e9c-ae82-580ac70cb969','81d5f564-1fa1-4087-be9d-1f0462b85fef');

update assessment set submissiondata  = 
replace( submissiondata::text ,  'Danie''l  Stevens',  'DANIE''L W STEVENS' )::json
where    assessmentid in ('ac617ca4-f21c-4217-82bf-7be12f23064c','2e542c5c-bcc3-45cb-9188-b68007c90448');

update assessment set submissiondata  = 
replace( submissiondata::text ,  'Danie''l Stevens',  'DANIE''L W STEVENS' )::json
where     assessmentid in ('ac617ca4-f21c-4217-82bf-7be12f23064c','2e542c5c-bcc3-45cb-9188-b68007c90448');

update assessment set submissiondata  = 
replace( submissiondata::text ,  '"intakeservicerequestactorid": "d8687ade-bdaa-4503-8e8b-5ce5c9b38a0f"',  '"intakeservicerequestactorid": "2b82088b-af2b-432d-8271-144defd97e68"' )::json
where    assessmentid in ('ac617ca4-f21c-4217-82bf-7be12f23064c','2e542c5c-bcc3-45cb-9188-b68007c90448');

update assessment set submissiondata  = 
replace( submissiondata::text ,  '"houseHoldName": "Danie''l Stevens"',  '"houseHoldName": "DANIE''L W STEVENS"' )::json
where     assessmentid in ('3da5cf4e-ce9e-4d1e-b92f-b09838ffc802');



update assessment set submissiondata  = 
replace( submissiondata::text ,  'd8687ade-bdaa-4503-8e8b-5ce5c9b38a0f',  '2b82088b-af2b-432d-8271-144defd97e68' )::json
where    assessmentid in ('3eb3f23f-7b1b-480f-ac61-b7979f18a50d','0a921f0e-4b77-42ec-8df9-6aa1c3741474','3da5cf4e-ce9e-4d1e-b92f-b09838ffc802');

update assessment set submissiondata  = 
replace( submissiondata::text , 'Danie''l Stevens', 'DANIE''L W STEVENS' )::json
where    assessmentid in ('0a921f0e-4b77-42ec-8df9-6aa1c3741474','3da5cf4e-ce9e-4d1e-b92f-b09838ffc802');


update assessment set submissiondata  = 
replace( submissiondata::text , 'Danie''l  Stevens', 'DANIE''L W STEVENS' )::json
where    assessmentid in ('0a921f0e-4b77-42ec-8df9-6aa1c3741474','3da5cf4e-ce9e-4d1e-b92f-b09838ffc802');

update cjams.intakeservicerequestactor set servicecaseid=null,updatedon = now(),
updatedby = 'CDM-33012' where intakeservicerequestactorid in ('d8687ade-bdaa-4503-8e8b-5ce5c9b38a0f',
'57704586-f414-4f3b-bc4f-5bff35687b9e','4626b2e2-b8c1-4f25-8434-2bff62e83799');


update assessment set submissiondata  = 
replace( submissiondata::text , ' Danie''l  Stevens ', 'DANIE''L W STEVENS' )::json
where    assessmentid in ('3eb3f23f-7b1b-480f-ac61-b7979f18a50d');


update cjams.contactparticipant set intakeservicerequestactorid ='2b82088b-af2b-432d-8271-144defd97e68',
updatedby = 'CDM-33012', updatedon = now()
where contactparticipantid ='64214a3e-259e-46df-9375-550af1db290b';
