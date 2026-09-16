-- CDM-13926 - Cannot see blue icons at the bottom for approval
/*
-- Issue Description: 
   Almonique Vaughan is the fiscal user, not able to approve or deny invoices that are being sent to her.
	
-- Montgomery County User: Almonique Vaughan (almonique.vaughan@montgomerycountymd.gov) - 3ecaf5cd-9451-48a6-a9c8-bfcde1bd1e24
	
-- Category/ Module: Purchase Authorization  (Case Management) 
-- Root cause: User setup issue, wrong roletypekey in teammember table
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update roletypekey = FNSFS (Old Values: IVESV)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = 'bafa25be-28c6-473e-8ad6-a0dbfa511caa' 
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'FNSFS',
	updatedon = now(),
	updatedby = 'CDM-13926'
where teammemberid = 'bafa25be-28c6-473e-8ad6-a0dbfa511caa' 
	and activeflag  = 1 ;	
