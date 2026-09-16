/*
 * CJAMS-66066 - User requested to delete Documents
 * Customer Email ID: taryn.shambaugh@maryland.gov
 * Customer Name: Taryn Shambaugh
 * Focus Area: Documents
 * Root cause: Documents got stuck in "Upload/Scan in progress" and user reuploaded the same documents and requested to delete the old documents.
 * Fix Provided: Deleted the requested documents in "Upload/Scan in progress"
*/

update documentproperties 
set activeflag =0, updatedby = 'CJAMS-66066', updatedon =now()
where documentpropertiesid in ('edc0a6dc-d707-4f27-b68e-5541b2644cda', '1a9af5ce-4e2b-44cc-bf51-1286af42f24c', 'a19527eb-8185-4432-ba11-4816a2c581af', '1fd68bca-80fe-434d-b16e-859e20e3f225', 
'a4a9f9bb-390b-437d-9fc5-3b3af634b0f8', '74198bff-7968-4ac6-ba20-3183641587c2', '63be9556-e8bb-4bbf-9e08-e2fe6add1872', 'f3af98ba-fc1f-4456-8799-0fe866533ea8',
'd5576a41-4515-46cd-af90-de3fb3712c7e', '8d706632-c5c6-4374-9ec2-251cf69f152c', '16d94ae6-00bd-4965-b471-b953dd81bf34', 'fcec409a-e9b5-48d0-821f-7dd2b650aa16',
'e84d98d7-df4a-4c38-b016-b44c0ae17e72', '6bb2a842-2c42-4e65-8bb8-c7442f5ebc66', '2c801ca3-72b2-4765-aace-0b80df0686ab', 'c43efbc2-6333-4329-bddb-3913c0237167',
'2756f10e-b32b-4341-b378-3e59df682dfb', '13f05c0b-0ce5-4d48-9e2d-7f224fe69578', '2947abe4-d9e8-4132-8567-5af4d9b7b330', '6c9484af-ba2a-4aa5-ad74-a0d058a5eade',
'5fff18df-d81c-4d35-9fbf-94172dd70bb6', 'e73222fa-18d1-42de-8400-3ab12c1ad5c0', 'ecc76843-a38c-4c5f-a628-8c501d830081', 'd0f1fd0a-deb0-4e16-8cde-0f6d631dff8a',
'aa2b9c9c-e01b-4521-b84c-a1a0b438423d') and activeflag =3;

update documentattachment
set activeflag =0, updatedby = 'CJAMS-66066', updatedon =now()
where documentpropertiesid in ('edc0a6dc-d707-4f27-b68e-5541b2644cda', '1a9af5ce-4e2b-44cc-bf51-1286af42f24c', 'a19527eb-8185-4432-ba11-4816a2c581af', '1fd68bca-80fe-434d-b16e-859e20e3f225', 
'a4a9f9bb-390b-437d-9fc5-3b3af634b0f8', '74198bff-7968-4ac6-ba20-3183641587c2', '63be9556-e8bb-4bbf-9e08-e2fe6add1872', 'f3af98ba-fc1f-4456-8799-0fe866533ea8',
'd5576a41-4515-46cd-af90-de3fb3712c7e', '8d706632-c5c6-4374-9ec2-251cf69f152c', '16d94ae6-00bd-4965-b471-b953dd81bf34', 'fcec409a-e9b5-48d0-821f-7dd2b650aa16',
'e84d98d7-df4a-4c38-b016-b44c0ae17e72', '6bb2a842-2c42-4e65-8bb8-c7442f5ebc66', '2c801ca3-72b2-4765-aace-0b80df0686ab', 'c43efbc2-6333-4329-bddb-3913c0237167',
'2756f10e-b32b-4341-b378-3e59df682dfb', '13f05c0b-0ce5-4d48-9e2d-7f224fe69578', '2947abe4-d9e8-4132-8567-5af4d9b7b330', '6c9484af-ba2a-4aa5-ad74-a0d058a5eade',
'5fff18df-d81c-4d35-9fbf-94172dd70bb6', 'e73222fa-18d1-42de-8400-3ab12c1ad5c0', 'ecc76843-a38c-4c5f-a628-8c501d830081', 'd0f1fd0a-deb0-4e16-8cde-0f6d631dff8a',
'aa2b9c9c-e01b-4521-b84c-a1a0b438423d') and activeflag =1;