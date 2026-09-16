-- CDM-12487 - Adoption Suspension Not Working
/*
-- Issue Description: 
	The adoption suspension function is not working. 
    The worker has submitted suspension multiple times and I as the supervisor have approved it but it is not showing approved! 
   
	Case ID: 3241813
	Client ID: 3687250 (DAVID ANNAN) - 8edccb17-a558-4793-8357-001e3986f17f
    Adoption ID: 41084
	
-- Category/ Module: Adoption Subsidy  Suspension (Adoption Case Management) 
-- Root cause: This was a routingconfig issue, the fix was provided as a part of CDM-12476 
			   for Case ID: 3241817 the datafix is part of this script
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

select suspensionbegindate, suspensionenddate, activeflag, updatedby, updatedon 
	from adoptioncasesuspension 
where adoptionsuspensionid
	in ( 	'd06dbe7f-4bd8-4efb-90da-2a779f392346',
			'c3f67c30-a084-4cd4-8dd4-228643a05eb4',
			'9735a3b5-e367-4a67-86df-cde7e9edd857'
		)
and activeflag = 1 ;

update adoptioncasesuspension
set activeflag = 0,
	updatedby = 'CDM-12487',
	updatedon = now()
where adoptionsuspensionid
	in ( 	'd06dbe7f-4bd8-4efb-90da-2a779f392346',
			'c3f67c30-a084-4cd4-8dd4-228643a05eb4',
			'9735a3b5-e367-4a67-86df-cde7e9edd857'
		)
	and activeflag = 1 ;
	
-- CDM-12476 -  Case ID :3241817 
-- datafix has been promoted to remove Suspension records, please ask the user to add new suspension starting 01/13/2021
select suspensionbegindate, suspensionenddate, activeflag, updatedby, updatedon 
	from adoptioncasesuspension 
where adoptionsuspensionid = '61077321-4819-4c1d-8860-a4b259ee40c3'
	and activeflag = 1 ;
	
update adoptioncasesuspension
set activeflag = 0,
	updatedby = 'CDM-12476',
	updatedon = now()
where adoptionsuspensionid = '61077321-4819-4c1d-8860-a4b259ee40c3'
	and activeflag = 1 ;
	
	