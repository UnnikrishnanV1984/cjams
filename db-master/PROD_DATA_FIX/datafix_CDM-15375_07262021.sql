-- CDM-15375 - Missing Service Log Authorization
/*
-- Issue Description: 
	The Authorizations (# 1779701, 1779702 & 1779681) are not in the Finance approval box. 
	These payments are critical for COVID Youth Turning 21.
   
-- Case ID: 3115646
-- Client ID: 2121040
-- Service Log ID: 2001052 - Enhanced Aftercare Services (Paid)
-- Authorization IDs: 1779701, 1779702 & 1779681
-- Provider ID: 5001391	(Jumoke, Inc.) - Private Organization

-- Provider Service ID: 50010514
-- Current Provider Service ID: 221710  (delete_sw = 'Y')

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
where service_log_id = 2001052 
	and delete_sw  = 'N' ;

update tb_service_log 	
set provider_service_id = 50010514,
	update_ts = now(), 
	update_user_id = 'CDM-15375'
where service_log_id = 2001052 
	and delete_sw  = 'N' ;


