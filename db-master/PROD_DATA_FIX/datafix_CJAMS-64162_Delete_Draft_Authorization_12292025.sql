-- CJAMS-64162 - Old purchase auth is preventing resource home closure
/*
-- Issue Description: 
   Draft purchase authorization blocking the provider resource worker to close the provider.
   
-- Case ID: 3025396
-- Client ID: 1118850 (DESIRAE	A	KIRKLAND)
-- Provider ID: 5003102	Barbara Woolfolk
-- Authorization ID: 182271
-- Service: Educational-High School (Paid)  - 2011-05-13 To	2011-05-13 - $80.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Draft purchase authorization blocking the provider resource worker to close the provider.
-- Fix Provided: Datafix has been provided to soft delete the draft purchase authorization. 
-- Regression Impacts: Provider closure
-- Is Code fix Required?: (Yes/No) No
-- Code fix ticket#: (If Yes) N/A
-- Reason why no related code fix: (If No) User error
*/

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CJAMS-64162'
where authorization_id = 182271
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;