
/*
   Issue Description: CDM-14485
   Category/ Module  : Removing permanency plan history
   Root cause: Unable to approve Permanency Plan - user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup Scripts: personid: '0d5257a5-dbd8-4f06-b5da-ff93f10ee43d', '1c77e40c-9daa-4508-bcfd-48dce0bcfbe7'
	INSERT INTO cjams.permanencyplanhistory
		(permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby)
		VALUES('062aada8-133c-43bb-91e0-d69f0386cc4b'::uuid, '65448747-e6bc-4128-a158-62bb1a21ec70'::uuid, '0e2db511-d83e-4820-88fe-f5dc22b1ed9f'::uuid, NULL, '6e265ae2-f194-4fa5-beeb-884d71e1c7ae'::uuid, '36f8544c-7f4f-4acb-a59b-6cce27f6e028'::uuid, '2021-05-20 00:00:00.000', '2021-05-20 04:00:00.000', NULL, 'HannahKeller', 'Review', '2021-06-17 08:52:13.562', 'c159ea1c-c65c-472a-a5c7-721e9f86777c', '2021-06-17 08:52:13.562', 'c159ea1c-c65c-472a-a5c7-721e9f86777c');
	INSERT INTO cjams.permanencyplanhistory
		(permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby)
		VALUES('a437502a-8be7-41c5-8e42-70ce740d42b1'::uuid, '65448747-e6bc-4128-a158-62bb1a21ec70'::uuid, '0e2db511-d83e-4820-88fe-f5dc22b1ed9f'::uuid, NULL, '6e265ae2-f194-4fa5-beeb-884d71e1c7ae'::uuid, '36f8544c-7f4f-4acb-a59b-6cce27f6e028'::uuid, '2021-05-20 00:00:00.000', '2021-05-20 04:00:00.000', NULL, 'HannahKeller', 'Approved', '2021-06-17 10:02:18.721', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2021-06-17 10:02:18.721', '262f71d0-64d5-4eaf-bd7a-b0901803706c');
	INSERT INTO cjams.permanencyplanhistory
		(permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby)
		VALUES('66fda2f3-4c17-4a10-8f1a-cc071a27fa3b'::uuid, '8da7ac18-3368-4f39-8226-a650bcaa9156'::uuid, '50af4487-3d6d-4aec-8686-d2bd77e2bb9d'::uuid, NULL, '6e265ae2-f194-4fa5-beeb-884d71e1c7ae'::uuid, 'de17eb2f-4ed9-48bc-a2f2-606de4ab9b1b'::uuid, '2021-05-20 08:00:00.000', '2021-05-20 08:00:00.000', NULL, 'KarenStansberry', 'Review', '2021-09-29 11:48:56.042', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2021-09-29 11:48:56.042', '262f71d0-64d5-4eaf-bd7a-b0901803706c');

   
*/


delete from cjams.permanencyplanhistory 
where permanencyplanid='65448747-e6bc-4128-a158-62bb1a21ec70' 
and  permanencyplanhistoryid in ('062aada8-133c-43bb-91e0-d69f0386cc4b', 'a437502a-8be7-41c5-8e42-70ce740d42b1');

delete from cjams.permanencyplanhistory 
where permanencyplanid='8da7ac18-3368-4f39-8226-a650bcaa9156' 
and  permanencyplanhistoryid in ('66fda2f3-4c17-4a10-8f1a-cc071a27fa3b');
