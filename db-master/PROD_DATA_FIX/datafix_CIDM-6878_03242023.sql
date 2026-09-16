-- CIDM-6878 - Duplicate removal start date(Same removal id mapped to two different child's)
/*
-- Issue Description: 

-- Category/ Module: Child Removal (Case Management)
-- Root cause: CJAMS Removal creen was having a flaw in the siblings removal edit option.
-- Fix Providerd: Code was provided with CIDM-6878 deployment   
--				  This Datafix is for all impacted cases
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Baltimore City	3126068	200906934	King McKenson-Bowen	5/14/2022	6/1/2022	Approved	254071	(f2cb10b4-e6f4-4a22-9247-2fa1a9abaca3)	
-- NO OOH but have a Child Removal and Placement 5/14/2022 - 6/1/2022

INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, startdate, enddate, 
		insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, 
		clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, 
		subprogramkey, objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype
	)
VALUES
	(	gen_random_uuid(), '79e2a092-d3d1-4726-9506-3ee86a5d9ffc', '2022-05-14 00:00:00.000', '2022-06-01 14:30:00.000',
		now(), 'CIDM-6878', now(), 'CIDM-6878', 1, NULL, 
		NULL, NULL, NULL, NULL, 'OOH', 
		'NA', 'servicecase', 'a8ab06a5-6a5c-4c7f-b326-34d87b1cb8c9', '3126068', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);
	
-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Baltimore City	CPS-IR 221020185261	4457401	ZAMARI HUNTER	4/25/2022		Un-Approved	253900	9827829d-c45b-4efb-a5e3-4ebed5d2b12b

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253900
	and rm.personid = '802048f5-e040-4f84-bbf7-e2d00fe9eda3'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set exitdate = removaldate, 
	activeflag = 0,
	updatedby = 'CIDM-6878',
	updatedon = now()
where rm.removalid = 253900
	and rm.personid = '802048f5-e040-4f84-bbf7-e2d00fe9eda3'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
		
-- Prgram Assignment 
select programkey, startdate, enddate, objectid, objecttypekey, entityid, updatedon, updatedby  
	from personprogramarea 
where personid = '802048f5-e040-4f84-bbf7-e2d00fe9eda3'
	and programkey = 'OOH'
	and personprogramid = '8c5a5dad-a039-463a-8221-193451d42f12' ;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-6878'	
where personid = '802048f5-e040-4f84-bbf7-e2d00fe9eda3'
	and programkey = 'OOH'
	and personprogramid = '8c5a5dad-a039-463a-8221-193451d42f12' ;
	


-- LDSS				Case ID				Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Baltimore City	CPS-IR 221020179305	4455639		KANYIA A JOHNSON	1/27/2022				Un-Approved	253491	d594c8fc-2f89-4d74-88c7-d38b06f69718	
-- 2 OOH PA found with wrong date 02/01/2022 - have 1 active Child Removal 01/27/2022

-- Prgram Assignment 
select programkey, startdate, enddate, objectid, objecttypekey, entityid, updatedon, updatedby  
	from personprogramarea 
where personid = '265f828f-b1d6-49ef-a69d-e9cd92dd9c5e'
	and programkey = 'OOH'
	and personprogramid = '55396088-fb71-448a-b2fb-df92f9a3b7ff' ;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-6878'	
where personid = '265f828f-b1d6-49ef-a69d-e9cd92dd9c5e'
	and programkey = 'OOH'
	and personprogramid = '55396088-fb71-448a-b2fb-df92f9a3b7ff' ;


-- Prgram Assignment 
select programkey, startdate, enddate, objectid, objecttypekey, entityid, updatedon, updatedby  
	from personprogramarea 
where personid = '265f828f-b1d6-49ef-a69d-e9cd92dd9c5e'
	and programkey = 'OOH'
	and personprogramid = 'd11a2483-2fed-43a6-ba29-936af3c21613' ;

update personprogramarea
set startdate = '2022-01-27 00:00:00.000',
	updatedon = now(), 
	updatedby = 'CIDM-6878'	
where personid = '265f828f-b1d6-49ef-a69d-e9cd92dd9c5e'
	and programkey = 'OOH'
	and personprogramid = 'd11a2483-2fed-43a6-ba29-936af3c21613' ;



-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Baltimore City	211030012066	200826091	Tyra Savage	1/25/2022	4/28/2022	Approved	253470	390fa667-0b5b-447a-ba21-e08ebf2e0de0	
-- Removal Started on 01/25/2022 Ended on 04/28/2022
-- But found the OOH PA start date 01/26/2022    and end date  04/28/2022"

-- Prgram Assignment 
select programkey, startdate, enddate, objectid, objecttypekey, entityid, updatedon, updatedby  
	from personprogramarea 
where personid = '7d8a71cd-0cea-4c6a-9aa3-0d813eed9368'
	and programkey = 'OOH'
	and personprogramid = '60e3ee9f-49e5-45a4-b24a-266568c4012e' ;

update personprogramarea
set startdate = '2022-01-25 00:00:00.000',
	updatedon = now(), 
	updatedby = 'CIDM-6878'	
where personid = '7d8a71cd-0cea-4c6a-9aa3-0d813eed9368'
	and programkey = 'OOH'
	and personprogramid = '60e3ee9f-49e5-45a4-b24a-266568c4012e' ;
	

-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Baltimore City	3278292	4108241	NOAH ATLAS SMITH	11/24/2021		Un-Approved	253168	a07b4bb8-9c23-4ff6-9f89-ad0578d2d6e9	
-- Removal started on 11/30/2021 But OOH Started on 11/24/2021


-- Prgram Assignment 
select programkey, startdate, enddate, objectid, objecttypekey, entityid, updatedon, updatedby  
	from personprogramarea 
where personid = 'ba6c9bf3-4a06-4b19-bc29-0e6706f10c7a'
	and programkey = 'OOH'
	and personprogramid = '487ac5a1-5672-4e87-83ac-2b2d97998aa0' ;

update personprogramarea
set startdate = '2021-11-30 00:00:00.000',
	updatedon = now(), 
	updatedby = 'CIDM-6878'	
where personid = 'ba6c9bf3-4a06-4b19-bc29-0e6706f10c7a'
	and programkey = 'OOH'
	and personprogramid = '487ac5a1-5672-4e87-83ac-2b2d97998aa0' ;
	

-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Baltimore County	3276768	4084394	KYRON MALIK WILKERSON	10/13/2021	10/13/2021	Approved	252937	95bdf801-6102-4deb-8870-98c7f448d5d6		
-- Child Removal Start Date 10/13/2021 Have 3 Open OOH PA  10/18/2021 10/18/2021 10/22/2021

-- Prgram Assignment 
select programkey, startdate, enddate, objectid, objecttypekey, entityid, updatedon, updatedby  
	from personprogramarea 
where personid = '4ebe08f4-6c9e-47e8-88b4-7e602870769f'
	and programkey = 'OOH'
	and personprogramid in ( '85c2a719-c973-4c9f-9bb4-4422ca19a73d', '9b98808e-ff32-4370-9555-440fe0397415' ) ;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-6878'	
where personid = '4ebe08f4-6c9e-47e8-88b4-7e602870769f'
	and programkey = 'OOH'
	and personprogramid in ( '85c2a719-c973-4c9f-9bb4-4422ca19a73d', '9b98808e-ff32-4370-9555-440fe0397415' ) ;
	

-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Baltimore County	3276768	200142529	Wrong Name COOK	10/13/2021	10/13/2021 	Approved	252937	95bdf801-6102-4deb-8870-98c7f448d5d6
-- NO OOH PA Child Removal started and ended on same day 10/13/2021

INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, startdate, enddate, 
		insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, 
		clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, 
		subprogramkey, objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype
	)
VALUES
	(	gen_random_uuid(), 'ce47c13a-904b-4961-8a6e-164c88f95623', '2021-10-13 00:00:00.000', '2021-10-13 10:51:17.000',
		now(), 'CIDM-6878', now(), 'CIDM-6878', 1, NULL, 
		NULL, NULL, NULL, NULL, 'OOH', 
		'NA', 'servicecase', 'b06c1765-cd1b-417d-b61c-f494fd33269d', '3276768', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);


-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Charles	3296483	200784824	Yasire' L Cooper	5/16/2022	11/10/2022		Approved	254026	026160bd-f326-42bf-a4dc-855b5035b48b		
-- Child Removal start date 5/16/2022 End date 11/10/2022  
-- OOH PA Start Date 5/16/2022 End Date 08/18/2022

-- Prgram Assignment 
select programkey, startdate, enddate, objectid, objecttypekey, entityid, updatedon, updatedby  
	from personprogramarea 
where personid = 'c5859b80-6707-41e0-b5f6-362a0786fbb7'
	and programkey = 'OOH'
	and personprogramid = 'ee386685-d493-4841-99c0-426fd97f2cc3' ;

update personprogramarea
set enddate = '2022-11-10 09:00:00.000',
	updatedon = now(), 
	updatedby = 'CIDM-6878'	
where personid = 'c5859b80-6707-41e0-b5f6-362a0786fbb7'
	and programkey = 'OOH'
	and personprogramid = 'ee386685-d493-4841-99c0-426fd97f2cc3' ;
	

-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Harford	3295673	4484080	EVELYN ADAMS	2/6/2023			Approved	262934	3f032416-6fe0-4dd0-8523-34ea03cb6fbc
-- Have open child removal 02/06/2023 But no OOH PA found


INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, startdate, enddate, 
		insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, 
		clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, 
		subprogramkey, objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype
	)
VALUES
	(	gen_random_uuid(), '9b740036-bab2-4fe6-a9d3-296a6304fa1b', '2023-02-06 00:00:00.000', NULL,
		now(), 'CIDM-6878', now(), 'CIDM-6878', 1, NULL, 
		NULL, NULL, NULL, NULL, 'OOH', 
		'NA', 'servicecase', 'fd137343-1c06-4ffc-a48b-6d35318bdbc5', '3295673', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);


-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Montgomery	221030014660	200830831	Jhaedi O Nolasco	6/16/2022	6/17/2022	Approved	254200	6fbec81e-2ef1-4d3f-ae10-543d1a699365		
-- NO Removal Found But found OOH PA 06/16/2022	06/17/2022

-- Prgram Assignment 
select programkey, startdate, enddate, objectid, objecttypekey, entityid, updatedon, updatedby  
	from personprogramarea 
where personid = '20004661-8da4-474f-88fa-9228a300530d'
	and programkey = 'OOH'
	and personprogramid = '67685cf5-aa48-49f2-908e-c0eb08b7c625' ;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-6878'	
where personid = '20004661-8da4-474f-88fa-9228a300530d'
	and programkey = 'OOH'
	and personprogramid = '67685cf5-aa48-49f2-908e-c0eb08b7c625' ;
	
	

-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Montgomery	221030014660	200830846	Janine O Nolasco	6/16/2022	6/17/2022	Approved	254200	6fbec81e-2ef1-4d3f-ae10-543d1a699365		
-- Open Child Removal with start date 06/16/2022 end date 06/17/2022 NO OOH PA Found

INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, startdate, enddate, 
		insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, 
		clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, 
		subprogramkey, objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype
	)
VALUES
	(	gen_random_uuid(), 'ab14301e-5eab-4975-9c14-6d686a406b6f', '2022-06-16 00:00:00.000', '2022-06-17 17:00:00.000',
		now(), 'CIDM-6878', now(), 'CIDM-6878', 1, NULL, 
		NULL, NULL, NULL, NULL, 'OOH', 
		'NA', 'servicecase', 'b09bf7a1-17a7-4943-a286-5aebd9c9c737', '221030014660', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);


-- LDSS				Case ID	Client ID 	Client Name			Removal 	Exit Date	Status		removalid 	
--------------------------------------------------------------------------------------------------------
-- Montgomery	221030016216	3156199	CRISPIN MPOY	5/19/2022	5/20/2022	Approved	254066	2842c3db-bed7-4c00-abb9-a91a4fad63f6		
-- OOH No Found  But child removal start 05/19/2022 end date 05/20/2022

INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, startdate, enddate, 
		insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, 
		clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, 
		subprogramkey, objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype
	)
VALUES
	(	gen_random_uuid(), '03f2d6d9-73a6-444b-8ff6-09f05bca30df', '2022-05-19 00:00:00.000', '2022-05-20 08:00:26.000',
		now(), 'CIDM-6878', now(), 'CIDM-6878', 1, NULL, 
		NULL, NULL, NULL, NULL, 'OOH', 
		'NA', 'servicecase', '6bbf992c-106f-4cf4-8b63-2fd9fa6824c8', '221030016216', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);
