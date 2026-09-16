/*
Issue Description:CJAMS-67971-Duplicate Client Entries
Category/Module: persons tab
Root cause: user has requested to remove the 
            clients, Emory R Paz (CJAMS PID# 204086200) and Remmy Paz (CJAMS PID# 201008574) from Persons, Contact note, MFIRA assessment, SAFE-C assessment, Reunification Permanency Plan, and Case Plan.
Fix provided: Data fix has been done to remove the clients, Emory R Paz (CJAMS PID# 204086200) and Remmy Paz (CJAMS PID# 201008574) 
              from Persons, Contact note, MFIRA assessment, SAFE-C assessment, Reunification Permanency Plan, and Case Plan.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update actor
set
    activeflag = 0,
    updatedby = 'CJAMS-67971',
    updatedon = now ()
where
    actorid in  ('c086317d-7032-469c-9bf9-2df63d086e4d','93073da2-97f3-4418-baa5-d385176761f6')
    and personid in ('2b9a4593-777b-470a-b94a-d7b980b0bd4a','8e5a206d-f8ae-4cfe-a2e0-91ae894f8175')
    and activeflag = 1;

update intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CJAMS-67971',
    updatedon = now ()
where
    intakeservicerequestactorid = '1af3729d-ba16-4475-9154-e0f4e413e9d6'
    and actorid = '93073da2-97f3-4418-baa5-d385176761f6'
    and activeflag = 1;

update personrole
set
    activeflag = 0,
    updatedby = 'CJAMS-67971',
    updatedon = now ()
where
    personroleid in ('40cb7d8a-ed68-47e0-871b-6ca4101ea902','c61c98f0-8f91-40b9-b325-0038a2bc22a6')
    and personid in ('2b9a4593-777b-470a-b94a-d7b980b0bd4a','8e5a206d-f8ae-4cfe-a2e0-91ae894f8175')
    and activeflag = 1;

update personroletype
set
    activeflag = 0,
    updatedby = 'CJAMS-67971',
    updatedon = now ()
where
    personroleid in  ('40cb7d8a-ed68-47e0-871b-6ca4101ea902','c61c98f0-8f91-40b9-b325-0038a2bc22a6')
    and personroletypeid in  ('beca8f95-ecf0-4b1c-a5e1-e4e481fd998d','93564713-6f9c-48e4-a8e5-7cd110d39f56')
    and activeflag = 1;

update actorrelationship
set
    activeflag = 0,
    updatedby = 'CJAMS-67971',
    updatedon = now ()
where
    intakeservicerequestactorid in ('b67de0f1-08e7-4ea3-b234-ae613e2a96ae','1af3729d-ba16-4475-9154-e0f4e413e9d6')
    and servicecaseid='e685c76d-26b5-42f5-a4c5-b954209ea7f6'
    and activeflag = 1;

update personprogramarea
set
    activeflag = 0,
    updatedby = 'CJAMS-67971',
    updatedon = now ()
where
    personid in ('8e5a206d-f8ae-4cfe-a2e0-91ae894f8175')
    and objectid='e685c76d-26b5-42f5-a4c5-b954209ea7f6'
    and activeflag = 1;

--contacts
update contactparticipant 
set activeflag=0,
updatedby='CJAMS-67971',updatedon=now()
where contactparticipantid='d56ff4b0-fb2a-4543-872b-0f89fba34adf' and activeflag=1;

update contactparticipant 
set intakeservicerequestactorid='6a664579-d899-44ff-9408-29d9a469e552',
updatedby='CJAMS-67971',updatedon=now()
where contactparticipantid='f762d88c-e31a-4a70-9acf-dac1c0dc7856' and activeflag=1;

update contactparticipant 
set intakeservicerequestactorid='ff2dda72-e7c1-4dd8-b6a4-9a25f95799af',
updatedby='CJAMS-67971',updatedon=now()
where contactparticipantid='7f88fca4-4de9-48b4-a359-da1370c7581a' and activeflag=1;

update contactparticipant 
set intakeservicerequestactorid='6a664579-d899-44ff-9408-29d9a469e552',
updatedby='CJAMS-67971',updatedon=now()
where contactparticipantid='097c87b2-d9ee-4dbd-a491-c65ce573f2e4' and activeflag=1;

update contactparticipant 
set intakeservicerequestactorid='6a664579-d899-44ff-9408-29d9a469e552',
updatedby='CJAMS-67971',updatedon=now()
where contactparticipantid='7c1f34e1-9462-404a-9fac-d27472f87864' and activeflag=1;

update contactparticipant 
set intakeservicerequestactorid='6a664579-d899-44ff-9408-29d9a469e552',
updatedby='CJAMS-67971',updatedon=now()
where contactparticipantid='9ebd3b3a-b0d1-477b-a6a3-54c0f89d8ff3' and activeflag=1;

update contactparticipant 
set intakeservicerequestactorid='6a664579-d899-44ff-9408-29d9a469e552',
updatedby='CJAMS-67971',updatedon=now()
where contactparticipantid='86c22568-3014-49a8-b04a-40039f52d859' and activeflag=1;

update contactparticipant 
set intakeservicerequestactorid='6a664579-d899-44ff-9408-29d9a469e552',
updatedby='CJAMS-67971',updatedon=now()
where contactparticipantid='129b694a-d34e-4bb7-89bf-5c3351442a85' and activeflag=1;

update contactparticipant 
set intakeservicerequestactorid='6a664579-d899-44ff-9408-29d9a469e552',
updatedby='CJAMS-67971',updatedon=now()
where contactparticipantid='8b8d6e91-2eb2-4bb4-8e80-8b6d702da1cd' and activeflag=1;

--- Permanency plan
update permanencyplan 
set intakeservicerequestactorid='ff2dda72-e7c1-4dd8-b6a4-9a25f95799af',
updatedby='CJAMS-67971',
updatedon=now()
where permanencyplanid='be355b0b-c899-4fea-b8b0-a107b626ce6a' and activeflag=1;

---MFIRA

UPDATE assessment
SET submissiondata = jsonb_set(
    submissiondata,
    '{familyHOUSEHOLD,familyArray}',
    (
        SELECT jsonb_agg(
            CASE 
                WHEN elem->>'personid' = '8e5a206d-f8ae-4cfe-a2e0-91ae894f8175'
                then '{"dob": "2022-06-28T04:00:00.000Z", "name": " Remmy NMN Paz ", "personid": "f9bffad3-a829-4a4a-a5dc-52a9e867ee71", "caregiver": "", "relationship": "Biological Child", "relationshiparray": [{"firstname": "ELI", "updatedon": "2023-09-19T15:47:45", "description": "Biological Father", "primaryuserid": "28a2c251-e060-4789-b1f7-fa52ff015724", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2023-09-19T15:47:45", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "28a2c251-e060-4789-b1f7-fa52ff015724"}, {"firstname": "SARAH", "updatedon": "2023-09-19T15:47:27", "description": "Boyfriend-Ex", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2023-09-19T15:47:27", "description": "Girlfriend-EX", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce"}, {"firstname": "jacobi", "updatedon": "2023-09-19T15:46:44", "description": "Biological Father", "primaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2023-09-19T15:45:41", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd"}, {"firstname": "EMORY", "updatedon": "2023-09-19T15:45:41", "description": "Biological Father", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2023-09-19T15:44:47", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "b356b835-fc07-4815-9f73-0372ea59f846"}, {"firstname": "MiLEY", "updatedon": "2023-09-19T15:44:47", "description": "Biological Father", "primaryuserid": "b356b835-fc07-4815-9f73-0372ea59f846", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "LEYLANI", "updatedon": "2023-09-19T15:44:06", "description": "Half Sister", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd"}, {"firstname": "EMORY", "updatedon": "2023-09-19T15:44:06", "description": "Half Sister", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7"}, {"firstname": "LEYLANI", "updatedon": "2023-09-19T15:39:57", "description": "Biological Mother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}, {"firstname": "SARAH", "updatedon": "2023-09-19T15:39:57", "description": "Biological Child", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7"}, {"firstname": "jacobi", "updatedon": "2023-09-19T15:39:31", "description": "Legal Sister", "primaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4", "secondaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7"}, {"firstname": "LEYLANI", "updatedon": "2023-09-19T15:39:30", "description": "Legal Brother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4"}, {"firstname": "LEYLANI", "updatedon": "2023-09-19T15:39:09", "description": "Half Sister", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "bb928408-d698-4b00-b9b2-8de229134822"}, {"firstname": "LEYLANI", "updatedon": "2023-09-19T15:38:55", "description": "Half Brother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "a4c663ae-688b-4c9e-84e6-1b7def3b0a5d"}, {"firstname": "Remmy", "updatedon": "2023-09-19T15:38:42", "description": "Half Sister", "primaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175", "secondaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7"}, {"firstname": "LEYLANI", "updatedon": "2023-09-19T15:38:42", "description": "Half Brother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175"}, {"firstname": "SARAH", "updatedon": "2023-09-19T15:15:33", "description": "Biological Child", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd"}, {"firstname": "jacobi", "updatedon": "2023-09-19T15:15:26", "description": "Biological Mother", "primaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}, {"firstname": "SARAH", "updatedon": "2023-09-19T15:15:26", "description": "Biological Child", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4"}, {"firstname": "Remmy", "updatedon": "2023-09-19T15:15:17", "description": "Biological Mother", "primaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}, {"firstname": "SARAH", "updatedon": "2023-09-19T15:15:17", "description": "Biological Child", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "f9bffad3-a829-4a4a-a5dc-52a9e867ee71"}, {"firstname": "SARAH", "updatedon": "2023-09-19T15:14:52", "description": "Boyfriend-Ex", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2023-09-19T15:14:51", "description": "Boyfriend-Ex", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}, {"firstname": "SARAH", "updatedon": "2023-09-19T15:10:28", "description": "Biological Child", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2023-09-19T15:10:28", "description": "Biological Mother", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}, {"firstname": "SARAH", "updatedon": "2023-09-19T15:10:19", "description": "Biological Child", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "b356b835-fc07-4815-9f73-0372ea59f846"}, {"firstname": "MiLEY", "updatedon": "2023-09-19T15:10:19", "description": "Biological Mother", "primaryuserid": "b356b835-fc07-4815-9f73-0372ea59f846", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}, {"firstname": "ELI", "updatedon": "2023-09-19T15:09:27", "description": "Biological Mother", "primaryuserid": "28a2c251-e060-4789-b1f7-fa52ff015724", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}, {"firstname": "SARAH", "updatedon": "2023-09-19T15:09:27", "description": "Biological Child", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "28a2c251-e060-4789-b1f7-fa52ff015724"}, {"firstname": "Remmy", "updatedon": "2023-07-13T10:00:09", "description": "Biological Brother", "primaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175", "secondaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4"}, {"firstname": "jacobi", "updatedon": "2023-07-13T10:00:09", "description": "Biological Brother", "primaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4", "secondaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175"}, {"firstname": "jacobi", "updatedon": "2023-07-13T09:59:57", "description": "Biological Sister", "primaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4", "secondaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd"}, {"firstname": "EMORY", "updatedon": "2023-07-13T09:59:56", "description": "Biological Brother", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4"}, {"firstname": "Remmy", "updatedon": "2023-07-13T09:59:48", "description": "Biological Sister", "primaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175", "secondaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd"}, {"firstname": "EMORY", "updatedon": "2023-07-13T09:59:48", "description": "Biological Brother", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175"}, {"firstname": "EMORY", "updatedon": "2023-07-13T09:59:30", "description": "Biological Sister", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "bb928408-d698-4b00-b9b2-8de229134822"}, {"firstname": "Remmy", "updatedon": "2023-07-13T09:59:22", "description": "Biological Sister", "primaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175", "secondaryuserid": "bb928408-d698-4b00-b9b2-8de229134822"}, {"firstname": "jacobi", "updatedon": "2023-07-13T09:59:15", "description": "Biological Sister", "primaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4", "secondaryuserid": "bb928408-d698-4b00-b9b2-8de229134822"}, {"firstname": "EMORY", "updatedon": "2023-07-13T09:58:51", "description": "Step Brother", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "a4c663ae-688b-4c9e-84e6-1b7def3b0a5d"}, {"firstname": "Remmy", "updatedon": "2023-07-13T09:58:39", "description": "Step Brother", "primaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175", "secondaryuserid": "a4c663ae-688b-4c9e-84e6-1b7def3b0a5d"}, {"firstname": "jacobi", "updatedon": "2023-07-13T09:58:32", "description": "Step Brother", "primaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4", "secondaryuserid": "a4c663ae-688b-4c9e-84e6-1b7def3b0a5d"}, {"firstname": "EMORY", "updatedon": "2023-07-13T09:58:08", "description": "Step Sister", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7"}, {"firstname": "LEYLANI", "updatedon": "2023-07-13T09:58:07", "description": "Step Sister", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd"}, {"firstname": "LEYLANI", "updatedon": "2023-07-13T09:57:59", "description": "Step Brother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175"}, {"firstname": "Remmy", "updatedon": "2023-07-13T09:57:59", "description": "Step Sister", "primaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175", "secondaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7"}, {"firstname": "jacobi", "updatedon": "2023-07-13T09:57:52", "description": "Step Sister", "primaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4", "secondaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7"}, {"firstname": "LEYLANI", "updatedon": "2023-07-13T09:57:51", "description": "Step Brother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4"}, {"firstname": "LEYLANI", "updatedon": "2023-07-13T09:57:44", "description": "Step Sister", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "bb928408-d698-4b00-b9b2-8de229134822"}, {"firstname": "LEYLANI", "updatedon": "2023-07-13T09:57:31", "description": "Step Brother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "a4c663ae-688b-4c9e-84e6-1b7def3b0a5d"}, {"firstname": "HENRY", "updatedon": "2023-07-13T09:56:59", "description": "Girlfriend", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce"}, {"firstname": "SARAH", "updatedon": "2023-07-13T09:56:59", "description": "Boyfriend", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "LEYLANI", "updatedon": "2023-07-13T09:56:49", "description": "Step Father", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2023-07-13T09:56:49", "description": "Step Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7"}, {"firstname": "Remmy", "updatedon": "2023-07-03T13:54:22", "description": "Biological Father", "primaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2023-07-03T13:54:22", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175"}, {"firstname": "HENRY", "updatedon": "2023-07-03T13:54:15", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4"}, {"firstname": "HENRY", "updatedon": "2023-07-03T13:54:08", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "bb928408-d698-4b00-b9b2-8de229134822"}, {"firstname": "HENRY", "updatedon": "2023-07-03T13:54:01", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "a4c663ae-688b-4c9e-84e6-1b7def3b0a5d"}, {"firstname": "SARAH", "updatedon": "2023-05-30T11:49:04", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7"}, {"firstname": "SARAH", "updatedon": "2023-05-30T11:48:40", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "bb928408-d698-4b00-b9b2-8de229134822"}, {"firstname": "SARAH", "updatedon": "2023-05-30T11:48:32", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd"}, {"firstname": "SARAH", "updatedon": "2023-05-30T11:48:23", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175"}, {"firstname": "Remmy", "updatedon": "2023-05-30T11:48:23", "description": "Biological Mother", "primaryuserid": "8e5a206d-f8ae-4cfe-a2e0-91ae894f8175", "secondaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce"}, {"firstname": "SARAH", "updatedon": "2023-05-30T11:48:03", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4"}, {"firstname": "jacobi", "updatedon": "2023-05-30T11:48:02", "description": "Biological Mother", "primaryuserid": "fff909e3-3518-455d-96f5-8ad5d7c18db4", "secondaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce"}, {"firstname": "HENRY", "updatedon": "2023-05-15T08:01:00", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "13c9d1f0-74c3-4c45-8569-2fa5b4fdb97c"}, {"firstname": "SARAH", "updatedon": "2023-05-15T08:00:53", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "13c9d1f0-74c3-4c45-8569-2fa5b4fdb97c"}, {"firstname": "EMORY", "updatedon": "2023-05-15T08:00:42", "description": "Biological Mother", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "13c9d1f0-74c3-4c45-8569-2fa5b4fdb97c"}, {"firstname": "LEYLANI", "updatedon": "2023-05-15T08:00:31", "description": "Biological Mother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "13c9d1f0-74c3-4c45-8569-2fa5b4fdb97c"}, {"firstname": "SARAH", "updatedon": "2023-01-10T16:48:30", "description": "Boyfriend", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2023-01-10T16:48:30", "description": "Girlfriend", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}, {"firstname": "SARAH", "updatedon": "2022-05-26T14:49:04", "description": "Husband", "primaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "HENRY", "updatedon": "2022-05-26T14:49:04", "description": "Wife", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}, {"firstname": "HENRY", "updatedon": "2021-06-04T17:54:47", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce"}, {"firstname": "SARAH", "updatedon": "2021-06-04T17:54:46", "description": "Biological Father", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03"}, {"firstname": "MiLEY", "updatedon": "2021-06-04T17:53:57", "description": "Biological Mother", "primaryuserid": "b356b835-fc07-4815-9f73-0372ea59f846", "secondaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce"}, {"firstname": "SARAH", "updatedon": "2021-06-04T17:53:57", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "b356b835-fc07-4815-9f73-0372ea59f846"}, {"firstname": "SARAH", "updatedon": "2021-06-04T17:53:42", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "28a2c251-e060-4789-b1f7-fa52ff015724"}, {"firstname": "ELI", "updatedon": "2021-06-04T17:53:42", "description": "Biological Mother", "primaryuserid": "28a2c251-e060-4789-b1f7-fa52ff015724", "secondaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce"}, {"firstname": "EMORY", "updatedon": "2021-06-04T17:53:32", "description": "Biological Mother", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce"}, {"firstname": "HENRY", "updatedon": "2019-09-20T20:53:14", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "ecfbd590-aa30-407c-8b39-bdfc815b7ecc"}, {"firstname": "HENRY", "updatedon": "2019-09-20T20:51:47", "description": "Biological Child", "primaryuserid": "d6c8de05-0225-45f9-8266-e68808329a03", "secondaryuserid": "868537b6-be5c-46ff-9ad5-904e8a085d76"}, {"firstname": "LEYLANI", "updatedon": "2019-09-20T20:48:12", "description": "Biological Sister", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "ecfbd590-aa30-407c-8b39-bdfc815b7ecc"}, {"firstname": "LEYLANI", "updatedon": "2019-09-20T20:48:12", "description": "Biological Brother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "868537b6-be5c-46ff-9ad5-904e8a085d76"}, {"firstname": "LEYLANI", "updatedon": "2019-09-20T20:48:12", "description": "Biological Brother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "a4c663ae-688b-4c9e-84e6-1b7def3b0a5d"}, {"firstname": "SARAH", "updatedon": "2019-09-20T20:46:40", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "a4c663ae-688b-4c9e-84e6-1b7def3b0a5d"}, {"firstname": "SARAH", "updatedon": "2019-09-20T20:46:40", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "868537b6-be5c-46ff-9ad5-904e8a085d76"}, {"firstname": "LEYLANI", "updatedon": "2019-09-20T20:43:09", "description": "Biological Mother", "primaryuserid": "670fd703-e0bb-4e8e-abe8-1b65639cd1b7", "secondaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce"}, {"firstname": "SARAH", "updatedon": "2019-09-20T20:43:09", "description": "Biological Child", "primaryuserid": "0e46b675-9b80-4102-8aab-7b4ea43c88ce", "secondaryuserid": "ecfbd590-aa30-407c-8b39-bdfc815b7ecc"}, {"firstname": "EMORY", "updatedon": "2018-07-03T10:36:33", "description": "Biological Mother", "primaryuserid": "fd7bcb4d-9696-40b0-9bdc-d40c65e0eacd", "secondaryuserid": "8066ad36-c405-4cbd-9a31-468362aff893"}], "intakeservicerequestactorid": "1af3729d-ba16-4475-9154-e0f4e413e9d6"}'
                ELSE elem
            END
        )
        FROM jsonb_array_elements(submissiondata->'familyHOUSEHOLD'->'familyArray') AS elem
    )
),
Updatedby='8d192f5a-28fa-4a57-8c27-345e61ceb8f7',  -- we are showing updatedby column on UI to display name 
updatedon=now()
WHERE assessmentid = '91554e66-31f2-40e3-a039-b36efe922ade';

--sAFEC 

UPDATE assessment
SET submissiondata = jsonb_set(
    submissiondata,
    '{all_childs_json}',
    (
        SELECT jsonb_agg(
            CASE 
                WHEN elem->>'cjamspid' = '201008574' THEN elem || '{"name":"Remmy NMN Paz", "cjamspid": "204086210"}'
                ELSE elem
            END
        )
        FROM jsonb_array_elements(submissiondata->'all_childs_json') AS elem
    )
),
updatedby='8d192f5a-28fa-4a57-8c27-345e61ceb8f7',
updatedon=now()
WHERE assessmentid='b70a1ee0-9525-40c1-a9ac-5fdf69cca977';


UPDATE assessment
SET submissiondata = jsonb_set(
    submissiondata,
    '{childdatagrid}',
    (
        SELECT jsonb_agg(
            CASE 
                WHEN elem->>'clientid' = '201008574' THEN elem || '{"childname":"Remmy NMN Paz", "clientid": "204086210"}'
                ELSE elem
            END
        )
        FROM jsonb_array_elements(submissiondata->'childdatagrid') AS elem
    )
),
updatedby='8d192f5a-28fa-4a57-8c27-345e61ceb8f7',
updatedon=now()
WHERE assessmentid='b70a1ee0-9525-40c1-a9ac-5fdf69cca977';

-- Removing duplicate person  in Who is the subject of the contact?
update progressnote
set focusperson = '{
  "focuspersonjson": [
    {
      "participanttypekey":"IP",
         "intakeservicerequestactorid":"860526fd-9b28-4252-af69-e56eead4efb7",
         "participantid":"860526fd-9b28-4252-af69-e56eead4efb7",
         "firstname":"Remmy",
         "lastname":"Paz",
         "address1":null,
         "address2":null,
         "city":null,
         "state":null,
         "zipcode":null,
         "email":null,
         "phonenumber":null
    },
    {
      "participanttypekey":"IP",
         "intakeservicerequestactorid":"9fc5f9c3-e625-499e-92af-9eec2a258d1d",
         "participantid":"9fc5f9c3-e625-499e-92af-9eec2a258d1d",
         "firstname":"Jovie",
         "lastname":"Paz",
         "address1":null,
         "address2":null,
         "city":null,
         "state":null,
         "zipcode":null,
         "email":null,
         "phonenumber":null
  
    }
  ]
}',
updatedby ='CJAMS-67971',
updatedon =now()
WHERE progressnoteid = 'a08f816d-5427-4fad-83cc-de57b919c9b3';

update progressnote
set focusperson = '{
  "focuspersonjson": [
    {
      "participanttypekey":"IP",
            "intakeservicerequestactorid":"860526fd-9b28-4252-af69-e56eead4efb7",
            "participantid":"860526fd-9b28-4252-af69-e56eead4efb7",
            "firstname":"Remmy",
            "lastname":"Paz",
            "address1":null,
            "address2":null,
            "city":null,
            "state":null,
            "zipcode":null,
            "email":null,
            "phonenumber":null
    },
    {
      "participanttypekey":"IP",
            "intakeservicerequestactorid":"9fc5f9c3-e625-499e-92af-9eec2a258d1d",
            "participantid":"9fc5f9c3-e625-499e-92af-9eec2a258d1d",
            "firstname":"Jovie",
            "lastname":"Paz",
            "address1":null,
            "address2":null,
            "city":null,
            "state":null,
            "zipcode":null,
            "email":null,
            "phonenumber":null
  
    }
  ]
}',
updatedby ='CJAMS-67971',
updatedon =now()
WHERE progressnoteid = 'ff0c3c8b-e0d8-414f-88ee-73e369c85231';