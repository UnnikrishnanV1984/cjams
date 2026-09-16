/*
   Issue Description: CJAMS-60984 - Incorrectly added person in production instead of staging
	3148079:Accidentally created test person in production instead of staging. PID: 204188255.    Root cause: User Error. Wrong person addedd to case.
   Case#: 3148079 (servicecaseid: d1f20f51-4657-4eab-8037-87f1e68c9a16)
   Person to be deleted from case: 204188255 (856ae3a4-6d05-407e-9f1e-a246eac26a89)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Data fix to remove the approval request record.
*/


update person 
set activeflag = 0,
	updatedby = 'CJAMS-60984',
	updatedon = now()
where personid = '856ae3a4-6d05-407e-9f1e-a246eac26a89'
and activeflag = 1;
		
update cjams.intakeservicerequestactor  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-60984'
	where intakeservicerequestactorid = '8411832a-d4e8-4c0d-9301-e5c4e7059339'
		and activeflag = 1;

update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-60984'
	where actorid ='1c5aea0f-d4fc-4329-85b9-76ad6a1c3b26'
		and activeflag = 1;

update cjams.personrole 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-60984'
	where personroleid  = '76b026bb-fc1e-4d18-aeac-b4c7e90cb192'
		and activeflag = 1;

update cjams.personroletype 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-60984'
	where personroleid  = '76b026bb-fc1e-4d18-aeac-b4c7e90cb192'
		and activeflag = 1;

update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-60984'
	where intakeservicerequestactorid ='8411832a-d4e8-4c0d-9301-e5c4e7059339'
		and activeflag = 1;
		
/*
 * not needed because no personprogram area
 select objectid, programkey, *
	from cjams.personprogramarea
	where personid = '856ae3a4-6d05-407e-9f1e-a246eac26a89' 
		and objectid = 'd1f20f51-4657-4eab-8037-87f1e68c9a16'
		and activeflag = 1;
		
update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-60984'
	where personid = '856ae3a4-6d05-407e-9f1e-a246eac26a89' 
		and objectid = 'd1f20f51-4657-4eab-8037-87f1e68c9a16'
		and activeflag = 1;
		
*/