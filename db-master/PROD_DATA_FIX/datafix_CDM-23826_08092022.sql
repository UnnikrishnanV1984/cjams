-- CDM-23826 - Correct Victor to Out of home care
/*
-- Issue Description: 
   To add missing Out of Home (OOH) program assignment
   
-- Case ID: 3248023
-- Client ID: 200164248 (Victor Long) - d5e0d3b7-8b95-46df-9b5a-5db494974f2d
-- Removal ID: 252891 - 2021-10-06 To Current - 312e4e45-9537-4de4-86d4-2a5aac18f66c

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Before 
select personprogramid, programkey, startdate, enddate, insertedby, insertedon 
	from personprogramarea 
where personid = 'd5e0d3b7-8b95-46df-9b5a-5db494974f2d'
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
	(	gen_random_uuid(), 'd5e0d3b7-8b95-46df-9b5a-5db494974f2d', '2021-10-06 00:00:00.000', NULL, now(), 
		'CDM-23826', now(), 'CDM-23826', 1, NULL, 
		NULL, NULL, NULL, NULL, 'OOH', 
		'NA', 'servicecase', 'f20c3153-81fb-4871-8125-eb753dc195d4', '3248023', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);

-- After 
select personprogramid, programkey, startdate, enddate, insertedby, insertedon 
	from personprogramarea 
where personid = 'd5e0d3b7-8b95-46df-9b5a-5db494974f2d'
	and programkey = 'OOH' 
	and activeflag = 1 ;