-- CIDM-3828 
-- Baltimore City - "Overlapping Removals (Clients with at least one Active Removal)"

-- 1)
-- Case ID: 2020026803217 - Baltimore City
-- Client ID: 200148238	AUSTIN	ISAIAH	HARRIS	08264f90-eb4c-4e53-bd87-6ae35c60d218
-- Removals 
-- 251313	Approved	9/5/2020	5/18/2021	3d30932d-06dd-41d0-9aa6-63cc4264e9e6
-- 250966	Draft		9/5/2020				283e9aee-eadf-45fb-b129-3b6734191960 (Delete)

-- Delete removal # 250966 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250966
	and rm.personid = '08264f90-eb4c-4e53-bd87-6ae35c60d218'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 250966
	and rm.personid = '08264f90-eb4c-4e53-bd87-6ae35c60d218'
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
-- Case ID: 3057171	Baltimore City
-- Client ID: 200794740	Tyler Thompson	1c001f8c-361b-401c-942a-1e3cc102d9ab
-- Removals 
-- 252581	Draft		8/16/2021				3e986115-37b5-4524-8ba2-a97331c30875
-- 252595	Approved	8/16/2021	8/17/2021	bd9bb14d-2296-4ba5-881c-13e3e26a5001

-- Delete removal # 252581 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252581
	and rm.personid = '1c001f8c-361b-401c-942a-1e3cc102d9ab'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 252581
	and rm.personid = '1c001f8c-361b-401c-942a-1e3cc102d9ab'
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
	

-- Update OOH
select startdate, enddate, programkey, updatedby, updatedon 
	from personprogramarea  
where personprogramid = 'd580fadb-7637-4779-a337-514d1c260c4b'
	and activeflag = 1 ;

update personprogramarea
set startdate = enddate,
	activeflag = 0,
	updatedby = 'CIDM-3828',
	updatedon = now()
where personprogramid = 'd580fadb-7637-4779-a337-514d1c260c4b'
	and activeflag = 1 ;	

-- 3)
-- Case ID: 3057171	Baltimore City
-- Client ID: 200794743	Alexa Thompson	200213d5-5f79-4f76-9cb6-db7222f6c384
-- Removals 
-- 252582	Draft		8/16/2021				70077b93-b92e-488e-a2b4-d98f05521ce1
-- 252593	Approved	8/16/2021	8/17/2021	229312f6-0cc4-4f51-a861-87f4b358c9b8

-- Delete removal # 252582 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252582
	and rm.personid = '200213d5-5f79-4f76-9cb6-db7222f6c384'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 252582
	and rm.personid = '200213d5-5f79-4f76-9cb6-db7222f6c384'
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
-- Case ID: 2020035004797	Baltimore City
-- Client ID: 4080653	KHLOE GBORPLAY 3fff3b64-e7fa-4a18-9934-6ef00a949c10
-- Removals 
-- 251325	Draft		12/12/2020				1838ea17-2ed7-4292-96a9-b670d0a4c82d
-- 251339	Approved	12/12/2020	1/12/2021	2252ea25-c494-4d3f-b65c-6bdfbb673e22

-- Delete removal # 251325 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251325
	and rm.personid = '3fff3b64-e7fa-4a18-9934-6ef00a949c10'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 251325
	and rm.personid = '3fff3b64-e7fa-4a18-9934-6ef00a949c10'
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
-- Case ID: 2020021602146	Baltimore City
-- Client ID: 200157126	Caiden Kinsey	45c55f1e-fc38-44f4-ac79-86e55cb029e6
-- Removals 
-- 251285	Review		10/5/2020				d86a26c4-5191-42c2-84a6-c0ee71619932
-- 251287	Approved	10/5/2020	10/7/2020	9426b794-1ca7-476c-ac11-6bd6b7449605

-- Delete removal # 251285 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251285
	and rm.personid = '45c55f1e-fc38-44f4-ac79-86e55cb029e6'
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
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 251285
	and rm.personid = '45c55f1e-fc38-44f4-ac79-86e55cb029e6'
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
	
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'd86a26c4-5191-42c2-84a6-c0ee71619932'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-3828',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'd86a26c4-5191-42c2-84a6-c0ee71619932'
	and ro.activeflag = 1 ;	


-- 6)
-- Case ID: 202100505187 Baltimore City
-- Client ID: 200300776	Kashaii	H Diggs	678ed357-a6db-4c7b-a725-f814c1bf40ba
-- Removals 
-- 251412	Approved	12/30/2020	1/15/2021	4daa1a39-d1f9-4f6e-a432-9de1ff15a1e1
-- 251410	Review		12/30/2020				71632d58-7c17-49ef-a7f2-3beee5471de9

-- Delete removal # 251410 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251410
	and rm.personid = '678ed357-a6db-4c7b-a725-f814c1bf40ba'
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
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 251410
	and rm.personid = '678ed357-a6db-4c7b-a725-f814c1bf40ba'
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
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '71632d58-7c17-49ef-a7f2-3beee5471de9'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-3828',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '71632d58-7c17-49ef-a7f2-3beee5471de9'
	and ro.activeflag = 1 ;			
	
-- 7)
-- Case ID: 3169886	Baltimore City
-- Client ID: 2499114 Richard Alan Carter 7350ee73-d7df-4b5f-b193-b75d427f52d5
-- Removals 	
-- 250502	Review		6/16/2020				9aaf5b4a-f2f4-4a10-9bce-6517d01fad05
-- 200051	Approved	6/16/2020	8/17/2020	e3b81a41-ce46-4019-9d7a-583c2fe2d4e2

-- Delete removal # 250502 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250502
	and rm.personid = '7350ee73-d7df-4b5f-b193-b75d427f52d5'
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
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 250502
	and rm.personid = '7350ee73-d7df-4b5f-b193-b75d427f52d5'
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

		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '9aaf5b4a-f2f4-4a10-9bce-6517d01fad05'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-3828',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '9aaf5b4a-f2f4-4a10-9bce-6517d01fad05'
	and ro.activeflag = 1 ;	
	
	
-- 8)
-- Case ID: 211030008940 Baltimore City 
-- Client ID: 200772430	Mustapha Kehinde - 7f3e9731-4f26-405f-af7a-061993cd24c0
-- Removals 
-- 252269	Draft		6/13/2021				bd73924a-eda7-49d8-8e6a-4a11171154ef
-- 252293	Approved	6/13/2021	7/14/2021	01782fe1-547f-4712-9949-66e0da937b01

-- Delete removal # 252269 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252269
	and rm.personid = '7f3e9731-4f26-405f-af7a-061993cd24c0'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 252269
	and rm.personid = '7f3e9731-4f26-405f-af7a-061993cd24c0'
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
		

-- 9)
-- Case ID: 3057171	Baltimore City
-- Client ID: 200794746	Arrianna Cunningham	- bc7104a4-1276-450a-9cb2-4a0638c0e39d
-- Removals
-- 252594	Approved	8/16/2021	8/17/2021	c0ccb63e-1de4-4e8b-802f-e7a5de4adce8
-- 252583	Draft		8/16/2021				ef034401-126e-46e9-9caa-d2b7319f3bf1 

-- Delete removal # 252583 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252583
	and rm.personid = 'bc7104a4-1276-450a-9cb2-4a0638c0e39d'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 252583
	and rm.personid = 'bc7104a4-1276-450a-9cb2-4a0638c0e39d'
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
		

-- 10)
-- Case ID: 3171864	Baltimore City
-- Client ID: 1665579 DOMINIK M	MCCRAE - bcc45a62-26d3-4f15-96e5-30a131d4ca27
-- Removals 
-- 251081	Draft		10/14/2020				79592a71-157c-4320-8788-b556431f72c0
-- 251172	Approved	10/14/2020	10/15/2020	e9b439d7-f8f5-48a7-928a-65fa27f1dd9a

-- Delete removal # 251081 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251081
	and rm.personid = 'bcc45a62-26d3-4f15-96e5-30a131d4ca27'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 251081
	and rm.personid = 'bcc45a62-26d3-4f15-96e5-30a131d4ca27'
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
		
-- 11)
-- Case ID: 202105706232 Baltimore City
-- Client ID: 200566817	Jacson  Rivas-Hernandez - c0e66852-42bb-4120-8437-bb82a575f5b6
-- Removals 
-- 251627	Approved	2/15/2021	4/14/2021	f7d168bc-fc0d-413c-a998-7788200b7a9b
-- 251958	Draft		2/15/2021				81dda1fc-2b39-4a82-98e3-b4986eada7ba

-- Delete removal # 251958 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251958
	and rm.personid = 'c0e66852-42bb-4120-8437-bb82a575f5b6'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 251958
	and rm.personid = 'c0e66852-42bb-4120-8437-bb82a575f5b6'
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

-- 12)
-- Case ID: 2020024702818 Baltimore City
-- Client ID: 1938151 ALEXANDER ALLEN - d9000d76-2645-43ab-aed4-d6dc30cf4fa6
-- Removals 
-- 250958	Approved	8/28/2020	1/26/2021	dd230b68-ca90-4726-b85c-b66cbdf7a0ff
-- 250825	Approved	8/28/2020				63031315-65b4-45bb-ba0d-4cdb745f9a13

-- Delete removal # 250825 - No associated placements
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250825
	and rm.personid = 'd9000d76-2645-43ab-aed4-d6dc30cf4fa6'
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
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 250825
	and rm.personid = 'd9000d76-2645-43ab-aed4-d6dc30cf4fa6'
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

		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '63031315-65b4-45bb-ba0d-4cdb745f9a13'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-3828',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '63031315-65b4-45bb-ba0d-4cdb745f9a13'
	and ro.activeflag = 1 ;	
	

select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 250825
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CIDM-3828',
	update_ts = now()
where removal_id = 250825
	and delete_sw = 'N' ;	
	
	
-- 13)
-- Case ID: 211030008940 Baltimore City
-- Client ID: 200772431	Saheedat Kehinde - dd1d27db-f118-49f3-ac2d-7dc9b8f49178 
-- Removals 
-- 252287	Approved	6/13/2021	6/14/2021	fb7b6569-60ea-4089-b99b-2f37b18fe25a
-- 252270	Draft		6/13/2021				c36833b5-f62c-48ab-93b1-8c21914cce40

-- Delete removal # 252270 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252270
	and rm.personid = 'dd1d27db-f118-49f3-ac2d-7dc9b8f49178'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 252270
	and rm.personid = 'dd1d27db-f118-49f3-ac2d-7dc9b8f49178'
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

-- 14)
-- Case ID: 2020035004797 Baltimore City
-- Client ID: 200296548	Zuri Ellison - e021518a-0aef-45e8-ac1e-8e94c829b0b3
-- Removals 
-- 251324	Draft		12/12/2020				c16fdbf9-678c-4985-b5e3-7c8f012caec5
-- 251340	Approved	12/12/2020	1/12/2021	1be94aa9-3df1-4145-a95f-06f4e4e7c6c5

-- Delete removal # 251324 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251324
	and rm.personid = 'e021518a-0aef-45e8-ac1e-8e94c829b0b3'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 251324
	and rm.personid = 'e021518a-0aef-45e8-ac1e-8e94c829b0b3'
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

-- 15)
-- Case ID: 211030010338 Baltimore City
-- Client ID: 4028439 ROSEMARY RIVERA-PAZ e0d433bc-6e56-4efe-9408-7b17d85efa91
-- Removals 
-- 252610	Draft		8/21/2021		69a85b8f-70e8-41e5-b249-30f13fa280e7
-- 252614	Approved	8/21/2021		6935458f-595e-4d20-bf7d-221bc67db167
-- 252613	Approved	8/21/2021		32f8c740-aba5-45e0-b58d-b1599a326df5

-- Delete removal # 252613 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252613
	and rm.personid = 'e0d433bc-6e56-4efe-9408-7b17d85efa91'
	and rm.activeflag = 1 ;
	
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 252613
	and rm.personid = 'e0d433bc-6e56-4efe-9408-7b17d85efa91'
	and rm.activeflag = 1 ;
	
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '32f8c740-aba5-45e0-b58d-b1599a326df5'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-3828',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '32f8c740-aba5-45e0-b58d-b1599a326df5'
	and ro.activeflag = 1 ;	
	
-- 1565820 link to 252614 (6935458f-595e-4d20-bf7d-221bc67db167)
select alternateid, placementtypekey, altproviderid, intakeservreqchildremovalid, updatedby, updatedon 
	from placement
where alternateid = 1565820
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid = '6935458f-595e-4d20-bf7d-221bc67db167',
	updatedon = now(), 
	updatedby = 'CIDM-3828'
where alternateid = 1565820
	and activeflag = 1 ;
	
	
-- Delete removal # 252610 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252610
	and rm.personid = 'e0d433bc-6e56-4efe-9408-7b17d85efa91'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 252610
	and rm.personid = 'e0d433bc-6e56-4efe-9408-7b17d85efa91'
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
		
		

-- 16)
-- Case ID: 2020025702987 Baltimore City
-- Client ID: 2236922 BLESSED WALLACE - efd968cf-7037-4e8d-8fe9-0db5c63fa708
-- Removals 
-- 250873	Draft		9/11/2020				f9fc4e7b-2270-48f6-aafd-a723ab852383
-- 250910	Approved	9/11/2020	6/10/2021	3eb7a228-32c9-402c-a610-8c9b7383c169

-- Delete removal 250873  - No associated placements, NO IV-E and Active OOH 		
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250873
	and rm.personid = 'efd968cf-7037-4e8d-8fe9-0db5c63fa708'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 250873
	and rm.personid = 'efd968cf-7037-4e8d-8fe9-0db5c63fa708'
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
		
-- 17)
-- Case ID: 3307882	Baltimore City
-- Client ID: 4493588 EVELYN MEJIA-MARTINEZ - fa000e1d-ca4c-4c65-9af9-538fb54b599a
-- Removals 
-- 250530	Draft		6/8/2020				bf3ca3f2-d787-4e35-9760-e0780aa7df90
-- 200020	Approved	6/8/2020	6/30/2021	1d8400da-36c5-497a-b6a1-f5441a61da12

-- Delete removal # 250530 - No associated placements, NO IV-E and Active OOH 		
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250530
	and rm.personid = 'fa000e1d-ca4c-4c65-9af9-538fb54b599a'
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
	rm.updatedby = 'CIDM-3828',
	rm.updatedon = now() 		
where rm.removalid = 250530
	and rm.personid = 'fa000e1d-ca4c-4c65-9af9-538fb54b599a'
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
		
