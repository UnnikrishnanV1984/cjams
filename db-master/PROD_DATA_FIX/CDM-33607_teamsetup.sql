-- CDM-33607 - Cannot assign to appeals worker
/*
-- Issue Description: 
	Jennifer Kephart is not showing in Frederick CPS unit 1 and so cannot assign/transfer a case to her.
   
-- securityusersid: f29992db-931a-4770-b538-e3316f992715	Jennifer Kephart - DSDS
-- jenniferl.kephart@maryland.gov

-- Category/ Module: User Roles (User Management) 
-- Root cause: User's teammember & teammemberassignment data is missing for the Frederick County
-- Fix Provided: Datafix has been promoted add CWAPPEALCO role Jennifer Kephart/Frederick County 
-- Note:   This role was initially inserted with CDM-19506, but now it's missing.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- For Frederick 1438
-- CPS Unit 1 - a00579a8-139b-42ed-9c4d-662dd7cee47c	
Delete from cjams.teammember where insertedby = 'CDM-33607' and loadnumber = 'jenniferkephart31';
Delete from cjams.teammemberassignment where insertedby = 'CDM-33607' and securityusersid = 'f29992db-931a-4770-b538-e3316f992715';
INSERT INTO cjams.teammember
	(	teammemberid, activeflag, teamid, loadnumber, roletypekey, positioncode, 
		description, isoncall, insertedby, insertedon, updatedby, updatedon, 
		effectivedate, expirationdate, "timestamp", linenumber, voidedby, 
		voidedon, voidreasonid, rtfdate, coadate, old_id, isdefaultroute
	)
VALUES
	(	gen_random_uuid(), 1, 'a00579a8-139b-42ed-9c4d-662dd7cee47c', 'jenniferkephart31', 'CWAPPEALCO', '1438',
		'Appeal Coordinator Staff', true, 'CDM-33607', now(), 'CDM-33607', now(), 
		now(), NULL, NULL, NULL, NULL, 
        NULL, NULL, now(), now(), NULL, 1
	);

commit;

-- For Frederick 1438
INSERT INTO cjams.teammemberassignment
	(	teammemberassignmentid, activeflag, 
		teammemberid, 
		securityusersid, 
		insertedby, insertedon, updatedby, updatedon, effectivedate, 
		expirationdate, "timestamp", voidedby, voidedon, voidreasonid, coadate, rtfdate, intakenumber, old_id
	)
VALUES
	(	gen_random_uuid(), 1, 
		(select teammemberid from cjams.teammember where insertedby = 'CDM-33607' and loadnumber = 'jenniferkephart31' ),
		'f29992db-931a-4770-b538-e3316f992715', 'CDM-33607', now(), 'CDM-33607', now(), 
		now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);
