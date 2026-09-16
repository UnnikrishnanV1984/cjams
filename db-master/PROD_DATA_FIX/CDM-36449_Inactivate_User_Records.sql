/*
   Issue Description: CDM-36449
   Category/ Module  : WorkLoad 
   Root cause: Old Staff still shown on Workload list.
   Fix: Data fix to inactivate the team member records
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

select displayname, email, activeflag, * from userprofile where lower(email) in ('amanda.day1@maryland.gov',
'amanda.day_1@maryland.gov',
'charonne.randall@maryland.gov',
'elizabeth.saperstein@maryland.gov',
'emily.mills2@maryland.gov',
'emily.mills@maryland.gov',
'jim.coburn@maryland.md.state.com',
'jim.coburn@maryland.gov',
'kaitlynn.ballard1@maryland.gov',
'larissa.behuniak@maryland.gov',
'lauren.askew@maryland.gov',
'lauren.beam1@maryland.gov',
'lisaculp130@yahoo.com',
'lindsay.chen@maryland.gov',
'marcia.hill@maryland.gov',
'melinda.fields1@maryland.gov',
'noreen.startt@maryland.gov',
'patricia.mildner@maryland.gov',
'psalms.thomas@maryland.gov',
'rachel.young@maryland.gov',
'randolph.edison@maryland.gov',
'rebecca.longo@maryland.gov',
'tamira.robeson@maryland.gov',
'tina.young1@maryland.gov',
'tricia.dove@maryland.gov')
order by displayname;

/*
AmandaDay				amanda.day1@maryland.gov			0	c49d1cbc-e511-43ce-982a-4b27a1e4acbf
Amanda Day				amanda.day_1@maryland.gov			0	9f426529-9a43-4580-b219-b3568a0f4aa5
Charonne Randall		charonne.randall@maryland.gov		0	6ac24700-b9b6-4257-9f85-d1b22587204b
Elizabeth Saperstein	elizabeth.saperstein@maryland.gov	0	469bd58a-f6ff-468c-9436-89b0edb3bc14
EmilyMills				emily.mills@maryland.gov			0	bfddb141-6c2b-4e58-85d9-081230e3d67f
Emily Mills				emily.mills2@maryland.gov			0	7c58470b-e4b5-466e-80a9-99856fd9ca35
JamesCoburn				jim.coburn@maryland.gov				0	404370df-d3c7-438f-a735-680dd827c727
James Coburn			jim.coburn@maryland.md.state.com	0	3ab1faec-1827-4d41-95ef-8b7cf02a9d9a
Kaitlynn Ballard		kaitlynn.ballard1@maryland.gov		1	427749ab-acf7-47aa-9814-1ec3600b44c3
LarissaBehuniak			larissa.behuniak@maryland.gov		0	24373a8d-b21a-4005-9713-1d4277aa9a83
Lauren Askew			lauren.askew@maryland.gov			0	b82a4e37-90c7-439b-8b2d-7f85c7b2041c
LaurenBeam				lauren.beam1@maryland.gov			0	a394393d-3faf-4f10-a385-0b185377a2c1
Lindsay Chen			lindsay.chen@maryland.gov			0	1d7d71ca-c51a-4f30-a28b-f88939f9fe6d
LisaCulp				lisaculp130@yahoo.com				1	78908338-da83-4efc-ab22-10f0e199154a
Marcia Hill				marcia.hill@maryland.gov			1	ba247775-a493-4b76-b106-ab944ee46a11
MelindaFields			melinda.fields1@maryland.gov		0	ec133e07-215c-4561-b18f-e49a0d4adb69
Noreen Startt			noreen.startt@maryland.gov			0	f77ec916-5f49-4d41-97ef-b856dd98c135
PatriciaMildner			patricia.mildner@maryland.gov		0	949627de-3910-4b6a-8c6f-ae27d36ccfa7
PsalmsThomas			psalms.thomas@maryland.gov			1	deec3f77-54ac-4bbd-9b7a-25453ed07e25
RachelYoung				rachel.young@maryland.gov			0	54723614-524d-48fe-891a-38ec16afda5e
RandolphEdison			randolph.edison@maryland.gov		0	1bf29205-751c-49c1-9160-252bfa689907
RebeccaLongo			rebecca.longo@maryland.gov			0	71cb3c6e-5992-4887-a3de-db3e2ac15d70
Tamira Robeson			tamira.robeson@maryland.gov			0	8cadb377-f465-45a1-8c4f-c8f5b6ffe262
Tina Young				tina.young1@maryland.gov			0	d9c74af6-8797-4850-8ccf-c6b3fb1a1071
Tricia Dove				tricia.dove@maryland.gov			0	11da215d-d451-48e2-9b23-6ff586311557
*/

UPDATE userprofile 
	SET updatedon = now(),
		updatedby = 'CDM-36449',
		activeflag = 0
	WHERE securityusersid IN ('427749ab-acf7-47aa-9814-1ec3600b44c3', '78908338-da83-4efc-ab22-10f0e199154a', 
							'ba247775-a493-4b76-b106-ab944ee46a11','deec3f77-54ac-4bbd-9b7a-25453ed07e25')
		and activeflag = 1;
		
UPDATE muser 
	SET updatedon = now(),
		updatedby = 'CDM-36449',
		activeflag = 0
	WHERE securityusersid IN ('427749ab-acf7-47aa-9814-1ec3600b44c3', '78908338-da83-4efc-ab22-10f0e199154a', 
							'ba247775-a493-4b76-b106-ab944ee46a11','deec3f77-54ac-4bbd-9b7a-25453ed07e25')
		and activeflag = 1;
		
UPDATE rolemapping
	SET updatedon = now(),
		updatedby = 'CDM-36449',
		activeflag = 0
	WHERE principalid::integer IN (select id from muser 
										WHERE securityusersid IN ('427749ab-acf7-47aa-9814-1ec3600b44c3', '78908338-da83-4efc-ab22-10f0e199154a', 
																	'ba247775-a493-4b76-b106-ab944ee46a11','deec3f77-54ac-4bbd-9b7a-25453ed07e25'));
																	
UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-36449',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid in ('c49d1cbc-e511-43ce-982a-4b27a1e4acbf',
										'9f426529-9a43-4580-b219-b3568a0f4aa5',
										'6ac24700-b9b6-4257-9f85-d1b22587204b',
										'469bd58a-f6ff-468c-9436-89b0edb3bc14',
										'bfddb141-6c2b-4e58-85d9-081230e3d67f',
										'7c58470b-e4b5-466e-80a9-99856fd9ca35',
										'404370df-d3c7-438f-a735-680dd827c727',
										'3ab1faec-1827-4d41-95ef-8b7cf02a9d9a',
										'427749ab-acf7-47aa-9814-1ec3600b44c3',
										'24373a8d-b21a-4005-9713-1d4277aa9a83',
										'b82a4e37-90c7-439b-8b2d-7f85c7b2041c',
										'a394393d-3faf-4f10-a385-0b185377a2c1',
										'1d7d71ca-c51a-4f30-a28b-f88939f9fe6d',
										'78908338-da83-4efc-ab22-10f0e199154a',
										'ba247775-a493-4b76-b106-ab944ee46a11',
										'ec133e07-215c-4561-b18f-e49a0d4adb69',
										'f77ec916-5f49-4d41-97ef-b856dd98c135',
										'949627de-3910-4b6a-8c6f-ae27d36ccfa7',
										'deec3f77-54ac-4bbd-9b7a-25453ed07e25',
										'54723614-524d-48fe-891a-38ec16afda5e',
										'1bf29205-751c-49c1-9160-252bfa689907',
										'71cb3c6e-5992-4887-a3de-db3e2ac15d70',
										'8cadb377-f465-45a1-8c4f-c8f5b6ffe262',
										'd9c74af6-8797-4850-8ccf-c6b3fb1a1071',
										'11da215d-d451-48e2-9b23-6ff586311557'));
			
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-36449',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid in ('c49d1cbc-e511-43ce-982a-4b27a1e4acbf',
										'9f426529-9a43-4580-b219-b3568a0f4aa5',
										'6ac24700-b9b6-4257-9f85-d1b22587204b',
										'469bd58a-f6ff-468c-9436-89b0edb3bc14',
										'bfddb141-6c2b-4e58-85d9-081230e3d67f',
										'7c58470b-e4b5-466e-80a9-99856fd9ca35',
										'404370df-d3c7-438f-a735-680dd827c727',
										'3ab1faec-1827-4d41-95ef-8b7cf02a9d9a',
										'427749ab-acf7-47aa-9814-1ec3600b44c3',
										'24373a8d-b21a-4005-9713-1d4277aa9a83',
										'b82a4e37-90c7-439b-8b2d-7f85c7b2041c',
										'a394393d-3faf-4f10-a385-0b185377a2c1',
										'1d7d71ca-c51a-4f30-a28b-f88939f9fe6d',
										'78908338-da83-4efc-ab22-10f0e199154a',
										'ba247775-a493-4b76-b106-ab944ee46a11',
										'ec133e07-215c-4561-b18f-e49a0d4adb69',
										'f77ec916-5f49-4d41-97ef-b856dd98c135',
										'949627de-3910-4b6a-8c6f-ae27d36ccfa7',
										'deec3f77-54ac-4bbd-9b7a-25453ed07e25',
										'54723614-524d-48fe-891a-38ec16afda5e',
										'1bf29205-751c-49c1-9160-252bfa689907',
										'71cb3c6e-5992-4887-a3de-db3e2ac15d70',
										'8cadb377-f465-45a1-8c4f-c8f5b6ffe262',
										'd9c74af6-8797-4850-8ccf-c6b3fb1a1071',
										'11da215d-d451-48e2-9b23-6ff586311557'));																	
																	
	