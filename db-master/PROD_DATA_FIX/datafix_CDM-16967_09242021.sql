-- CDM-16967 Removal
/*
-- Issue Description: 
   This child has duplicate removals for the same date. 
   The draft removal needs to be removed from the system.
   
-- Case ID: 3299216
-- Client ID: 4319180 (Da'Nia Elizabeth Nashay	Horton) - 9a96b396-d6d1-4049-bce3-1d753d00996b
-- Removals:
-- 252356	2020-08-14 To Current - 6827d0e2-7384-4dec-b98f-0ab4e5e335d4 (Draft - Delete)
-- 250728	2020-08-14 To 2021-06-29 - 658e3c3a-57c9-40a3-b461-04c6e105b00b (Approved)
 
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252356
	and rm.personid = '9a96b396-d6d1-4049-bce3-1d753d00996b'
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
	rm.updatedby = 'CDM-16967',
	rm.updatedon = now() 		
where rm.removalid = 252356
	and rm.personid = '9a96b396-d6d1-4049-bce3-1d753d00996b'
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
		