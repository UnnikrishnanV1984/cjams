-- CDM-31574 - Modify CPS finding
/*
-- Issue Description: 
    User request to add the appeal coordinator case assignment to joann.gochnour@maryland.gov

-- CPS-IR: CW2829191 - 088888c8-eef9-4e80-8182-d1e4b8f78961
   
-- Category/ Module: CPS-IR (Investigation Management) 
-- Root cause: Migrated CPS-IR case which is beyond the standard 120 days appeal period.
-- Fix Provided: Datafix has been promoted to add the appeal coordinator case assignment.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR: CW2829191 - 088888c8-eef9-4e80-8182-d1e4b8f78961

-- To add the appeal coordinator case assignment (CDM-31574)

-- From Holly Naff - 8c27171c-3dc5-4b93-8d18-52b63c489075 - Team: 761524bf-710d-4f07-96b9-eb4e96ff724b
-- To joann.gochnour@maryland.gov - ba8e461b-eeb7-4266-aea0-cc8766b6ca8c - Joann Gochnour 
-- Team: b7223287-d702-4b9c-b2c1-9c303b6295bb
INSERT INTO cjams.caseassignment
	(	caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, 
		toworkeridno, tosupervisoridno, toofficecode, caseassigncode, 
		effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, 
		insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, 
		responsibilitytypekey, activeflag, startdate, enddate, 
		fromteamid, toteamid, 
		remarks, statustypekey, fromldssid, toldssid, 
		assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, 
		isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype
		)
VALUES
	(	cjams.gen_random_uuid(), cjams.gen_random_uuid(), NULL, '8c27171c-3dc5-4b93-8d18-52b63c489075', NULL, NULL, 
		'ba8e461b-eeb7-4266-aea0-cc8766b6ca8c', NULL, NULL, NULL, 
		now(), now(), NULL, NULL, NULL, NULL, NULL, 
		'CDM-31574', 'CDM-31574', now(), now(), 'servicerequest', '088888c8-eef9-4e80-8182-d1e4b8f78961', 
		NULL, 1, now(), NULL, 
		'761524bf-710d-4f07-96b9-eb4e96ff724b', 'b7223287-d702-4b9c-b2c1-9c303b6295bb', 
		NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 
		'W', NULL, now(), NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'APPL', '8c27171c-3dc5-4b93-8d18-52b63c489075', 'ba8e461b-eeb7-4266-aea0-cc8766b6ca8c', 
		'761524bf-710d-4f07-96b9-eb4e96ff724b', 'CWSP', 'CWSP', '088888c8-eef9-4e80-8182-d1e4b8f78961', 
		15, 1, 'CDM-31574', now(), 'CDM-31574', now(), 
		true, '', NULL, 'Appeal Review', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);


-- intakeserreqstatustypeid
-- Old 642f18b0-ef6e-4d4b-9871-acc0734f3f5a - Closed
-- New 7995cecb-062d-406c-8ea9-b1da4b1877d8 - Completed

-- servicerequesttypeconfigiddispostionid
-- Old d69ef21e-dce1-4cd4-bda3-76255fc92db3 Completed
-- New d90db0d3-f665-49db-b3ad-0edb468bc02d	Recommend for closure

-- description as 'Completed'
select intakeserreqstatustypeid, description, servicerequesttypeconfigiddispostionid, updatedby, updatedon 
from intakeservicerequestdispositioncode 
where intakeserviceid = '088888c8-eef9-4e80-8182-d1e4b8f78961'
	and activeflag  = 1 ;

update intakeservicerequestdispositioncode 
set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', -- Completed
	description = 'Completed',
	servicerequesttypeconfigiddispostionid = 'd90db0d3-f665-49db-b3ad-0edb468bc02d', -- Recommend for closure
	updatedby = 'CDM-31574', 
	updatedon = now()
where intakeserviceid = '088888c8-eef9-4e80-8182-d1e4b8f78961'
	and activeflag  = 1 ;


-- intakeserreqstatustypeid
-- Old 642f18b0-ef6e-4d4b-9871-acc0734f3f5a - Closed
-- New 7995cecb-062d-406c-8ea9-b1da4b1877d8 - Completed
select intakeserreqstatustypeid, updatedby, updatedon 
from intakeservicerequest 
where intakeserviceid = '088888c8-eef9-4e80-8182-d1e4b8f78961'
	and activeflag = 1;
	
update intakeservicerequest 
set	intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', -- Completed
	updatedby = 'CDM-31574', 
	updatedon = now()
where intakeserviceid = '088888c8-eef9-4e80-8182-d1e4b8f78961'
	and activeflag = 1;	