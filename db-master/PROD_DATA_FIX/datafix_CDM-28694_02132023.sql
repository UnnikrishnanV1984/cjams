-- CDM-28694 - Duplicate Person
/*
-- Issue Description: 
	User reuest to remove the duplicate Removal of Duplicate Person 

-- Case ID: 2020013301213
-- Client ID: 200006124 (AIDAN	MORGAN (Duplicate) GEORGE) - 3437aecd-7fdf-48a0-803b-f1123b6c0dea
-- Removal ID: 253327 - 2021-12-17 To Current - 7b76514d-f44e-420d-9cb6-3f789f98c18c

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: As a part of S20210357036443 - CDM-19337, the Duplicate Person was removed from the Service case # 2020013301213.
--			   This draft removal was missed in that fix.
-- Fix Provided: Datafix has been promoted to delete the requested Removal.   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove the Duplicate Removal
-- Delete 250459	2020-06-10 to 2021-02-19  - 2386501a-e8b2-4365-b7a8-40dbb6c86d41

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253327
	and rm.personid = '3437aecd-7fdf-48a0-803b-f1123b6c0dea'
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
set exitdate = removaldate, 
	activeflag = 0,
	updatedby = 'CDM-28694',
	updatedon = now()
where rm.removalid = 253327
	and rm.personid = '3437aecd-7fdf-48a0-803b-f1123b6c0dea'
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
		
-- No Associated Placement, Routing, OOH and IV-E 