-- CDM-17794 - Duplicate child with removal
/*
-- Issue Description: 
   user request to delete the Invalid Removal of the duplicate client.  
    
-- Case ID: 211030008142
-- Client ID: 200775142	(Sumiyha Duplicate Avery) - 86556655-86e1-4dce-b342-248263653f24
-- Removal ID: 252247 - 2021-06-21 To 2021-06-21 - 5d07e975-408e-4001-85ab-1267b93b22c1
	
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252247
	and rm.personid = '86556655-86e1-4dce-b342-248263653f24' 
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0; 
	
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-17794',
	rm.updatedon = now() 		
where rm.removalid = 252247
	and rm.personid = '86556655-86e1-4dce-b342-248263653f24' 
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0; 

select * 
	from routing ro 
where ro.eventcode = 'CHRR'
	and ro.objectid = '5d07e975-408e-4001-85ab-1267b93b22c1'
	and ro.activeflag = 1 
		and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid::character varying = ro.objectid
			and pl.activeflag = 1
		) = 0; 

update routing ro
set activeflag = 0,
	updatedby = 'CDM-17794',
	updatedon = now()
where ro.eventcode = 'CHRR'
	and ro.objectid = '5d07e975-408e-4001-85ab-1267b93b22c1'
	and ro.activeflag = 1 
		and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid::character varying = ro.objectid
			and pl.activeflag = 1
		) = 0; 
