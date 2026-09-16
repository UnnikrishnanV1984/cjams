/*
   Issue Description: CDM-27024
   Category/ Module  : alert duplications
   Root cause: REMOVE THIS FROM HER SYSTEM ALERTS.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update usernotification set updatedby = 'CDM-27024', updatedon = now(), activeflag ='0' where usernotificationid IN
('e45f2e4c-dfbc-44d0-885f-c62d8756aa07',
'6fa4ef26-a323-479d-ae84-c92db0aa5a55',
'7afde6b8-5123-4c83-846b-6a407899d3b6',
'54bad0c5-f30a-4874-bc9e-2d4ea5214560',
'220def1a-50a5-49d5-9927-8a27c746d45f',
'8221d51b-9cbb-463a-a4bb-3d5367a66899',
'ad613ac2-3ee9-49b7-9ce8-765a526f9e55',
'8b94fbad-1c7e-4530-bf9f-9a9202386170',
'8627ddc1-39ae-461b-a949-0aee3cda7d4e',
'050dc050-d722-44d2-ac4a-d29d99d1df50',
'10822716-70b6-4157-9256-8cce9d77f16a',
'98cdd226-7f99-4667-9cf8-5246a36ea35e',
'80bd672f-0797-473a-9567-067d39277643',
'a6dabd8b-90f1-4917-ae93-c4ef9393ba22',
'97f66ace-2fdd-4dc7-9c7d-9fb368091452',
'd860b687-1962-405a-a2c0-e6d24da24470',
'58aea80a-e569-4223-82b9-8bbc2057a946',
'721f7cd6-3612-4084-aaa9-221a341c67e6',
'b3f982fa-c33e-48ce-9177-ca5069ef84a1',
'be0b47e1-1f77-494f-9b8b-e2753cfb30f7',
'19574166-2ede-48fb-aeeb-6a4c6f6ee1bf',
'75806216-e799-40ca-aa03-653c053a57a3',
'f7d4552c-efe6-4fdd-bab2-9fb178557c1b',
'abf7d7f3-914e-4df4-a1bd-4a1795c84d69',
'743c1a8d-8b6d-42ce-adf3-9c00be6ae47f',
'4cf9b14d-b548-4781-8227-982b3477efa1',
'd0819ca0-ea04-40ec-ae9f-8ae568985c37',
'cb6bf5df-60ff-4ae4-82f2-4ee91edefa01',
'ab4ec8c9-6403-47a1-9b68-c54ac42428bd',
'01436937-3b6e-4136-ac14-1aca680c344c',
'f408435d-279f-4fdf-b0ac-85aa9cc215b3',
'8641d06b-e0dd-487d-8062-da25581a52b4',
'cc1c09a2-d667-4794-b92a-3eddeb9b987e',
'80b93a75-0811-4479-9c47-cf2828b279b1',
'db20e387-f7f3-4593-889a-e9e040149457',
'4b1bdf5f-5d71-4d83-917c-e7727bb38cbb');



update usernotificationmap set updatedby = 'CDM-27024', updatedon = now(), activeflag = '0' where tosecurityusersid = 'c4d0b6a8-99c0-4d7e-b6ff-859618c9d4ae'
and usernotificationid IN 
('e45f2e4c-dfbc-44d0-885f-c62d8756aa07',
'6fa4ef26-a323-479d-ae84-c92db0aa5a55',
'7afde6b8-5123-4c83-846b-6a407899d3b6',
'54bad0c5-f30a-4874-bc9e-2d4ea5214560',
'220def1a-50a5-49d5-9927-8a27c746d45f',
'8221d51b-9cbb-463a-a4bb-3d5367a66899',
'ad613ac2-3ee9-49b7-9ce8-765a526f9e55',
'8b94fbad-1c7e-4530-bf9f-9a9202386170',
'8627ddc1-39ae-461b-a949-0aee3cda7d4e',
'050dc050-d722-44d2-ac4a-d29d99d1df50',
'10822716-70b6-4157-9256-8cce9d77f16a',
'98cdd226-7f99-4667-9cf8-5246a36ea35e',
'80bd672f-0797-473a-9567-067d39277643',
'a6dabd8b-90f1-4917-ae93-c4ef9393ba22',
'97f66ace-2fdd-4dc7-9c7d-9fb368091452',
'd860b687-1962-405a-a2c0-e6d24da24470',
'58aea80a-e569-4223-82b9-8bbc2057a946',
'721f7cd6-3612-4084-aaa9-221a341c67e6',
'b3f982fa-c33e-48ce-9177-ca5069ef84a1',
'be0b47e1-1f77-494f-9b8b-e2753cfb30f7',
'19574166-2ede-48fb-aeeb-6a4c6f6ee1bf',
'75806216-e799-40ca-aa03-653c053a57a3',
'f7d4552c-efe6-4fdd-bab2-9fb178557c1b',
'abf7d7f3-914e-4df4-a1bd-4a1795c84d69',
'743c1a8d-8b6d-42ce-adf3-9c00be6ae47f',
'4cf9b14d-b548-4781-8227-982b3477efa1',
'd0819ca0-ea04-40ec-ae9f-8ae568985c37',
'cb6bf5df-60ff-4ae4-82f2-4ee91edefa01',
'ab4ec8c9-6403-47a1-9b68-c54ac42428bd',
'01436937-3b6e-4136-ac14-1aca680c344c',
'f408435d-279f-4fdf-b0ac-85aa9cc215b3',
'8641d06b-e0dd-487d-8062-da25581a52b4',
'cc1c09a2-d667-4794-b92a-3eddeb9b987e',
'80b93a75-0811-4479-9c47-cf2828b279b1',
'db20e387-f7f3-4593-889a-e9e040149457',
'4b1bdf5f-5d71-4d83-917c-e7727bb38cbb');