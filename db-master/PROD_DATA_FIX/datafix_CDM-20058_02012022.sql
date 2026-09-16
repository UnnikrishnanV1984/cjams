-- CDM-20058 - Placement tab
/*
-- Issue Description: 
   3 childrens in the Case # 3287567 having duplicate Removals
 
-- Case ID: 3287567 
-- Client ID: 200013634	(Justin Mitter) - 1036eb70-9336-4f05-9e2c-b56102d976d8
-- Removal IDs: 250473 & 250470
-- Client ID: 200013348	(ABEL L	MITTER) - 1231688f-d923-4427-bf9f-59cad6e350f0
-- Removal IDs: 250474 & 250471
-- Client ID: 200013350	(JADEN RIORDAN) - edf39735-9395-4d50-9701-56a7ba33ec78
-- Removal IDs: 250475 & 250472
 
-- Category/ Module: Child Removals (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Delete un-approved duplicate removals
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.servicecaseid, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid in ( 250473, 250470, 250474, 250471, 250475, 250472 )
--	and rm.personid = ??
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-20058',
	rm.updatedon = now()
where rm.removalid in ( 250473, 250470, 250474, 250471, 250475, 250472 )
--	and rm.personid = ??
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- Delete duplicate OOH 
-- Client ID: 200013350	(JADEN RIORDAN)
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'ae2005d1-15a8-4fd1-9129-006d8294c8e8' 
	and personid = 'edf39735-9395-4d50-9701-56a7ba33ec78'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CDM-20058',
	updatedon = now() 		
where personprogramid = 'ae2005d1-15a8-4fd1-9129-006d8294c8e8' 
	and personid = 'edf39735-9395-4d50-9701-56a7ba33ec78'
	and programkey = 'OOH'
	and activeflag = 1 ;
