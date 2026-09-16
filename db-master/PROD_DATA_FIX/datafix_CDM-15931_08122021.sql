-- CDM-15931 - Missing Service Log authorization
/*
-- Issue Description: 
   The Authorization # 1780439 is not in the Finance approval box. 
	
-- Case ID: 3223892
-- Client ID: 2217872 (TAMIL SHAMERE SMITH) - 0e5d01c4-8b7b-4ec3-be34-a9e17d313e2c
-- Service Log ID: 1988171- Enhanced Aftercare Services (Paid) - 11343
-- Private Organization: 5001391 (Jumoke, Inc.)	
-- Auth ID: 1780439
	
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

-- For all Srevice Logs
/*
Service Log ID	Case #	Client #
---------------------------------------
1981437			3071508	1447165
1981899			3071508	1447165
494822			3220885	1384197
1983949			3118076	1710482
1988171			3223892	2217872
*/

-- Update provider_service_id in Service Log table
select service_log_id , provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 221710
	and delete_sw  = 'N' ;

update tb_service_log 	
set provider_service_id = 50010514,
	update_ts = now(), 
	update_user_id = 'CDM-15931'
where provider_service_id = 221710
	and delete_sw  = 'N' ;


