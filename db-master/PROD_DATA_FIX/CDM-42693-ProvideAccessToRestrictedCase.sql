-- CDM-42693-ProvideAccessToRestrictedCase
/*
-- Issue Description: 
	Request to add access for the 2 restricted CPS Cases
-- 241021923438 - 9f968ca3-91d5-4888-86c8-8e0d0b59ff89	
-- 241021911716 - cb00dd5e-fbf6-49d0-87d8-10ebcd3f26a1	

-- Category/ Module: CPS Case (Investigation Management) 
-- Root cause: Currently CJAMS is not allowing the users to give the restricted access to SSC users.
-- Fix Provided: Datafix has been promoted to grant the requested CPS case access.
-- Pull request# N/A 
-- Is Code fix Required?: No
--	Code fix ticket#: N/A
--	Reason why no related code fix: TBD
--  Regression Impacts: N/A
*/

-- 62798f42-fa2d-4e70-b35a-3ca7ede24681	- antwan.chambers1@maryland.gov
-- 34aa88ee-492f-4b39-800a-9fa0d8b5cef8 - tara.newcomer3@maryland.gov

-- 241021923438 - 9f968ca3-91d5-4888-86c8-8e0d0b59ff89	
INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'Servicerequest', '9f968ca3-91d5-4888-86c8-8e0d0b59ff89', 
		'62798f42-fa2d-4e70-b35a-3ca7ede24681', '', 
		false, false, false, 
		'CDM-42693', 'CDM-42693', now(), now(), 1
	);

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'Servicerequest', '9f968ca3-91d5-4888-86c8-8e0d0b59ff89', 
		'34aa88ee-492f-4b39-800a-9fa0d8b5cef8', '', 
		false, false, false, 
		'CDM-42693', 'CDM-42693', now(), now(), 1
	);

-- 241021911716 - cb00dd5e-fbf6-49d0-87d8-10ebcd3f26a1	
INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'Servicerequest', 'cb00dd5e-fbf6-49d0-87d8-10ebcd3f26a1', 
		'62798f42-fa2d-4e70-b35a-3ca7ede24681', '', 
		false, false, false, 
		'CDM-42693', 'CDM-42693', now(), now(), 1
	);

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'Servicerequest', 'cb00dd5e-fbf6-49d0-87d8-10ebcd3f26a1', 
		'34aa88ee-492f-4b39-800a-9fa0d8b5cef8', '', 
		false, false, false, 
		'CDM-42693', 'CDM-42693', now(), now(), 1
	);