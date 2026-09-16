-- CDM-28730 - Flex Funds are not appearing
/*
-- Issue Description: 
   The flex funds are being submitted by my team, however they are not appearing in approval inbox.
	
-- Case ID: 3302747
-- Client ID: 4061585 (ALEENA A	BLANKENSHIP) - 71762142-c544-4830-8713-60eaa3cefffa
-- Provider ID: 5029437 (St. Mary's County Department of Social Services)
 
-- Auth ID: 1938297 - 2023-02-02 To 2023-02-28 - $355.00
-- Service: Home Improvement (Paid)
-- Forwarded to Case Supervisor
-- 0d6ae418-2140-47f0-8c92-6b24b731d4b9	jennifer.berry2@maryland.gov	Jennifer berry

-- Auth ID: 1938230 - 2023-02-01 To	2023-02-28 - $50.00
-- Service: Transportation assistance (Paid)
-- Denied on 02/02/2023 by Jennifer berry
	
-- Category/ Module: Placement (Case Management) 
-- Root cause: User setup issue, Jennifer berry was having a wrong roletypekey of the Provider module in teammember table
-- Fix Provided: Datafix has been promoted to update the Jennifer berry's roletypekey as CWSP (Supervisor,CW)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Jennifer berry - jennifer.berry2@maryland.gov (0d6ae418-2140-47f0-8c92-6b24b731d4b9	)
-- Update roletypekey = CWSP (Old Values: LDSSSP)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = '985d3040-a1f5-4e03-bcff-cfb9a76b241c'
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'CWSP',
	updatedon = now(),
	updatedby = 'CDM-28730'
where teammemberid = '985d3040-a1f5-4e03-bcff-cfb9a76b241c'
	and activeflag  = 1 ;	
