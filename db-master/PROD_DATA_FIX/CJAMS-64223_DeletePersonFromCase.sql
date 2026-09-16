/*
Issue Description:CJAMS-64223
Category/Module: Person Card & Contact Notes
Root cause: User added wrong person to the person list and later added correct person. need cleanup to delete wrong person added to the case
Fix provided: Data fix to remove person from case and correct contact notes as requested.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data isue.
*/

-- 1. Remove the duplicate person card CJAMS PID: 204045862 from the person tab
update cjams.actor 
	set activeflag = 0, 
		updatedon = now(), 
		updatedby = 'CJAMS-64223'
	where actorid = 'dc6eb4a4-0117-4253-adff-31b2f42b3f3c' 
		and activeflag = 1;

update cjams.intakeservicerequestactor 
	set activeflag =0,
		updatedon = now(),
		updatedby = 'CJAMS-64223'
	where intakeservicerequestactorid in ('b576de54-26a6-4a89-b127-64b1d2e047dd',
										'ea0f9de5-93a2-4efd-b3aa-8f82450d3ea6',
										'4bc496d2-ca1e-46ae-8b4e-704e5eff192e') 
		and activeflag = 1;
		

/*
update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-64223'
	where intakeservicerequestactorid in ('b576de54-26a6-4a89-b127-64b1d2e047dd',
										'ea0f9de5-93a2-4efd-b3aa-8f82450d3ea6',
										'4bc496d2-ca1e-46ae-8b4e-704e5eff192e')
		and activeflag = 1;
*/

update cjams.personrole 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-64223'
	where personroleid  in ('c175a939-525b-4bd9-8e39-fe5b7bc017a2') 
		and activeflag = 1;


update cjams.personroletype 
	set activeflag =0,
		updatedon = now(),
		updatedby ='CJAMS-64223'
	where personroletypeid  in ('32757ed7-378b-43f2-abba-faf7dac4e1c1') 
		and activeflag = 1;
		

update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-64223'
	where personid = 'babd6394-3cc6-4fad-84cc-e584bc3a9b0c'
		and objectid = 'a558c546-ac3d-46cf-9370-6637ae0c493f'
		and activeflag = 1;
		
-- 2. Remove the duplicate client from Contact ID# 15573577 & 14688062		
UPDATE contactparticipant
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-64223'
	WHERE contactparticipantid IN ('93af16c8-935e-45f8-aaf7-93ede8694509', 'a8606d05-9a5b-4f8f-92a0-03ad07b7a0f1')
		and activeflag = 1;
		
-- 3. Replace the client name from ALICE JANE Ramos-Duplicate DO NOT USE (PID# 204045862) to Alice Ramos (PID# 1282895) on contact ID# 14688054
UPDATE contactparticipant
	set intakeservicerequestactorid = '6537d961-ea7e-4d57-a8e8-178b793a2a66',
		participantid = '6537d961-ea7e-4d57-a8e8-178b793a2a66',
		updatedon = now(),
		updatedby = 'CJAMS-64223'
	WHERE contactparticipantid IN ('0ccaaa49-a1b9-4184-a229-399f2cc644b2')
		and activeflag = 1;

		