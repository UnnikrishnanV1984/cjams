-- CDM-26355 - Need to add CfE placement
/*
-- Issue Description: 
   User request to update the placement structure as 525 - CfE Resource Home
   
-- Case ID: 3301090
-- Client ID: 3821965 (VAUGHN A FLOWERS) - 8bf518d4-0ff2-49d2-998b-564b3683f394	
-- Placement ID: 1575946 - 2022-11-01 to current - 19e71ee2-12a3-416f-a8dc-6c0afbbcec00

-- Client ID: 3804378 (GRAYSON LEE FLOWERS) - b1d34773-2302-4114-b708-9594a462f164	
-- Placement ID: 1575947 - 2022-11-01 to current - 276e674f-34d4-40e9-bfff-273772168a06

-- Current Placement Structure: 10 - Regular Foster Care

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Placement Structure & Rate Structure
select alternateid, altproviderid, service_id, ratestructureid, activeflag, updatedby, updatedon 
	from placement 
where alternateid in ( 1575946, 1575947 )
	and activeflag = 1 ; 
	
update placement 
set service_id = 525, -- CfE Resource Home
	ratestructureid = 525, -- CfE Resource Home
	updatedby = 'CDM-26355',
	updatedon = now()
where alternateid in ( 1575946, 1575947 )
	and activeflag = 1 ; 
