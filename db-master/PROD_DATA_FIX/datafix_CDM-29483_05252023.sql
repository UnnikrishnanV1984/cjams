-- CDM-29483 - Placement Vaildation
/*
-- Issue Description: 
   User request to delete the old outstanding placement validations.

-- Client ID: 1740465 (XAVIER J	JUBILEE) - a6518cca-480b-4f18-8e43-96b4ed2fc4ae
-- Placement Validation ID: 1956583, 1956582, 1956581  
-- Independent Living Residential program is only applicable for clients between 16 years and 21 years of age.
-- Client aged out on May 23, 2020, but he did not leave care until September 30, 2021 due to COVID.   

-- Client ID: 4195537 (MELANIA M MORGERETH) - e6225368-97f4-4d57-91a2-808bcd2a0899
-- Placement Validation ID: 2022269
-- Approved Home Approval not found for Melonie Lynn Wilhelm; placement cannot be validated.

-- Category/ Module: Placement (Case Management) 
-- Root cause: Exception scenario due to the pandemic. 
-- Fix Provided: Datafix has been promoted to remove the requested pending Placement validations.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the pending Placement Validations (CDM-29483)
-- Client ID: 1740465 (XAVIER J	JUBILEE) - a6518cca-480b-4f18-8e43-96b4ed2fc4ae
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from cjams.tb_placement_validation 
where placement_validation_id  in ( 1956583, 1956582, 1956581 )
	and delete_sw  = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request, Client was aged-out but did not leave care due to pandemic.',
	update_ts = now(),
	update_user_id = 'CDM-29483'
where placement_validation_id  in ( 1956583, 1956582, 1956581 )
	and delete_sw  = 'N' ;

-- Client ID: 4195537 (MELANIA M MORGERETH) - e6225368-97f4-4d57-91a2-808bcd2a0899
-- Provider ID: 5095328	(Melonie Lynn Wilhelm) - Local Department Home
-- To fix the Provider Home Approval Status Issue
select provider_approval_id, approval_status_cd, update_ts, update_user_id  
from prov.tb_provider_approval 
where provider_id = 5095328
	and provider_approval_id = 80151
	and delete_sw = 'N'
	and approval_status_cd = '0' ;

update prov.tb_provider_approval 
set approval_status_cd = '3579', -- Approved
	update_ts = now(),
	update_user_id = 'CDM-29483'
where provider_id = 5095328
	and provider_approval_id = 80151
	and delete_sw = 'N'
	and approval_status_cd = '0' ;
