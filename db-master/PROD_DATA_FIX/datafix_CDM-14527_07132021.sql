-- CDM-14527 - Finance is reporting they cannot see this bill
/*
-- Issue Description: 
   Purchase Authorization approval issue for Auth ID: 1783026
   
-- Case ID: 3257143
-- Client ID: 2572190 (HARLEY J	ETTER) - 318028c2-fe64-4d25-bb8a-eb7e1a9b1b84
-- Private Organization: 5000485 (Arrow Child & Family Ministries of Maryland, Inc.)
-- Auth ID: 1783026 - Educational-Vocational (Paid)
-- Service Log ID: 1984634
-- Current provider_service_id 139885 (delete_sw = 'Y')
-- New provider_service_id 50010439

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Provider Module is having logic to insert new record in the tb_provider_services table 
--			   and soft delete the old one on any update. 
-- 			   This is causing Data integrity issue on CW side, as our Service Log table (tb_service_log)
--			   is capturing provider_service_id as FK (PK of tb_provider_services).
-- Pull request# TBD (Simar is working on the fix)
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update provider_service_id in Service Log table
select provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where service_log_id = 1984634 
	and delete_sw  = 'N' ;

update tb_service_log 	
set provider_service_id = 50010439,
	update_ts = now(), 
	update_user_id = 'CDM-14527'
where service_log_id = 1984634 
	and delete_sw  = 'N' ;
