-- CDM-14421 - Fiscal Supervisor not in drop down
/*
-- Issue Description: 
   Crystal Stewart is the fiscal supervisor, but does not appear in the payment approval supervisor list.
	
-- Montgomery County User: Crystal Stewart (crystal.stewart@montgomerycountymd.gov) - e4271184-e42a-4639-88a5-4168eb1814f7
-- LDSS Fiscal Supervisor
	
-- Category/ Module: Purchase Authorization  (Case Management) 
-- Root cause: User setup issue, wrong roletypekey in teammember table
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update roletypekey = FNSFS (Old Values: IVESV)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = 'dd34e255-bfb8-4acd-86fc-e65f81bf7907' 
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'FNSFS',
	updatedon = now(),
	updatedby = 'CDM-14421'
where teammemberid = 'dd34e255-bfb8-4acd-86fc-e65f81bf7907' 
	and activeflag  = 1 ;	

