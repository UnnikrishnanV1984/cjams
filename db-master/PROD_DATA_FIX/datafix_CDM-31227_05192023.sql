-- CDM-31227 - Provider Name change
/*
-- Issue Description: 
	To fix the provider name discrepancy between CJAMS provider and CW modules

-- Provider ID: 5013964	(Tynisha Briscoe) - Local Department Home
-- New Name: Tynicha White-Briscoe

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module side Data Issue.
-- Fix Provided: Data fix has been promoted to fix the provider name discrepancy.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

-- 05/25/2023 - The deployment was missed after the DB refresh, so new PR was raised against 6.12.0 
*/

-- Provider ID: 5013964	(Tynisha Briscoe) - Local Department Home
-- New Name: Tynicha White-Briscoe

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5013964
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-31227'
where provider_id = 5013964
	and delete_sw  = 'N' ;
	
	
-- Update Provider Names on the Adoption cases
-- Adoption ID: 12449 - Case ID: 3137274	be7d3ea7-a2cd-4977-aef0-4bd4ed7d0336
select adoptioncaseid, providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = 'be7d3ea7-a2cd-4977-aef0-4bd4ed7d0336'	
	and activeflag  = 1 ;
	
update adoptioncaseagreement 
set -- providerid = 5013964, 
	-- parent1providerid = 5013964, 
	parent1providername = 'Tynicha White-Briscoe', 
	-- parent2providerid = 5013964,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-31227',
	updatedon = now()
where adoptioncaseid = 'be7d3ea7-a2cd-4977-aef0-4bd4ed7d0336'	
	and activeflag  = 1 ;

-- Adoption ID: 10165 - Case ID: 3134990	da801800-3004-47d1-a770-6abf9881dba5
-- Adoption ID: 11920 - Case ID: 3136745	df866b8b-070b-4948-b195-bddd1ae33e81
select adoptioncaseid, providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid 
	in (	'df866b8b-070b-4948-b195-bddd1ae33e81',
			'da801800-3004-47d1-a770-6abf9881dba5'
		)	
	and activeflag  = 1 ;
	
update adoptioncaseagreement 
set -- providerid = 5013964, 
	-- parent1providerid = 5013964, 
	-- parent1providername = 'Carillin  Briscoe', 
	-- parent2providerid = 5013964,  
	parent2providername = 'Tynicha White-Briscoe', 
	-- issingleparent = 0,
	updatedby = 'CDM-31227',
	updatedon = now()
where adoptioncaseid 
	in (	'df866b8b-070b-4948-b195-bddd1ae33e81',
			'da801800-3004-47d1-a770-6abf9881dba5'
		)	
	and activeflag  = 1 ;