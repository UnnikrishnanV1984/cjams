-- CDM-36008 - Bug/Payments
/*
-- Issue Description: 
   Worker is not population in dropdown
	
	
-- Category/ Module: Placement (Case Management) 
-- Root cause: User setup issue, Amanda Swyter is having a wrong roletypekey in teammember table (KINSHIPUP)
-- Fix Provided: Datafix has been promoted to update the user roletypekey as CWCW (caseworker,CW)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Amanda Swyter - amanda.swyter@maryland.gov (783d25d0-ca44-4234-8393-0f631c02f923/221030017904)
-- Update roletypekey = CWCW (Old Values: KINSHIPUP)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = '96d340a5-a43b-4812-8ae6-2a93c482be73'
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'CWCW',
	updatedon = now(),
	updatedby = 'CDM-36008'
where teammemberid = '96d340a5-a43b-4812-8ae6-2a93c482be73'
	and activeflag  = 1 ;	