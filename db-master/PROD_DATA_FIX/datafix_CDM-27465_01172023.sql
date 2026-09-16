-- CDM-27465 - Cannot assign to appeals worker
/*
-- Issue Description: 
	Jennifer Kephart is not showing in Garrett CPS unit and so cannot assign/transfer a case to her.
   
-- securityusersid: f29992db-931a-4770-b538-e3316f992715	Jennifer Kephart - DSDS
-- jenniferl.kephart@maryland.gov

-- Category/ Module: User Roles (User Management) 
-- Root cause: User's teammember & teammemberassignment data is missing for the Garrett County
-- Fix Provided: Datafix has been promoted add CWAPPEALCO role Jennifer Kephart/Garrett County 
-- Note:   This role was initially inserted with CDM-19506, but now it's missing.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

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
		'Appeal Coordinator Staff', true, 'CDM-27465', now(), 'CDM-27465', now(), 
		now(), NULL, NULL, NULL, NULL, 
		NULL, NULL, now(), now(), NULL, 1, '760bbede-3181-44a0-9d99-36a9b86d777d'
	);

commit;

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
		(select teammemberid from cjams.teammember where insertedby = 'CDM-27465' and loadnumber = 'jenniferkephart3' ),
		'f29992db-931a-4770-b538-e3316f992715', 'CDM-27465', now(), 'CDM-27465', now(), 
		now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);
