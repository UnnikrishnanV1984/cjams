-- CIDM-7991: Active OOH program assignment with closed Child removal (Data Issue)
/*
-- Issue Description: 
	Active OOH program assignment with closed Child removal (Data Issue)

-- Category/ Module: Program Assignment (Case Management) 
-- Root cause: Active OOH program assignment with closed Child removal (Data Issue)
-- Fix Provided: Datafix has been promoted to end date the OOH program assignment.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Close the OOH program assignments (CIDM-7991)
-- 1) 
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3159725	1646190		2aeca069-fece-4c03-8b5c-107caa8b9f17	4/7/2008	4e3cc53b-149e-4c26-acc6-fee56f7de1b9

select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '2aeca069-fece-4c03-8b5c-107caa8b9f17'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2008-04-07 15:30:00', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = '2aeca069-fece-4c03-8b5c-107caa8b9f17'
	and programkey = 'OOH'
	and enddate is null ;

-- Delete Additional OOHs
-- da647f61-f901-42f9-bb7c-3a7d0b1b3dc1	OOH	2003-12-15 00:00:00	2004-01-23 00:00:00	1	convertw	2021-04-07 10:30:02
-- 95dd3edc-27d3-402b-ae52-e4d588e7506d	OOH	2005-03-01 00:00:00	2008-04-07 00:00:00	1	ATA918630	2021-04-07 10:30:02
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid  in ('da647f61-f901-42f9-bb7c-3a7d0b1b3dc1', '95dd3edc-27d3-402b-ae52-e4d588e7506d')
	and programkey = 'OOH'
	and activeflag = 1;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid  in ('da647f61-f901-42f9-bb7c-3a7d0b1b3dc1', '95dd3edc-27d3-402b-ae52-e4d588e7506d')
	and programkey = 'OOH'
	and activeflag = 1;
	
-- 2) 	
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3122320	3807337		ca93980f-c77f-494d-b1b6-eb04683d8675	8/23/2017	96cbcc20-8c8f-4f11-90f5-0084aa048a15
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'ca93980f-c77f-494d-b1b6-eb04683d8675'
	and programkey = 'OOH'
	and activeflag = 1;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = 'ca93980f-c77f-494d-b1b6-eb04683d8675'
	and programkey = 'OOH'
	and activeflag = 1;


-- 3) 
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3124718	1698834		193c5572-383a-451e-a27c-8eef27a75080	8/19/2004	2cd690f7-d93a-4f60-8909-e9f5668a6469
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '193c5572-383a-451e-a27c-8eef27a75080'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2007-05-08 00:00:00', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = '193c5572-383a-451e-a27c-8eef27a75080'
	and programkey = 'OOH'
	and enddate is null ;


-- 4) 
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3299236	1475685		c935788c-5240-46b1-a126-1416c3896a05	5/8/2019	4d7bdbff-74bf-4bcc-98a5-9a9844f08cf1
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'c935788c-5240-46b1-a126-1416c3896a05'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2020-02-27 00:00:00', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = 'c935788c-5240-46b1-a126-1416c3896a05'
	and programkey = 'OOH'
	and enddate is null ;


-- 5)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3255195	1685724		1441e5a9-388a-4417-b896-dd34a97db1bd	8/31/2015	16179571-2d5a-4684-88a5-2d640c253c3d
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '1441e5a9-388a-4417-b896-dd34a97db1bd'
	and programkey = 'OOH'
	and activeflag = 1;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = '1441e5a9-388a-4417-b896-dd34a97db1bd'
	and programkey = 'OOH'
	and activeflag = 1;


-- 6)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3302424	2921802		7be79d70-022f-43ae-8ca6-a6d9e52f59ac	9/13/2019	652b2223-729d-4f51-b150-ce60cbb1146c
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '7be79d70-022f-43ae-8ca6-a6d9e52f59ac'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2020-01-28 00:00:00', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = '7be79d70-022f-43ae-8ca6-a6d9e52f59ac'
	and programkey = 'OOH'
	and enddate is null ;


-- 7)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3220151	3146638		b60248ab-cb6c-4882-90c3-e4fc6843a88a	12/24/2015	5c9df557-3b5b-4af9-aa5a-b8886a4ae81f

select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'b60248ab-cb6c-4882-90c3-e4fc6843a88a'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2020-02-01 09:30:00', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = 'b60248ab-cb6c-4882-90c3-e4fc6843a88a'
	and programkey = 'OOH'
	and enddate is null ;

-- 8)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3291213	4267785		5c2119b1-7052-43a2-ab5d-b00c97738849	8/14/2019	93da7925-074c-49f9-87e7-f01ea05b85e2
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '5c2119b1-7052-43a2-ab5d-b00c97738849'
	and programkey = 'OOH'
	and activeflag = 1;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = '5c2119b1-7052-43a2-ab5d-b00c97738849'
	and programkey = 'OOH'
	and activeflag = 1;

-- 9)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3210065	200863432	5afe9d23-8690-44a6-a95d-42bda3ec299d	7/27/2022	bdeeff3e-73e8-43a3-a974-eae187cbf54a
-- Delete OOH - Removal is inactive
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '5afe9d23-8690-44a6-a95d-42bda3ec299d'
	and programkey = 'OOH'
	and activeflag = 1;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = '5afe9d23-8690-44a6-a95d-42bda3ec299d'
	and programkey = 'OOH'
	and activeflag = 1;


select eligibility_id, client_id, case_id, delete_sw, update_user_id, update_ts  
	from tb_client_eligibility
where removal_id = 254406
	and delete_sw = 'N';

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CIDM-7991'
where removal_id = 254406
	and delete_sw = 'N';


-- 10)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3249923	3367806		4bb78dff-8b42-48b3-82fe-ddff70897a2b	12/19/2019	6c7653fe-5834-4a3f-9734-59a5c1ec3243
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '4bb78dff-8b42-48b3-82fe-ddff70897a2b'
	and programkey = 'OOH'
	and activeflag = 1;

update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = '4bb78dff-8b42-48b3-82fe-ddff70897a2b'
	and programkey = 'OOH'
	and activeflag = 1;

-- 11) 
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3291213	4267786		6cf0a0fe-299e-4ba2-a539-0c24d1fc0b25	8/14/2019	e430d041-1387-4ece-9bba-7e7e31117102
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '6cf0a0fe-299e-4ba2-a539-0c24d1fc0b25'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = '6cf0a0fe-299e-4ba2-a539-0c24d1fc0b25'
	and programkey = 'OOH'
	and enddate is null ;


-- 12)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3170918	1423437		e4a531cc-1fcd-4a8d-a980-1b4dedd1ff59	2/5/2010	d4ce0d85-acc6-4b71-90ca-052dca293790
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'e4a531cc-1fcd-4a8d-a980-1b4dedd1ff59'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2020-03-09 00:00:00.000', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = 'e4a531cc-1fcd-4a8d-a980-1b4dedd1ff59'
	and programkey = 'OOH'
	and enddate is null ;


-- 13)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3268066	3945149		6ec1077c-432b-4a9f-9ae6-350150767d36	11/30/2016	f243c352-52f9-4713-a480-1131b05c2b18
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '6ec1077c-432b-4a9f-9ae6-350150767d36'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = '6ec1077c-432b-4a9f-9ae6-350150767d36'
	and programkey = 'OOH'
	and enddate is null ;

-- 14)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3282815	4120947		043e9b18-dab3-4c48-97ec-450d8b2f22b8	11/20/2017	8745eadf-dcd4-4cbf-9e07-09f268ca4fe6
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '043e9b18-dab3-4c48-97ec-450d8b2f22b8'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2020-02-11 00:00:00.000', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = '043e9b18-dab3-4c48-97ec-450d8b2f22b8'
	and programkey = 'OOH'
	and enddate is null ;


-- 15)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3282815	4055676		9fdfb716-8f50-4d6e-a0f1-f8c59a0f2b10	11/20/2017	1a348ea5-7168-451c-adf5-9e340e5f3d53
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '9fdfb716-8f50-4d6e-a0f1-f8c59a0f2b10'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = '9fdfb716-8f50-4d6e-a0f1-f8c59a0f2b10'
	and programkey = 'OOH'
	and enddate is null ;
	

-- 16)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3238057	3765282		436a2d3e-f944-4abc-91d5-3f6ea109632b	6/20/2018	cfa24d2a-cf9c-4d09-b267-4041b521bfdf
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '436a2d3e-f944-4abc-91d5-3f6ea109632b'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2020-02-04 00:00:00.000', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = '436a2d3e-f944-4abc-91d5-3f6ea109632b'
	and programkey = 'OOH'
	and enddate is null ;

-- 17)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3242505	3697590		31d3b3f4-e324-464e-a550-00fc1ce1b4c8	10/16/2017	2f7f8726-0e9d-4379-a5f6-4a3dcf63fa10
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '31d3b3f4-e324-464e-a550-00fc1ce1b4c8'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2022-01-31 09:30:00.000', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = '31d3b3f4-e324-464e-a550-00fc1ce1b4c8'
	and programkey = 'OOH'
	and enddate is null ;


-- 18)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3303265	3638056		c2568907-8645-4726-9d1a-72b27b4d9b3e	10/16/2019	2f6592b6-b75f-49f6-b2f7-97e3ce95a22e
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'c2568907-8645-4726-9d1a-72b27b4d9b3e'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2020-01-28 00:00:00.000', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = 'c2568907-8645-4726-9d1a-72b27b4d9b3e'
	and programkey = 'OOH'
	and enddate is null ;


-- 19)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3279231	3181633		f017ee6d-cfe2-42fb-97e1-4c7d6062304d	9/4/2018	27f58923-622a-4f1b-8343-f9399668204e
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'f017ee6d-cfe2-42fb-97e1-4c7d6062304d'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = 'f017ee6d-cfe2-42fb-97e1-4c7d6062304d'
	and programkey = 'OOH'
	and enddate is null ;

-- 20)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3296344	4313173		1ebc3817-38c9-40e0-aa4c-9c0b56f340ac	2/12/2019	29cc30c2-3d66-4360-900a-0192e5518152
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '1ebc3817-38c9-40e0-aa4c-9c0b56f340ac'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = '1ebc3817-38c9-40e0-aa4c-9c0b56f340ac'
	and programkey = 'OOH'
	and enddate is null ;

-- 21)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3236290	3171247		99b71b32-a703-41c3-9c59-e3de1c502888	9/22/2015	3bce0fbb-0f51-4231-b1cd-aae81a774c82
--                      d46efee6-0ecb-4890-9d0c-6ec3d9f78c40	2011-10-12 To 2013-06-28 00:00:00.000
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid in ('99b71b32-a703-41c3-9c59-e3de1c502888', 'd46efee6-0ecb-4890-9d0c-6ec3d9f78c40')
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid in ('99b71b32-a703-41c3-9c59-e3de1c502888', 'd46efee6-0ecb-4890-9d0c-6ec3d9f78c40')
	and programkey = 'OOH'
	and enddate is null ;

-- 22)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3265618	3933451		27e3799e-d878-4118-a2a1-fb2e1eb2e6d7	1/23/2019	9fccbeca-a4bb-4308-9c80-92453c1d2291
-- 						3843dd36-2b1f-4c2e-a646-765bcaf55bbd	2018-01-26 00:00:00.000	2018-02-22 00:00:00.000	
--						b2e8a0a9-5ded-49f0-833f-45d1386bf193	2018-05-04 00:00:00.000	2018-08-08 00:00:00.000
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid in (	'27e3799e-d878-4118-a2a1-fb2e1eb2e6d7', 
							'3843dd36-2b1f-4c2e-a646-765bcaf55bbd',
							'b2e8a0a9-5ded-49f0-833f-45d1386bf193'
						)
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid in (	'27e3799e-d878-4118-a2a1-fb2e1eb2e6d7', 
							'3843dd36-2b1f-4c2e-a646-765bcaf55bbd',
							'b2e8a0a9-5ded-49f0-833f-45d1386bf193'
						)
	and programkey = 'OOH'
	and enddate is null ;

-- 23)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3257790	4239965		80b10548-79ea-465c-84a5-80552478c3da	5/31/2018	213432f2-38a7-46b0-bc19-480d90a60da8
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '80b10548-79ea-465c-84a5-80552478c3da'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = '80b10548-79ea-465c-84a5-80552478c3da'
	and programkey = 'OOH'
	and enddate is null ;


-- 24)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3299362	4460148		ddc81c81-5324-4e01-bf6d-2d1877021149	1/14/2020	58e59cb1-b130-47d5-9e64-3713bd00ee47
-- Delete duplicate OOH
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'ddc81c81-5324-4e01-bf6d-2d1877021149'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = 'ddc81c81-5324-4e01-bf6d-2d1877021149'
	and programkey = 'OOH'
	and enddate is null ;
	

-- 25)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3074939	1461678		c24e93ea-6e97-4835-8ce2-0277a7ca442c	11/2/1990	4b715e5b-f325-418b-a11c-d65a03aa1e39
-- Delete OOH - Removal is Inactive	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'c24e93ea-6e97-4835-8ce2-0277a7ca442c'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CIDM-7991'
where personprogramid = 'c24e93ea-6e97-4835-8ce2-0277a7ca442c'
	and programkey = 'OOH'
	and enddate is null ;

-- 26)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3245835	200850012	1911e956-e720-4f06-9c32-cde9c1207228	2/18/2022	8962af3c-6e7f-46f9-a932-7bfdcc8c80c0
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '1911e956-e720-4f06-9c32-cde9c1207228'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2023-06-21 18:00:00.000', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = '1911e956-e720-4f06-9c32-cde9c1207228'
	and programkey = 'OOH'
	and enddate is null ;


-- 27)
-- Case ID			cjamspid	personprogramid							startdate	personid
-- 2020014701295	10040264	e0e4f338-6e97-4380-8683-ffe8a93cf26e	5/23/2020	aab3d813-33d3-4bc6-bf90-d99a267ed044

select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'e0e4f338-6e97-4380-8683-ffe8a93cf26e'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2023-06-30 17:00:00.000', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = 'e0e4f338-6e97-4380-8683-ffe8a93cf26e'
	and programkey = 'OOH'
	and enddate is null ;


-- 28)
-- Case ID	cjamspid	personprogramid							startdate	personid
-- 3303266	3420568		cd12aba3-0e22-4e52-afc4-f13681fd681a	10/16/2019	680b1275-653e-492b-b5ca-69633aec10cd
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'cd12aba3-0e22-4e52-afc4-f13681fd681a'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2020-01-28 00:00:00.000', -- Removal end date
	updatedon = now() 
	-- updatedby = DO NOT Update
where personprogramid = 'cd12aba3-0e22-4e52-afc4-f13681fd681a'
	and programkey = 'OOH'
	and enddate is null ;

-- 29)
-- Case ID	cjamspid	personprogramid							startdate	end date			personid
-- 3110043	3850695		d6b7bb21-c787-4b14-b264-ca1bec3d28cf	4/19/2021	6/27/2023	1c839355-6278-456c-8b13-a4f4baaae4b0
-- fixed with CDM-34391

