-- CDM-33088 - Case suspended in error
/*
--	Issue Description: 
	User Error, The provider indentity was changed in CJAMS (on Provider module side) 
    
-- Adoption Case ID: 3221454
-- Client ID: 3488525 (NEVAEH FAITH	JONES) - becdfc10-cdef-404b-8a85-64f62d6220d7
-- Adoption ID: 36208 - 2013-02-22 To 2029-04-15 - 7ae9c372-b38e-4bd3-b4b1-0862f9221df0
-- Suspension ID: 76bca3fd-f427-4522-a402-4d444ab30087 - 2023-05-11 To 2023-05-18

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User Error	
-- Fix Provided: Datafix has been promoted to End date the suspension and trigger the under over batch.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Update Suspension End date & trigger under-over batch (CDM-33088)
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = '76bca3fd-f427-4522-a402-4d444ab30087'
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set suspensionenddate = suspensionbegindate,
	approvaldate = now(),
	updatedby = 'CDM-33088',
	updatedon = now()
where adoptionsuspensionid = '76bca3fd-f427-4522-a402-4d444ab30087'
	and activeflag = 1 ;	

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid = '76bca3fd-f427-4522-a402-4d444ab30087'
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set suspensionenddate = suspensionbegindate,
	approvaldate = now(),
	updatedby = 'CDM-33088',
	updatedon = now()
where adoptionsuspensionid = '76bca3fd-f427-4522-a402-4d444ab30087' 
	and activeflag = 1 ;	
