-- CDM-23485 - Unable to validate
/*
-- Issue Description: 
	Child was in placement with provider Joyce Smith (5005204) from 6/1/2022 to 6/15/2022. 
	Child was then moved and the provider closed. 
	The home was not closed in CJAMS until 6/29/2022, however the validation will not 
	approve because the home is now closed.

	Validations should be able to occur as long as they are within the timeframe the home is open. 
	We should not be holding providers open just to validate. 
	
-- Case ID: 3220519
-- Client ID: 3118839 (NALIYAH ANNABELLE FRYE) - 3cc1c754-ba0d-4305-9067-a0b05a673ade
-- Placement ID: 322585 - 2017-11-01 To 2022-06-15 - c9db2853-45e0-4861-84b6-e484c88977f6
-- Provider ID: 5005204 (JOYCE SMITH) - Local Department Home - Closed	
	   
-- Category/ Module: Placement Validations (Case Management)
-- Root cause: Provider Home Approval Data issue
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Home Approval status as Revoked
select provider_id, approval_status_cd, ha_revoke_approval_status_cd, ha_revoke_approval_dt,
	update_ts, update_user_id
from prov.tb_provider_approval
where provider_approval_id in ( 108216, 108215 )
	and delete_sw = 'N' ;

update prov.tb_provider_approval
set approval_status_cd = '3585', --	Revoked
	update_ts = now(), 
	update_user_id = 'CDM-23485'
where provider_approval_id in ( 108216, 108215 )
	and delete_sw = 'N' ;
