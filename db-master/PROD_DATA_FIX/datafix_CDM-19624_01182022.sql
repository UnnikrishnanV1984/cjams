-- CDM-19624 - Fiscal Child Accounts
/*
-- Issue Description: 
   User name is not listed under "User" to send for the Finance approvals. 
	
-- Calvert County User: Tracy Gray (tracy.gray@maryland.gov) - a7b7b759-341a-4604-a853-3a922c75fb4d
	
-- Category/ Module: Purchase Authorization/Child Accounts apporvals (Finance Management) 
-- Root cause: User setup issue, wrong roletypekey in teammember table
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update roletypekey = FNSFS (Old Values: FNSFW)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = 'a1be6a4a-26e8-4c2b-a82f-615c7541ee99' 
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'FNSFS',
	updatedon = now(),
	updatedby = 'CDM-19624'
where teammemberid = 'a1be6a4a-26e8-4c2b-a82f-615c7541ee99' 
	and activeflag  = 1 ;	
