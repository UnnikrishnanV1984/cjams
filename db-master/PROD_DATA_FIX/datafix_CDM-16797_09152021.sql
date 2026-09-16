-- CDM-16797 - Duplicate removals
/*
-- Issue Description: 
   This child has duplicate removals for the same date. 
   The active one needs to be removed for the list. 
   
-- Case ID: 202100505174 - 3d789c3d-5c59-483f-823e-006a4a3d83dd
-- Client ID: 200154009	(Shamar Lewis) - 981b99c3-1730-4890-8031-b9993c387430
-- Removals:
-- 251396	2021-01-04 To 2021-01-07 - 9e58e9a2-aeca-4b4c-9f7d-7e8340d2d76f (Approved)
-- 251394	2021-01-04 To Current	 - f6101536-ae61-4ce2-8bc3-5dc6e07a89b1 (Draft - Delete)
  
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251394
	and rm.personid = '981b99c3-1730-4890-8031-b9993c387430'
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
	rm.updatedby = 'CDM-16797',
	rm.updatedon = now() 		
where rm.removalid = 251394
	and rm.personid = '981b99c3-1730-4890-8031-b9993c387430'
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
