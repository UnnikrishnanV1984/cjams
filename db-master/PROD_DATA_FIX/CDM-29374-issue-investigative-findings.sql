/*
-- Issue Description: 
   User request to Remove duplicated Investigation findings
-- Category/ Module: Inverstigation Finding  (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
   investigationallegation
set
   activeflag = 0,
   updatedby = 'CDM-29374',
   updatedon = now()
where
   investigationallegationid in
('d12d69ed-54ad-4614-b73c-48c982bf1198',
'a59acfac-fbd0-4150-953e-c18953e1a674',
'5e492a1e-b0a2-41bb-896d-e371143773dc',
'a9cb0bb7-b601-4e0a-ad05-b4a6fc657224',
'170a0bf9-b3dd-4054-a408-863f94ed1c06',
'c259fb31-51b1-4dff-83bc-7053d82e8f10',
'7141d0f4-d8d8-4ad0-8db2-54d669740db5',
'89628c28-7361-4449-9e02-e46a54fc0973',
'ca11cc91-5e96-4f96-9dd3-3eaa8611cd11',
'67beebb4-47ee-4d56-8692-5648417e8bb3',
'c7b7f6df-d070-4e2c-be7d-0f3f7948f9c8',
'698247ea-a134-405e-a890-9fe96caad8ed');