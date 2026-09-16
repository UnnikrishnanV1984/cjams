
/*
Issue Description:Urgent - duplicate case in CJAMS
Category/Module: Error
Root cause: Issue has occured due to slowness, dupliacte case has been created
Fix provided: Data fix is done to 
 delete the case number 261023622491
Connect the Intake I261013890787 with CPS AR # 261023622494
Data/Code fix ticket#: CJAMS-67915
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--updated intakeservicerequest
update
	intakeservicerequest
set
	activeflag = 0,
	updatedby = 'CJAMS-67915',
	updatedon = now()
where
	servicerequestnumber in ('261023622491')
	and activeflag = 1;

--updated intakeservicerequestactor
update
	intakeservicerequestactor
set
	activeflag = 0,
	updatedby = 'CJAMS-67915',
	updatedon = now()
where
	intakeservicerequestactorid in ('66d3abff-9831-4900-ae2b-b05620458d7d','9722922e-64b7-4115-a488-27d758b0984c','bc80e13e-a621-4c2d-88d4-ee2998249071',
	'5db624b6-55b3-4f74-b3fd-646115ce5328','25776036-d6ad-4651-ac05-5140f2d5d2a2','6e62be6b-9784-4992-ad70-c0ab38d091eb','0a5ccfcd-8e6c-4f2a-838d-9e55f082840c')
	and activeflag = 1;

--updated actor

update
	actor
set
	activeflag = 0,
	updatedby = 'CJAMS-67915',
	updatedon = now()
where
	actorid in ('a430e68d-201b-4e07-a2d7-aa75187d1a94','4b0f0a10-594f-4f69-aa75-34333dbabbdd','b3954ab0-cc47-4c05-ba50-f9a582f01aa5')
	and activeflag = 1;


--updated intakeservrequestsdmmaltreatment
update
	intakeservrequestsdmmaltreatment
set
	activeflag = 0,
	updatedby = 'CJAMS-67915',
	updatedon = now()
where
	intakeservicerequestsdmid in (
		select intakeservicerequestsdmid
	from
		intakeservicerequestsdm
	where intakeserviceid in('ca285d05-d1be-4775-86f7-d065997275e4')and activeflag = 1)
	and activeflag = 1;

--updated intakeservicerequestsdm
update
	intakeservicerequestsdm
set
	activeflag = 0,
	updatedby = 'CJAMS-67915',
	updatedon = now()
where
	intakeserviceid in('ca285d05-d1be-4775-86f7-d065997275e4')
	and activeflag = 1;



	
update
	intakeservicerequestdispositioncode
set
	activeflag = 0,
	updatedby = 'CJAMS-67915',
	updatedon = now()
where
	intakeserviceid in ('ca285d05-d1be-4775-86f7-d065997275e4')
	and activeflag = 1;
	


update
	personrole 
set
	activeflag = 0,
	updatedby = 'CJAMS-67915',
	updatedon = now()
where
	personroleid  in ('b50cf976-2c65-470b-8e7c-3e97ac9c44fb','fdf35036-06ae-455a-996e-298b6aebb0b7','519f8bee-96a7-44e0-b5e1-5be190484958')
	and activeflag = 1;
	


update
	actorrelationship
set
	activeflag = 0,
	updatedby = 'CJAMS-67915',
	updatedon = now()
where
	actorrelationshipid  in ('5b9c762b-2af8-4b7f-93a0-011b65462cd1','2f73e9e4-9c3a-43ec-91d0-87fbd0fa7679','b375b884-c23c-4b90-8ff4-fc9057717161',
	'8a1930ba-5253-45de-9687-f080f4d3ea11','699d10a8-d42a-4c6b-960e-58e89dee6e42','569b68d7-dd4e-47e8-bec5-3b0009495687','78d7668e-36c5-4d96-98fe-2668cacfde7d','c7d88e56-4bdb-4198-999e-02cc453c3c4a',
	'eae659e3-2982-49a1-a512-8783204dc411','b9f485e4-c15d-4a1e-bcad-0e1165805e2c')
	and activeflag = 1;
	


update
	personroletype 
set
	activeflag = 0,
	updatedby = 'CJAMS-67915',
	updatedon = now()
where
	personroleid  in ('b50cf976-2c65-470b-8e7c-3e97ac9c44fb','fdf35036-06ae-455a-996e-298b6aebb0b7','519f8bee-96a7-44e0-b5e1-5be190484958')
	and activeflag = 1;



