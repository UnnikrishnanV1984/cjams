-- CDM-19506 - Assign for Appeal
/*
-- Issue Description: 
   User settup for appeal coordinator Jennifer L. Kephart
   for the Western Counties (Frederick, Washington, Allegany, and Garrett) 
   (The old appeal coordinator, Patricia Martin)

-- Jennifer Kephart - f29992db-931a-4770-b538-e3316f992715
-- jenniferl.kephart@maryland.gov

-- Category/ Module: User Profile (CJAMS Users Management) 
-- Root cause: Work around for multiple couty access  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Supervisor for Washington County
-- Christina McCauley - d5f3081f-42f5-4e19-bc15-1c721fe1789a
select supervisorid, updatedby, updatedon, positioncode
	from teammember
where teammemberid = '8dfbc669-e4c8-48c3-8875-05b137dfc4b0' ;

update teammember 
set supervisorid = 'd5f3081f-42f5-4e19-bc15-1c721fe1789a',
	updatedby = 'CDM-19506',
	updatedon = now()
where teammemberid = '8dfbc669-e4c8-48c3-8875-05b137dfc4b0' ;	

-- Update as 00000000-0000-0000-0000-000000000000
select supervisorid, updatedby, updatedon
	from userprofile 
where securityusersid = 'f29992db-931a-4770-b538-e3316f992715' ;

update userprofile 
set supervisorid = '00000000-0000-0000-0000-000000000000',
	updatedby = 'CDM-19506',
	updatedon = now()
where securityusersid = 'f29992db-931a-4770-b538-e3316f992715' ;	

-- For Allegany 1427 
-- Intake & CPS Administration - 86b1426d-675d-4a17-b94b-2f5120122541
INSERT INTO cjams.teammember
	(	teammemberid, activeflag, teamid, loadnumber, roletypekey, positioncode, 
		description, isoncall, insertedby, insertedon, updatedby, updatedon, 
		effectivedate, expirationdate, "timestamp", linenumber, voidedby, 
		voidedon, voidreasonid, rtfdate, coadate, old_id, isdefaultroute, supervisorid
	)
VALUES
	(	gen_random_uuid(), 1, '86b1426d-675d-4a17-b94b-2f5120122541', 'jenniferkephart1', 'CWAPPEALCO', '1427', 
		'Appeal Coordinator Staff', true, 'CDM-19506', now(), 'CDM-19506', now(), 
		now(), NULL, NULL, NULL, NULL, 
		NULL, NULL, now(), now(), NULL, 1, '55c8ea0d-98d3-455a-98ec-db067c1ec65d'
	);

-- For Frederick 1437
-- LDSS Management - 2172e435-e328-4fe8-b187-29f37cbd8e78
INSERT INTO cjams.teammember
	(	teammemberid, activeflag, teamid, loadnumber, roletypekey, positioncode, 
		description, isoncall, insertedby, insertedon, updatedby, updatedon, 
		effectivedate, expirationdate, "timestamp", linenumber, voidedby, 
		voidedon, voidreasonid, rtfdate, coadate, old_id, isdefaultroute, supervisorid
	)
VALUES
	(	gen_random_uuid(), 1, '2172e435-e328-4fe8-b187-29f37cbd8e78', 'jenniferkephart2', 'CWAPPEALCO', '1437', 
		'Appeal Coordinator Staff', true, 'CDM-19506', now(), 'CDM-19506', now(), 
		now(), NULL, NULL, NULL, NULL, 
		NULL, NULL, now(), now(), NULL, 1, 'fff5f374-8a84-481c-8814-81e62ca36f43' -- '9eb56ab2-2931-4ad5-83c1-54a7f30ba1f7'
	);

-- For Garrett 1438
-- CPS Unit - e333583f-22b4-4f56-b43b-9ec4b0c99f8e	
INSERT INTO cjams.teammember
	(	teammemberid, activeflag, teamid, loadnumber, roletypekey, positioncode, 
		description, isoncall, insertedby, insertedon, updatedby, updatedon, 
		effectivedate, expirationdate, "timestamp", linenumber, voidedby, 
		voidedon, voidreasonid, rtfdate, coadate, old_id, isdefaultroute, supervisorid
	)
VALUES
	(	gen_random_uuid(), 1, 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e', 'jenniferkephart3', 'CWAPPEALCO', '1438',
		'Appeal Coordinator Staff', true, 'CDM-19506', now(), 'CDM-19506', now(), 
		now(), NULL, NULL, NULL, NULL, 
		NULL, NULL, now(), now(), NULL, 1, '760bbede-3181-44a0-9d99-36a9b86d777d'
	);

commit;

-- For Allegany 1427 
INSERT INTO cjams.teammemberassignment
	(	teammemberassignmentid, activeflag, 
		teammemberid, 
		securityusersid, 
		insertedby, insertedon, updatedby, updatedon, effectivedate, 
		expirationdate, "timestamp", voidedby, voidedon, voidreasonid, coadate, rtfdate, intakenumber, old_id
	)
VALUES
	(	gen_random_uuid(), 1, 
		(select teammemberid from cjams.teammember where insertedby = 'CDM-19506' and loadnumber = 'jenniferkephart1' ),
		'f29992db-931a-4770-b538-e3316f992715', 'CDM-19506', now(), 'CDM-19506', now(), 
		now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);
	
-- For Frederick 1437
INSERT INTO cjams.teammemberassignment
	(	teammemberassignmentid, activeflag, 
		teammemberid, 
		securityusersid, 
		insertedby, insertedon, updatedby, updatedon, effectivedate, 
		expirationdate, "timestamp", voidedby, voidedon, voidreasonid, coadate, rtfdate, intakenumber, old_id
	)
VALUES
	(	gen_random_uuid(), 1, 
		(select teammemberid from cjams.teammember where insertedby = 'CDM-19506' and loadnumber = 'jenniferkephart2' ),
		'f29992db-931a-4770-b538-e3316f992715', 'CDM-19506', now(), 'CDM-19506', now(), 
		now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);

-- For Garrett 1438
INSERT INTO cjams.teammemberassignment
	(	teammemberassignmentid, activeflag, 
		teammemberid, 
		securityusersid, 
		insertedby, insertedon, updatedby, updatedon, effectivedate, 
		expirationdate, "timestamp", voidedby, voidedon, voidreasonid, coadate, rtfdate, intakenumber, old_id
	)
VALUES
	(	gen_random_uuid(), 1, 
		(select teammemberid from cjams.teammember where insertedby = 'CDM-19506' and loadnumber = 'jenniferkephart3' ),
		'f29992db-931a-4770-b538-e3316f992715', 'CDM-19506', now(), 'CDM-19506', now(), 
		now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);

