-- CDM-33738 - Cannot assign to appeals worker
/*
-- Issue Description: 
	Jennifer Kephart is not showing in Allegany or Garrett county CPS unit 1 and so cannot assign/transfer a case to her.
   
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

-- Data fix is done for fedrick county as part of CDM-33607, Garret as part of CDM-27465, Allegany as CDM-33738

-- For Allegany 1427
-- Intake & CPS Administration - 86b1426d-675d-4a17-b94b-2f5120122541	
Delete from cjams.teammember where insertedby = 'CDM-33738' and loadnumber = 'jenniferkephart33';
Delete from cjams.teammemberassignment where insertedby = 'CDM-33738' and securityusersid = 'f29992db-931a-4770-b538-e3316f992715';
INSERT INTO cjams.teammember
	(	teammemberid, activeflag, teamid, loadnumber, roletypekey, positioncode, 
		description, isoncall, insertedby, insertedon, updatedby, updatedon, 
		effectivedate, expirationdate, "timestamp", linenumber, voidedby, 
		voidedon, voidreasonid, rtfdate, coadate, old_id, isdefaultroute
	)
VALUES
	(	gen_random_uuid(), 1, '86b1426d-675d-4a17-b94b-2f5120122541', 'jenniferkephart33', 'CWAPPEALCO', '1427',
		'Appeal Coordinator Staff', true, 'CDM-33738', now(), 'CDM-33738', now(), 
		now(), NULL, NULL, NULL, NULL, 
        NULL, NULL, now(), now(), NULL, 1
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
		(select teammemberid from cjams.teammember where insertedby = 'CDM-33738' and loadnumber = 'jenniferkephart33' ),
		'f29992db-931a-4770-b538-e3316f992715', 'CDM-33738', now(), 'CDM-33738', now(), 
		now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);

-- Update data fix done by CDM-19506
update cjams.teammemberassignment 
set activeflag = 0, updatedby = 'CDM-33738', updatedon = now()
where insertedby = 'CDM-19506' and securityusersid = 'f29992db-931a-4770-b538-e3316f992715'
and teammemberassignmentid in ('25ea831f-060e-4815-8d41-3049e56c11b7','f0fd05a9-10e1-4435-b2ef-edbf977de7a5',
'747e4aa8-4b26-417a-8f7a-4e4ca122404b');

-- Update data fix done by CDM-27465
update cjams.teammemberassignment 
set teammemberid = (select teammemberid from cjams.teammember where insertedby = 'CDM-27465' and loadnumber = 'jenniferkephart3'), updatedby = 'CDM-33738', updatedon = now()
where insertedby = 'CDM-27465' and securityusersid = 'f29992db-931a-4770-b538-e3316f992715'
and teammemberassignmentid in ('8df45d59-1643-42fc-9f2e-7775ddb051e4');
