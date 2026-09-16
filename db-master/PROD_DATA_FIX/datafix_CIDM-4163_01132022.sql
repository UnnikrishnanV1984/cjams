-- CIDM-4163 - Family Assignment to case 211030013069
/*
-- Issue Description: 
   The Baltimore City Service Case (ID: 211030013069) is currently not having any active Family assignment.
   User request to give a 'Family' assignment to Renee Robinson

-- Category/ Module: Assignments (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Renee / Phyllis Robinson - 258cfaf9-ebe7-4996-b3b9-2d6a3cdcea94	
-- renee.robinson@maryland.gov	

-- Case ID: 211030013069 - 380e0ba2-ed7d-4926-b97a-7c816527876a

select caseassignmentid, frombizunitidno, toworkeridno, startdate, enddate, 
	responsibilitytypekey, updatedby, updatedon
from caseassignment 
where objectid = '380e0ba2-ed7d-4926-b97a-7c816527876a'
	and activeflag = 1 ;

update caseassignment 
set enddate = startdate,
	updatedby = 'CIDM-4163',
	updatedon = now()
where objectid = '380e0ba2-ed7d-4926-b97a-7c816527876a'
	and activeflag = 1 ;
	

INSERT INTO cjams.caseassignment
	(	caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, 
		fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, 
		effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
		foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, 
		updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, 
		startdate, enddate, fromteamid, toteamid, remarks, 
		statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
		assigndate, isrestricted, assigndescription, summary, isnew, 
		expungementflag, entityopendate, etl_userid, etl_load_date, servicetype
	)
VALUES
	(	gen_random_uuid(), gen_random_uuid(), NULL, '40c41d94-a322-4495-930e-7af91dd48ff8', 
		NULL, NULL, '258cfaf9-ebe7-4996-b3b9-2d6a3cdcea94', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, 'CIDM-4163', 'CIDM-4163', now(), 
		now(), 'servicecase', '380e0ba2-ed7d-4926-b97a-7c816527876a', 'family', 1, 
		'2021-12-28 15:10:08.194', NULL, 'c7915c01-783a-40f4-bb8e-5b2b42b51318', 'c7915c01-783a-40f4-bb8e-5b2b42b51318', '', 
		'OPEN', '7665ca54-5374-4174-be07-a687b811a82c', '7665ca54-5374-4174-be07-a687b811a82c', 'W', 
		NULL, '2021-12-28 00:00:00.000', NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);
