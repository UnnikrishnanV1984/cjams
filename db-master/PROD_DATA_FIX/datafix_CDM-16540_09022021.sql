-- CDM-16540 - Baltimore City Unapproved removals with placement 
/*
-- Issue Description: 
   Datafix to link those Placements with Approved Removals 
   and remove the Un-Approved Removals in Draft status (Duplicate/Overlapping) 
    
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1)
-- Case ID: 3172977	- Baltimore City
-- Client ID: 1642883 (ANTWOINE ROBINSON) - 49e3c09e-2ffe-49da-98e7-2506e2d9510e
-- Removals 
-- 167349	2014-04-08 To Current - d930ac40-778a-4399-96d9-45f40ef93f00 (Approved)
-- 251116	2014-04-08 To Current - 66d092e9-432f-48b9-b855-109c56203699 (Draft)


-- Link to Removal_ID 167349 and delete 251116 status is draft 
/*
1558838	PRPL	2020-10-26 00:00:00	2021-03-01 00:00:00	5090529
1562017	PRPL	2021-03-01 00:00:00						5090529	
*/

select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = '66d092e9-432f-48b9-b855-109c56203699'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= 'd930ac40-778a-4399-96d9-45f40ef93f00',
	updatedby = 'CDM-16540',
	updatedon = now() 	
where intakeservreqchildremovalid = '66d092e9-432f-48b9-b855-109c56203699'
	and activeflag = 1 ;

	
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251116
	and rm.personid = '49e3c09e-2ffe-49da-98e7-2506e2d9510e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16540',
	rm.updatedon = now() 		
where rm.removalid = 251116
	and rm.personid = '49e3c09e-2ffe-49da-98e7-2506e2d9510e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	


-- 2)
-- Case ID: 3258529	- Baltimore City
-- Delete Removals & Nullify the removal Ids from associated Placements (LAs)

-- Client ID: 3704295 (CAMERON BLAKE) - b3f7fa56-1a74-405f-a8ee-c08a8898ec89
-- Removal: 251332	2020-12-14 To Current - b0297a5c-074a-49e4-b9b4-1dc7233b6d56
-- Placement ID: 1559761 LA

select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = 'b0297a5c-074a-49e4-b9b4-1dc7233b6d56'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= NULL,
	updatedby = 'CDM-16540',
	updatedon = now() 	
where intakeservreqchildremovalid = 'b0297a5c-074a-49e4-b9b4-1dc7233b6d56'
	and activeflag = 1 ;


select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon
	from intakeservreqchildremoval rm 
where rm.removalid = 251332
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16540',
	rm.updatedon = now() 	
where rm.removalid = 251332
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
-- Client ID: 3934939 (CARSON JEREMIAH BLAKE) - 21f4039e-e157-4759-a024-a1e95a4cd050
-- Removal: 251333	2020-12-14 To Current -	9419c2f1-35ac-4281-9813-c7eae454195c 
-- Placement ID: 1559767 LA

select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = '9419c2f1-35ac-4281-9813-c7eae454195c'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= NULL,
	updatedby = 'CDM-16540',
	updatedon = now() 	
where intakeservreqchildremovalid = '9419c2f1-35ac-4281-9813-c7eae454195c'
	and activeflag = 1 ;		
	

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon
	from intakeservreqchildremoval rm 
where rm.removalid = 251333
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16540',
	rm.updatedon = now() 	
where rm.removalid = 251333
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	
		
-- 3)
-- Case ID: 3303685	- Baltimore City		
-- Client ID: 3947162 (DENIYA MCCULLOUGH) - 005eb8d0-ce40-4cb1-b052-1031f12bb6d8

-- Removals 
-- 250890	2016-05-09 To 2020-09-15 - 84c1d80e-c1b8-4adc-a6d3-810ba91b0d20 (Approved)
-- 250920	2016-05-09 To Current 	 - 390e4396-2e01-4fee-98a4-498e75357647 (Draft)

-- Link to Removal_ID 250890 and delete 250920 status is draft 
/*
1558668	PRPL	2020-01-03 00:00:00	2020-10-28 11:58:00	5030501
1558669	PRPL	2020-01-03 00:00:00	2020-07-01 00:00:00	5030501
*/

select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = '390e4396-2e01-4fee-98a4-498e75357647'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= '84c1d80e-c1b8-4adc-a6d3-810ba91b0d20',
	updatedby = 'CDM-16540',
	updatedon = now() 	
where intakeservreqchildremovalid = '390e4396-2e01-4fee-98a4-498e75357647'
	and activeflag = 1 ;


select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250920
	and rm.personid = '005eb8d0-ce40-4cb1-b052-1031f12bb6d8'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16540',
	rm.updatedon = now() 		
where rm.removalid = 250920
	and rm.personid = '005eb8d0-ce40-4cb1-b052-1031f12bb6d8'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	



-- 4)
-- Case ID: 3217442 - Charles
-- Client ID: 200012928 (James Edward Wright) - 6d0b5d13-bb2f-4258-8aa5-a3f788115a25

-- Removals 
-- 250449	2020-06-06 To Current - 2f1fefe6-3d1e-41e6-8256-73f209e7d8a2 (Approved)
-- 250752	2020-06-05 To Current - d1debc77-a3f9-439e-8b26-db41ad69cb31 (Draft)

-- Link to Removal_ID 250449 and delete 250752 status is draft 

/*
1558143	PRPL	2020-08-01 00:00:00	To Current	5054317
*/

select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = 'd1debc77-a3f9-439e-8b26-db41ad69cb31'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= '2f1fefe6-3d1e-41e6-8256-73f209e7d8a2',
	updatedby = 'CDM-16540',
	updatedon = now() 	
where intakeservreqchildremovalid = 'd1debc77-a3f9-439e-8b26-db41ad69cb31'
	and activeflag = 1 ;
	

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250752
	and rm.personid = '6d0b5d13-bb2f-4258-8aa5-a3f788115a25'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16540',
	rm.updatedon = now() 		
where rm.removalid = 250752
	and rm.personid = '6d0b5d13-bb2f-4258-8aa5-a3f788115a25'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;		
		
-- 5)
-- Case ID: 3272699	- Frederick
-- Client ID: 1294518 (TEAGAN TREGANOWAN) - 51ff40b2-e7b4-4037-a294-30444f8b62c0

-- Removals 
-- 251056	2020-09-22 To 2020-09-23 - 2a937e21-b6c3-4212-95b4-b67caaebf267 (Approved)
-- 251066	2020-09-22 To Current    - 8585524e-8854-45aa-8b86-328b39c04055 (Rejetced)

-- Link to Removal_ID 251056
/*
1560356	LA	2020-09-23 00:00:00
*/

select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = '8585524e-8854-45aa-8b86-328b39c04055'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= '2a937e21-b6c3-4212-95b4-b67caaebf267',
	updatedby = 'CDM-16540',
	updatedon = now() 	
where intakeservreqchildremovalid = '8585524e-8854-45aa-8b86-328b39c04055'
	and activeflag = 1 ;
	
	
-- 6)	
-- Case ID: 3272699	- Frederick
-- Client ID: 2474963 (TARYN ROSE TREGANOWAN) - 2d1c3ba3-8ee9-48e9-b5d8-03a38f4b6aa4

-- Removals 
-- 251057	2020-09-22 To 2020-09-23 - 98c89ecf-b238-4d5f-a580-21a1ab84bca2 (Approved)
-- 251067	2020-09-22 To Current    - 962e2f78-a65a-4796-b0e6-5062f3d4d8f6 (Rejetced)

-- Link to Removal_ID 251057
/*
1560355	LA	2020-09-23 00:00:00
*/

select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = '962e2f78-a65a-4796-b0e6-5062f3d4d8f6'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= '98c89ecf-b238-4d5f-a580-21a1ab84bca2',
	updatedby = 'CDM-16540',
	updatedon = now() 	
where intakeservreqchildremovalid = '962e2f78-a65a-4796-b0e6-5062f3d4d8f6'
	and activeflag = 1 ;
	
-- 7) 
-- Case ID: 3240006 - Montgomery
-- Client ID: 3322852 (DAJAH COLBERT) - 1f698196-5929-4906-ae3f-532f95d42908

-- Removals 
-- 252098	2021-05-24 To 2021-05-25 - a89b806d-7317-4258-8352-e1e5b4f3f5fa (Approved)
-- 252122	2021-05-24 To Current    - d0454503-7279-483b-9bab-0586fdacc96f (Rejected)

-- Link to Removal_ID 252098
/*
1563471	LA	2021-05-25 18:00:00
*/

select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = 'd0454503-7279-483b-9bab-0586fdacc96f'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= 'a89b806d-7317-4258-8352-e1e5b4f3f5fa',
	updatedby = 'CDM-16540',
	updatedon = now() 	
where intakeservreqchildremovalid = 'd0454503-7279-483b-9bab-0586fdacc96f'
	and activeflag = 1 ;	

