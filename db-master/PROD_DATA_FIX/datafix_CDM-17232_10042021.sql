-- CDM-17232 - Please delete removal in Draft status
/*
-- Issue Description: 
   User request to delete the removal dated 9/24/21 that is in Draft status on case # 211020143235.
   
-- CPS-IR ID: 211020143235 - 40e86371-4ba7-4ee8-ab95-912fee9b011e
-- Client ID: 200809933 (Juma Barker) - dd2ddaab-d3f7-4f21-a400-94d177ad516c
-- Associated Case ID: 211030011182 - 675e374e-4bc3-43fb-83de-f72aad4e246e

-- Delete 
-- 252834 - 2021-09-23 To current - acafbdf1-44d8-43b6-8be8-93267398304f
-- 252825 - 2021-09-24 To current - b4e77f6d-bea1-43f4-a691-fa6e5c04a68e

-- Update intakeserviceid
-- 252844 - 2021-09-23 To current - 6418063d-4f7e-41a9-81ed-9550d5f0a270
 
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid in ( 252834, 252825 )
	and rm.personid = 'dd2ddaab-d3f7-4f21-a400-94d177ad516c'
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
	rm.updatedby = 'CDM-17232',
	rm.updatedon = now() 		
where rm.removalid in ( 252834, 252825 )
	and rm.personid = 'dd2ddaab-d3f7-4f21-a400-94d177ad516c'
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
		
-- Update intakeserviceid
select rm.removalid, rm.removaldate, rm.exitdate, rm.intakeserviceid, rm.servicecaseid, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252844
	and rm.personid = 'dd2ddaab-d3f7-4f21-a400-94d177ad516c'
	and rm.activeflag = 1;	

update intakeservreqchildremoval rm
set rm.intakeserviceid = '40e86371-4ba7-4ee8-ab95-912fee9b011e',
	rm.updatedby = 'CDM-17232',
	rm.updatedon = now() 
where rm.removalid = 252844
	and rm.personid = 'dd2ddaab-d3f7-4f21-a400-94d177ad516c'
	and rm.activeflag = 1;	
