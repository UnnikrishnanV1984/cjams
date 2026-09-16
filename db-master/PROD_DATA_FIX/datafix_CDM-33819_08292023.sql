-- CDM-33819 - Adoption Provider Switch
/*
--	Issue Description: 
	To fix overlapping Adoption suspensions
    
-- Adoption Case ID: 3205634
-- Client ID: 3291841 (KYLE	ALEXANDER YOUNGALSTON) - b778648b-3d05-4f1f-a404-3d233740e169
-- Adoption ID: 32324 - 2011-10-11 To 2026-08-31 - c0c0b3a1-e712-4681-93f3-a53a791889d0
-- New Provider ID: 6067957 (KATRINA YOUNG)
-- Old Provider ID: 5013081 (SHARON ALSTON)

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User Error	
-- Fix Provided: Datafix has been promoted to fix the overlapping Adoption suspensions.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix the overlapping Adoption suspensions (CDM-33819)
-- Delete 
-- 4ed3bc29-358a-4519-a2ec-e22281c0cbaa	2022-12-29 05:00:00	2023-05-11 04:00:00
-- dc55849e-b3d8-4429-b6c5-9f08ad7168b6	2023-05-11 04:00:00	2023-05-12 04:00:00
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid 
	in (	'4ed3bc29-358a-4519-a2ec-e22281c0cbaa',
			'dc55849e-b3d8-4429-b6c5-9f08ad7168b6'
		)	
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set activeflag = 0,
	updatedby = 'CDM-33819',
	updatedon = now()
where adoptionsuspensionid 
	in (	'4ed3bc29-358a-4519-a2ec-e22281c0cbaa',
			'dc55849e-b3d8-4429-b6c5-9f08ad7168b6'
		)	
	and activeflag = 1 ;	

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid 
	in (	'4ed3bc29-358a-4519-a2ec-e22281c0cbaa',
			'dc55849e-b3d8-4429-b6c5-9f08ad7168b6'
		)	
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set activeflag = 0,
	updatedby = 'CDM-33819',
	updatedon = now()
where adoptionsuspensionid 
	in (	'4ed3bc29-358a-4519-a2ec-e22281c0cbaa',
			'dc55849e-b3d8-4429-b6c5-9f08ad7168b6'
		)	
	and activeflag = 1 ;

-- To Update Start Date as 2022-12-29 05:00:00.000
-- 30919a41-b2bb-455d-9cf6-b7366004b9d5	2023-05-12 04:00:00.000	
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = '30919a41-b2bb-455d-9cf6-b7366004b9d5'
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set suspensionbegindate = '2022-12-29 05:00:00.000',
	approvaldate = now(),
	updatedby = 'CDM-33819',
	updatedon = now()
where adoptionsuspensionid = '30919a41-b2bb-455d-9cf6-b7366004b9d5'
	and activeflag = 1 ;	

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid = '30919a41-b2bb-455d-9cf6-b7366004b9d5'
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set suspensionbegindate = '2022-12-29 05:00:00.000',
	approvaldate = now(),
	updatedby = 'CDM-33819',
	updatedon = now()
where adoptionsuspensionid = '30919a41-b2bb-455d-9cf6-b7366004b9d5' 
	and activeflag = 1 ;	
	