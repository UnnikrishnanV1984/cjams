/*
   Issue Description: CDM-22188
   Category/ Module  : Prod data fix to the removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




-- fix for 3rd issue
update intakeservreqchildremoval set exitdate = '2022-03-01 00:00:00',removalexitreason = 'ADNRE' , updatedby = 'CDM-22188' , updatedon = now()
where intakeservreqchildremovalid = '46963067-7ebd-467c-b96f-8a4e499a0bc0';

update tb_client_eligibility set end_dt = '2022-03-01' , update_ts = now() , update_user_id = 'CDM-22188' 
where removal_id = '253619';

update personprogramarea set enddate = '2022-03-01 00:00:00', updatedby = 'CDM-22188' , updatedon = now() 
where personprogramid = '972022be-b16a-43f0-ad4d-fe63643e621c';



-- fix for 4 issue
UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2022-12-19 00:00:00', 
updatedby = 'CDM-22188',updatedon = now() WHERE servicecaseid = '60c27562-b179-40b8-81d6-a81ccae0b46a';

INSERT INTO servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('1cb2867c-2644-4085-a38e-e01d1bb59e32', '60c27562-b179-40b8-81d6-a81ccae0b46a', '2022-12-19 00:00:00', 'Closed', 'Closed','Closing the case that is wrongly reopened.', 
	   '2022-12-19 12:00:00', 1, 'acfcbf74-6677-4175-8ed9-295b8196374b',now(),'CDM-19606',now()) ON CONFLICT DO NOTHING;

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR','5b366c60-e112-4b90-95c5-e6457c11f2d9','77c1d20d-c76d-4106-ab99-e751bafff384', '1cb2867c-2644-4085-a38e-e01d1bb59e32', 16, 1, 'CDM-19606',now(),'CDM-19606', now()) ON CONFLICT DO NOTHING;


-- fix for 11 and 12 issues
UPDATE cjams.progressnote
SET activeflag=0, updatedon=now(), updatedby = 'CDM-22188'
WHERE progressnoteid in (
'7ed4eba5-3c41-4607-ac5c-fe1891c78faf',
'37a2ec0c-aa6d-4137-9592-aaf9c93c09c7',
'68990777-e9f1-4faf-976e-021ba0aa4753',
'4afca0c1-5161-42b5-afd0-91d6d04f7fbc',
'80c7958b-d4bc-4467-8059-7f81ac77a933',
'265b99c7-bb87-4fdd-afea-cbf6eee8e7d5',
'bb03a0a8-7550-4ff5-a4e1-bc17640d450c',
'49cf2df4-d4a0-4cd4-aa71-553058d7be4e',
'4b3fadd5-622d-4e7d-9718-c3d8ebc6644f',
'1cc194a1-0afd-4d38-a44b-c23a14b3fbff',
'c2cf1aa1-d97a-4697-818d-2ebe77c12c5c',
'50b14296-5156-4cfe-9a56-8bd9d1b4b375',
'01ccbf97-06e9-4bc5-a755-8dcbcc585255', 
'eb6fcfb2-88bf-4208-9a78-661571ecef21',
'c5522999-1127-4a58-9500-b86610f0a131',
'aa40a4b2-f2f8-4e6c-8c58-f277a7c95b30',
'cf8388bd-5d4d-483a-86df-aeb7b3db81a9', 
'386f3db4-6791-4bb1-a493-0b42f3ac4dcf',
'4285fdf1-1904-43f5-9dc9-e2a229de19a1',
'581f89be-c986-4569-9eab-97253e4278ff',
'7375f156-17f6-4061-b628-eade63536e71',
'2a8b3bb0-b6f3-4982-85b8-e173c9356e4b',
'a4189c83-90f8-4289-8249-e86749effacb',
'0cc1304b-fb68-4ce9-9305-dea0d454c239',
'3326910b-11fc-4303-b7e9-92724d1bca3c'
) and activeflag = 1;


-- fix for 13
update assessment set activeflag = 0, updatedby = 'CDM-22188', updatedon = now()
where assessmentid in ('ca59cfac-dcc0-4606-ac4c-2019db028c7d','de24db20-8fee-47d2-a596-c37c6ecb1d3a') and activeflag = 1;

-- fix for 15
update documentproperties set activeflag=0 , updatedby = 'CDM-22188', updatedon = now()
where documentpropertiesid = '8c79413f-6c9e-4f2f-ae27-c1611e2d3d5c' and activeflag=1;


