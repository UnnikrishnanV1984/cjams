/*
Issue:
251023032208:This case was closed timely and keeps coming up on the backlog list.
Root Cause:The same referral was entered into the system twice by mistake, creating two records for one inatke, this casused confusion and duplicates infomation in the case records.
Fix Provided (Data Fix Only):we fixed the issue by marking the duplciates records as inactive so they wont't show up of affet the case anymore.
Removed the dummy case 251023032208 and its associated records from:intakeservicerequest,etc.
Inserted a new routing record with corrected closure status and proper metadata for intake I251013261422.
Data/Code fix ticket#: CJAMS-60337
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data-only issue; no logic/code changes required.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
--updated intakeservicerequest
update
	intakeservicerequest
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	servicerequestnumber in ('251023032208')
	and activeflag = 1;
--updated intakeservicerequestactor
update
	intakeservicerequestactor
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	intakeservicerequestactorid in ('bdf69ba9-367c-49d6-9904-06331371177b',
	'35b76b29-8802-47a1-85f9-8ad76615f0d4')
	and activeflag = 1;

--updated actor

update
	actor
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	actorid in ('7000bcad-08f5-4e61-9809-fc1215f0acff')
	and activeflag = 1;


--updated intakeservrequestsdmmaltreatment
update
	intakeservrequestsdmmaltreatment
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	intakeservicerequestsdmid in (
		select intakeservicerequestsdmid
	from
		intakeservicerequestsdm
	where
		intakeserviceid in ('e4195523-52e7-453a-a535-594200b8d2df')
		and activeflag = 1)
	and activeflag = 1;

--updated intakeservicerequestsdm
update
	intakeservicerequestsdm
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	intakeserviceid in ('e4195523-52e7-453a-a535-594200b8d2df')
	and activeflag = 1;


--updated personprogramarea
update
	personprogramarea
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	personprogramid = '06d093d4-5ed5-483a-9142-2f94e6026a8b'
	and activeflag = 1;
	


update
	intakeservicerequestdispositioncode
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	intakeserviceid in ('e4195523-52e7-453a-a535-594200b8d2df')
	and activeflag = 1;
	


update
	personrole 
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	personroleid  in ('9a2e4f1d-28ea-4632-baa9-e21ff4c8cbba','84398766-19eb-4605-8df1-ad41264aee14','ffcaeb74-ba6f-4516-b12c-7e898e4c50d3')
	and activeflag = 1;
	


update
	actorrelationship
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	actorrelationshipid  in ('2f242ff1-4c4d-4b63-a3a4-88e852c4872b')
	and activeflag = 1;
	


update
	personroletype 
set
	activeflag = 0,
	updatedby = 'CJAMS-60337',
	updatedon = now()
where
	personroletypeid  in ('87094514-8c7c-43b7-958c-3092dc95008a',
'60aef15a-bb6b-43d9-8193-89122b1a9d82',
'079c160f-2688-4d02-8d0e-8468e529e275',
'59dc29a4-a8bc-496b-8826-2a7ea5878bb6',
'cb311323-1b5d-4f71-b8df-a71244b17768',
'c8e11168-5a1e-4780-a36a-957aca78368e')
	and activeflag = 1;
