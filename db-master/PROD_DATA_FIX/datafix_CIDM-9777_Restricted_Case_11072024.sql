-- CIDM-9777 - Request to add access for the 2 restricted CPS Cases
/*
-- Issue Description: 
	Request to add access for the 2 restricted CPS Cases
-- CPS-AR 241021895963 - 129d9eb8-58a3-4858-a5bc-b6f602ea4e69	
-- CPS-IR 241022935663 - cd1deeb7-ac74-4dbb-8d46-52db45dbf3fa	

-- Category/ Module: CPS Case (Investigation Management) 
-- Root cause: Currently CJAMS is not allowing the users to give the restricted access to SSC users.
-- Fix Provided: Datafix has been promoted to grant the requested CPS case access.
-- Pull request# N/A 
-- Is Code fix Required?: No
--	Code fix ticket#: N/A
--	Reason why no related code fix: TBD
--  Regression Impacts: N/A
*/

-- 34aa88ee-492f-4b39-800a-9fa0d8b5cef8	tara.newcomer3@maryland.gov	- Tara Newcomer - CWIW
-- d0517441-7a44-4858-84b4-7965fda851bd	erin.volz2@maryland.gov	- Erin Volz - CWIW

-- CPS-AR 241021895963 - 129d9eb8-58a3-4858-a5bc-b6f602ea4e69	
INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'Servicerequest', '129d9eb8-58a3-4858-a5bc-b6f602ea4e69', 
		'34aa88ee-492f-4b39-800a-9fa0d8b5cef8', '', 
		false, false, false, 
		'CIDM-9777', 'CIDM-9777', now(), now(), 1
	);

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'Servicerequest', '129d9eb8-58a3-4858-a5bc-b6f602ea4e69', 
		'd0517441-7a44-4858-84b4-7965fda851bd', '', 
		false, false, false, 
		'CIDM-9777', 'CIDM-9777', now(), now(), 1
	);

-- CPS-IR 241022935663 - cd1deeb7-ac74-4dbb-8d46-52db45dbf3fa
INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'Servicerequest', 'cd1deeb7-ac74-4dbb-8d46-52db45dbf3fa', 
		'34aa88ee-492f-4b39-800a-9fa0d8b5cef8', '', 
		false, false, false, 
		'CIDM-9777', 'CIDM-9777', now(), now(), 1
	);

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'Servicerequest', 'cd1deeb7-ac74-4dbb-8d46-52db45dbf3fa', 
		'd0517441-7a44-4858-84b4-7965fda851bd', '', 
		false, false, false, 
		'CIDM-9777', 'CIDM-9777', now(), now(), 1
	);

