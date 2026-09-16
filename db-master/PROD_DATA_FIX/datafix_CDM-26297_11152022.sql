-- CDM-26297 - Placement Validation
/*
-- Issue Description: 
   Case worker Bendu Benson (200932674) is not listed when you hit the placement validation. 

-- Baltimore City - Family Services #46
-- Bendu Benson (bendu.benson@maryland.gov) - c3013aa3-d5ad-4afa-b310-49bc59987b6f	
-- Lynette Venson (lynette.venson@maryland.gov) - 7610dddf-4348-4357-bc5f-81f37adeda30
	
-- Category/ Module: Placement (Case Management) 
-- Root cause: User setup issue, wrong roletypekey in teammember table
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Bendu Benson (bendu.benson@maryland.gov) - c3013aa3-d5ad-4afa-b310-49bc59987b6f	
-- Update roletypekey = CWCW (Old Values: CWCMSP)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = '9749a96a-1490-4d33-9b1d-67948f4e9a41'
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'CWCW',
	updatedon = now(),
	updatedby = 'CDM-26297'
where teammemberid = '9749a96a-1490-4d33-9b1d-67948f4e9a41'
	and activeflag  = 1 ;	
