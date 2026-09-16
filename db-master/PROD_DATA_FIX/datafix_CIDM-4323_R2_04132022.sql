-- CIDM-4323 LJ Reports - Data Cleanup of duplicate/overlapping removals 
/*
-- Issue Description: 
   Data Cleanup of duplicate/overlapping removals approved by County Users & Hilary
       
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
Removal ID	Notes
251721	Baltimore County has confirmed that this is the correct one to delete
251931	Baltimore County has confirmed that this is the correct one to delete
253370	Baltimore County has confirmed that this is the correct one to delete
252846	Carroll has confirmed that this is the correct one to delete
252845	Carroll has confirmed that this is the correct one to delete
253560	Cecil has confirmed that this is the correct one to delete
251801	Harford has confirmed this is the correct one be deleated
253187	Harford has confirmed this is the correct one be deleated
251529	Delete this removal
252618	Prince Georges has confirmed that this removal is the one to delete
252797	Prince Georges has confirmed that this removal is the one to delete
251539	Prince Georges has confirmed that this removal is the one to delete
252619	Prince Georges has confirmed that this removal is the one to delete
250605	Prince Georges has confirmed that this removal is the one to delete
252450	Prince Georges has confirmed that this removal is the one to delete
186257	Prince Georges has confirmed that this removal is the one to delete
251047	Prince Georges has confirmed that this removal is the one to delete
251046	Prince Georges has confirmed that this removal is the one to delete
252704	Prince Georges has confirmed that this removal is the one to delete
252567	Prince Georges has confirmed that this removal is the one to delete
252941	Prince Georges has confirmed that this removal is the one to delete
252865	St. Mary's has confirmed that this is the correct one to delete
253452	Washington has confirmed that this removal is the one to delete

-- Fixed with CIDM-4323 R1 on 2022-03-11 19:44:14
251596	Somerset has confirmed this is the correct one to delete
*/

-- Remove all Routings 
select ro.activeflag, ro.routingstatustypeid, ro.remarks, ro.updatedby, ro.updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.activeflag = 1 
	and ro.objectid 
		in ( select rm.intakeservreqchildremovalid::character varying  
				from intakeservreqchildremoval rm 
			 where rm.removalid 
				in (
						251721, 251931, 253370, 252846, 252845, 253560, 251801, 253187, 251529, 252618,
						252797, 251539, 252619, 250605, 252450, 186257, 251047, 251046, 252704, 252567,
						252941, 252865, 253452,
						186257, 250605, 252450 -- with Placements
					)
				and rm.activeflag = 1
				) ;
				
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4323-1',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.activeflag = 1 
	and ro.objectid 
		in ( select rm.intakeservreqchildremovalid::character varying  
				from intakeservreqchildremoval rm 
			 where rm.removalid 
				in (
						251721, 251931, 253370, 252846, 252845, 253560, 251801, 253187, 251529, 252618,
						252797, 251539, 252619, 250605, 252450, 186257, 251047, 251046, 252704, 252567,
						252941, 252865, 253452,
						186257, 250605, 252450 -- with Placements
					)
				and rm.activeflag = 1
				) ;

-- Approved Removal with NO Placements				
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, 
	rm.updatedby, rm.updatedon, rm.intakeservreqchildremovalid, rm.personid 
from intakeservreqchildremoval rm 
where rm.removalid 
	in (
			251721, 251931, 253370, 252846, 252845, 253560, 251801, 253187, 251529, 252618,
			252797, 251539, 252619, 251047, 251046, 252704, 252567, 252941, 252865, 253452
		)
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			-- and ro.activeflag = 1
		) > 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4323-1',
	rm.updatedon = now() 		
where rm.removalid 
	in (
			251721, 251931, 253370, 252846, 252845, 253560, 251801, 253187, 251529, 252618,
			252797, 251539, 252619, 251047, 251046, 252704, 252567, 252941, 252865, 253452
		)
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			-- and ro.activeflag = 1
		) > 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

-- Approved Removal with Placements
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	,rm.intakeservreqchildremovalid 
	from intakeservreqchildremoval rm 
where rm.removalid 	in ( 186257, 250605, 252450 )
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			-- and ro.activeflag = 1
		) > 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) > 0;
		

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4323-1',
	rm.updatedon = now() 		
where rm.removalid 	in ( 186257, 250605, 252450 )
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			-- and ro.activeflag = 1
		) > 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) > 0;

-- Move the placement to another Child Removal		
-- 186257	e3f6b589-9733-4e91-be86-b494da6dc275	c98c3039-832d-476c-8fb2-0b203a649c4e	2017-08-04 00:00:00	2021-04-02 14:00:00
-- Replace with 5e4da901-c7a1-48a8-94e7-de31911e19f7
select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = 'e3f6b589-9733-4e91-be86-b494da6dc275'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= '5e4da901-c7a1-48a8-94e7-de31911e19f7',
	updatedby = 'CIDM-4323-1',
	updatedon = now() 	
where intakeservreqchildremovalid = 'e3f6b589-9733-4e91-be86-b494da6dc275'
	and activeflag = 1 ;


-- 250605	fe7cc3cf-fca6-43bd-aaf1-dfc27b589c2c	9011adce-a4c9-45c6-90bc-1974f4d55cec	2015-11-09 00:00:00	
-- Replace 1085debb-c10a-4886-b412-b1505f84e1d6
select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = 'fe7cc3cf-fca6-43bd-aaf1-dfc27b589c2c'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= '1085debb-c10a-4886-b412-b1505f84e1d6',
	updatedby = 'CIDM-4323-1',
	updatedon = now() 	
where intakeservreqchildremovalid = 'fe7cc3cf-fca6-43bd-aaf1-dfc27b589c2c'
	and activeflag = 1 ;
	
	
-- 252450	48ea261b-ca7b-4c05-a54e-6b6d32294989	d7ac18cd-6839-4240-ac31-a8746d48c9d7	2021-05-31 00:00:00	2021-06-02 15:00:00	
-- Replace ae97ad43-c7f0-4a30-8657-4e3e83ed5dcb
select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = '48ea261b-ca7b-4c05-a54e-6b6d32294989'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= 'ae97ad43-c7f0-4a30-8657-4e3e83ed5dcb',
	updatedby = 'CIDM-4323-1',
	updatedon = now() 	
where intakeservreqchildremovalid = '48ea261b-ca7b-4c05-a54e-6b6d32294989'
	and activeflag = 1 ;

-- Delete Client Eligibility  
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id in (
						251721, 251931, 253370, 252846, 252845, 253560, 251801, 253187, 251529, 252618,
						252797, 251539, 252619, 250605, 252450, 186257, 251047, 251046, 252704, 252567,
						252941, 252865, 253452,
						186257, 250605, 252450 -- with Placements
					)
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4323-1'
where removal_id in (
						251721, 251931, 253370, 252846, 252845, 253560, 251801, 253187, 251529, 252618,
						252797, 251539, 252619, 250605, 252450, 186257, 251047, 251046, 252704, 252567,
						252941, 252865, 253452,
						186257, 250605, 252450 -- with Placements
					)
	and delete_sw = 'N' ;

-- Delete Duplicate Program Assignments
-- e3f6b589-9733-4e91-be86-b494da6dc275	c98c3039-832d-476c-8fb2-0b203a649c4e	186257	2017-08-04 00:00:00	2021-04-02 14:00:00
-- Delete 
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'bea42806-2449-4430-a685-395ea7b2ec28' 
	and personid = 'c98c3039-832d-476c-8fb2-0b203a649c4e'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4323-1',
	updatedon = now() 		
where personprogramid = 'bea42806-2449-4430-a685-395ea7b2ec28' 
	and personid = 'c98c3039-832d-476c-8fb2-0b203a649c4e'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- a31e32c1-1c80-4323-adbd-55cb597c9884	0b717172-4cce-49d9-94b4-d7fe4ee5a7e2	251721	2019-06-17 00:00:00	2021-02-04 13:00:07
-- Delete 
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'eff5aa15-c7d1-44e0-8bfc-015a53e6196f' 
	and personid = '0b717172-4cce-49d9-94b4-d7fe4ee5a7e2'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4323-1',
	updatedon = now() 		
where personprogramid = 'eff5aa15-c7d1-44e0-8bfc-015a53e6196f' 
	and personid = '0b717172-4cce-49d9-94b4-d7fe4ee5a7e2'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 1996bef1-f0e4-4d4f-a4ff-f95cc494719a	c41e8e9a-3920-4b6b-ad1e-9c4a8a7b4399	251801	2020-12-08 00:00:00	2021-03-05 10:00:04
-- Delete 
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'b3120dfe-f74b-47fd-9d07-4bf132a8bdf1' 
	and personid = 'c41e8e9a-3920-4b6b-ad1e-9c4a8a7b4399'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4323-1',
	updatedon = now() 		
where personprogramid = 'b3120dfe-f74b-47fd-9d07-4bf132a8bdf1' 
	and personid = 'c41e8e9a-3920-4b6b-ad1e-9c4a8a7b4399'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- 130c1a0d-644c-4366-8544-e301d125990a	64dda4bc-8393-449e-93e6-8098d7dc0612	251529	2019-02-06 00:00:00	2021-01-26 00:00:00
-- Delete 
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '5eb45d07-44aa-4e9c-94a7-90e9c0a46ae3' 
	and personid = '64dda4bc-8393-449e-93e6-8098d7dc0612'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4323-1',
	updatedon = now() 		
where personprogramid = '5eb45d07-44aa-4e9c-94a7-90e9c0a46ae3' 
	and personid = '64dda4bc-8393-449e-93e6-8098d7dc0612'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- 58f9ecb4-5664-492c-a1eb-44b7282514cf	471086e8-2ed2-476f-80f9-954330f0a255	252845	2021-10-01 00:00:00	
-- Delete 
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid in ('d2e75ade-e592-4db4-b3f6-3de06f8b68fb', '7bd5517b-9c36-4172-a643-1c7e5b909263')
	and personid = '471086e8-2ed2-476f-80f9-954330f0a255'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4323-1',
	updatedon = now() 		
where personprogramid in ('d2e75ade-e592-4db4-b3f6-3de06f8b68fb', '7bd5517b-9c36-4172-a643-1c7e5b909263')
	and personid = '471086e8-2ed2-476f-80f9-954330f0a255'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- 48ea261b-ca7b-4c05-a54e-6b6d32294989	d7ac18cd-6839-4240-ac31-a8746d48c9d7	252450	2021-05-31 00:00:00	2021-06-02 15:00:00
-- Delete
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid in ('a43c3d69-cdbf-465e-8fc7-e4c81cd1f469', '98ebe15a-4e63-464c-8db2-323927efd93a')
	and personid = 'd7ac18cd-6839-4240-ac31-a8746d48c9d7'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4323-1',
	updatedon = now() 		
where personprogramid in ('a43c3d69-cdbf-465e-8fc7-e4c81cd1f469', '98ebe15a-4e63-464c-8db2-323927efd93a')
	and personid = 'd7ac18cd-6839-4240-ac31-a8746d48c9d7'
	and programkey = 'OOH'
	and activeflag = 1 ;
