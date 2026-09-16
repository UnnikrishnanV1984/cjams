/*
   Issue Description: CJAMS-64597 - Data fix
   Root cause: User Error. Wrong person added to the case.
   Case#: 251030580447 (servicecaseid: 79e4fe05-387a-4d2e-ad07-dcb16c1b0135)
   Person to be deleted from case: 251030580447 (79e4fe05-387a-4d2e-ad07-dcb16c1b0135)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Need to do data fix: Data fix to remove the person 
   Persons to be deleted:
   CJAMS ID		personid								NAME					    intakeservicerequestactorid
   204569336	e0cedd6a-f34c-40bf-bd1a-8bbb3f145c01	Kevin B Unger				f6784069-be33-45c5-bf85-3a6eefd73fa6
*/
update cjams.intakeservicerequestactor  
	set activeflag = 0,	updatedon = now(),	updatedby = 'CJAMS-64597'
	where intakeservicerequestactorid IN ( 'f6784069-be33-45c5-bf85-3a6eefd73fa6')
		and activeflag = 1;	

update cjams.actor 
	set activeflag = 0,	updatedon = now(),	updatedby = 'CJAMS-64597'
	where actorid IN ('05fa868f-9159-4314-a88a-e04c74f4a040')
		and activeflag = 1;

update cjams.personrole 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-64597'
	where personroleid  IN ('022cfd74-bf31-43c2-8e0e-54435f6e5cd2')
		and activeflag = 1;

update cjams.personroletype 
	set activeflag = 0,	updatedon = now(),	updatedby = 'CJAMS-64597'
	where personroleid  IN ('022cfd74-bf31-43c2-8e0e-54435f6e5cd2')
		and activeflag = 1;

update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-64597'
	where intakeservicerequestactorid IN ('f6784069-be33-45c5-bf85-3a6eefd73fa6')
		and activeflag = 1;
			
update cjams.personprogramarea 
	set activeflag = 0,	updatedon = now(),	updatedby = 'CJAMS-64597'
	where personid IN ('e0cedd6a-f34c-40bf-bd1a-8bbb3f145c01')
		and objectid = '79e4fe05-387a-4d2e-ad07-dcb16c1b0135'
		and activeflag = 1;


UPDATE progressnote
	set focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"99ca6a1d-ca7d-47bf-8edf-9c2425ae67dd","participantid":"99ca6a1d-ca7d-47bf-8edf-9c2425ae67dd","firstname":"Ashley","lastname":"Chevalier","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"9177bf70-abf8-49d1-9302-28ae72b6fb72","participantid":"9177bf70-abf8-49d1-9302-28ae72b6fb72","firstname":"Liam","lastname":"Chevalier","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
		updatedon = now(),
		updatedby = 'CJAMS-64597'
	WHERE progressnoteid = '3bbe6696-1100-414f-a354-011c76d70747';

UPDATE progressnote
	set otherpersonName = null,	updatedon = now(), updatedby = 'CJAMS-64597'
	WHERE progressnoteid = '8f27301c-4dbd-474f-9841-f707776f8e58';