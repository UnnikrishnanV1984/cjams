-- CDM-32426 - Stuck open case
/*
-- Issue Description: 
	User request to close the MD CHESSIE migrated Blank Service case (No clients)
   
-- Case ID: 3306855 - d75d3cdd-2453-4d18-b7f8-3ed6ddd19510
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: MD CHESSIE migrated Blank Service case (No clients).
-- Fix Provided: Datafix has been promoted to close the Service case.
-- Verified in the last database copy of MD CHESSIE that case did not have any clients involved.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To close the Service case (CDM-32426)
select servicecasenumber, statustypekey, dispositioncode, enddate, updatedby, updatedon
	from servicecase
where servicecasenumber = '3306855'
	and activeflag  = 1 ;
	
update servicecase 
set statustypekey = 'Closed', 
	dispositioncode = 'Closed', 
	enddate = '2023-06-22 00:00:00', 
	updatedby = 'CDM-32426',
	updatedon = now() 
where servicecasenumber = '3306855' 
	and activeflag  = 1 ;

INSERT INTO cjams.servicecasedisposition
	(	servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, 
		"comments", effectivedate, 
		activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, 
		etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES
	(	cjams.gen_random_uuid(), 'd75d3cdd-2453-4d18-b7f8-3ed6ddd19510', '2023-06-22 00:00:00', 'Closed', 'Closed', 
		'MD CHESSIE migrated Blank Service case, closed with S20230173051318.', '2023-06-22 00:00:00', 
		1, 'CDM-32426 ', now(),  'CDM-32426 ', now(), NULL, '3306855', 
		NULL, NULL, NULL, NULL
	);
	
select caseassignmentid, responsibilitytypekey, startdate, enddate, updatedby, updatedon 
	from caseassignment
where objectid = 'd75d3cdd-2453-4d18-b7f8-3ed6ddd19510'
	and activeflag = 1 
	and enddate is null ;
	
update caseassignment
set enddate = '2023-06-22 00:00:00', 
	updatedby = 'CDM-32426',
	updatedon = now() 
where objectid = 'd75d3cdd-2453-4d18-b7f8-3ed6ddd19510'
	and activeflag = 1 
	and enddate is null ;
	