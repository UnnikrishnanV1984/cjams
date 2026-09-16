-- CDM-26125 - Correct Out of home care
/*
-- Issue Description: 
   To add missing Out of Home (OOH) program assignment
   
-- Case ID: 3228266

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- ClientId 200786007 : Shane	Orellana Blanco
-- Before 
select 	personprogramid, programkey, startdate, enddate, insertedby, insertedon 
from 	personprogramarea 
where 	personid = '0b10f2c8-cf92-4983-ac1a-7d54e1af3598'
		and objectid = '3c95ff29-78aa-4a0f-bc11-9b3d1503ef66'
		and programkey = 'OOH' 
		and activeflag = 1 ;

INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, startdate, enddate, insertedon, 
		insertedby, updatedon, updatedby, activeflag, datavalidflag, 
		clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, 
		subprogramkey, objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype
	)
VALUES
	(	gen_random_uuid(), '0b10f2c8-cf92-4983-ac1a-7d54e1af3598', '2021-07-22 00:00:00.000', NULL, now(), 
		'CDM-26125', now(), 'CDM-26125', 1, NULL, 
		NULL, NULL, NULL, NULL, 'OOH', 
		'NA', 'servicecase', '3c95ff29-78aa-4a0f-bc11-9b3d1503ef66', '3228266', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);

-- After 
select 	personprogramid, programkey, startdate, enddate, insertedby, insertedon 
from 	personprogramarea 
where 	personid = '0b10f2c8-cf92-4983-ac1a-7d54e1af3598'
		and objectid = '3c95ff29-78aa-4a0f-bc11-9b3d1503ef66'
		and programkey = 'OOH' 
		and activeflag = 1 ;
	

-- ClientId 4312428 : JORDANTHOMAS	ORELLANABLANCO
-- Before 
select 	personprogramid, programkey, startdate, enddate, insertedby, insertedon 
from 	personprogramarea 
where 	personid = '09393d73-c65c-42a1-b245-b98769719308'
		and objectid = '3c95ff29-78aa-4a0f-bc11-9b3d1503ef66'
		and programkey = 'OOH' 
		and activeflag = 1 ;

INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, startdate, enddate, insertedon, 
		insertedby, updatedon, updatedby, activeflag, datavalidflag, 
		clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, 
		subprogramkey, objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype
	)
VALUES
	(	gen_random_uuid(), '09393d73-c65c-42a1-b245-b98769719308', '2021-07-22 00:00:00.000', NULL, now(), 
		'CDM-26125', now(), 'CDM-26125', 1, NULL, 
		NULL, NULL, NULL, NULL, 'OOH', 
		'NA', 'servicecase', '3c95ff29-78aa-4a0f-bc11-9b3d1503ef66', '3228266', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);

-- After 
select 	personprogramid, programkey, startdate, enddate, insertedby, insertedon 
from 	personprogramarea 
where 	personid = '09393d73-c65c-42a1-b245-b98769719308'
		and objectid = '3c95ff29-78aa-4a0f-bc11-9b3d1503ef66'
		and programkey = 'OOH' 
		and activeflag = 1 ;

-- ClientId 4312370 : ALINA	CAMPOVERDE ALTAMIRANO
-- Before 
select 	personprogramid, programkey, startdate, enddate, insertedby, insertedon , *
from 	personprogramarea 
where 	personid = '06e2d2b7-1a53-464c-b23b-e625a45add86'
		and programkey = 'OOH' 
		and objectid = '3c95ff29-78aa-4a0f-bc11-9b3d1503ef66'
		and activeflag = 1 ;

INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, startdate, enddate, insertedon, 
		insertedby, updatedon, updatedby, activeflag, datavalidflag, 
		clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, 
		subprogramkey, objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype
	)
VALUES
	(	gen_random_uuid(), '06e2d2b7-1a53-464c-b23b-e625a45add86', '2021-07-22 00:00:00.000', NULL, now(), 
		'CDM-26125', now(), 'CDM-26125', 1, NULL, 
		NULL, NULL, NULL, NULL, 'OOH', 
		'NA', 'servicecase', '3c95ff29-78aa-4a0f-bc11-9b3d1503ef66', '3228266', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);

-- After 
select 	entityid, alternateid,personprogramid, programkey, startdate, enddate, insertedby, insertedon, *
from 	personprogramarea 
where 	personid = '06e2d2b7-1a53-464c-b23b-e625a45add86'
		and objectid = '3c95ff29-78aa-4a0f-bc11-9b3d1503ef66'
		and programkey = 'OOH' 
		and activeflag = 1 ;
	