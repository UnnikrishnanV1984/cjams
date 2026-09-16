-- CDM-17793 - Duplicate removals
/*
-- Issue Description: 
   User request to delete the Duplicate Child Removal in Draft Status.  
    
-- Case ID: 3124392
-- Client ID: 1755386 (PATRICIA	R FORTNEY) - 35c4ef27-9004-4d45-a3c1-c45aee6dcd88
-- Removal ID: 252921 - 2005-01-06 To Current - 76a7834d-fc95-481a-8e71-b061c9382e03 (Draft)

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252921
	and rm.personid = '35c4ef27-9004-4d45-a3c1-c45aee6dcd88' 
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0; 
	
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-17793',
	rm.updatedon = now() 		
where rm.removalid = 252921
	and rm.personid = '35c4ef27-9004-4d45-a3c1-c45aee6dcd88' 
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0; 

