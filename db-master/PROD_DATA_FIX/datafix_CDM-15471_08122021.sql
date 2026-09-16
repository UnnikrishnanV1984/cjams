-- CDM-15471 - Service logs not approved
/*
-- Issue Description: 
   The Authorizations are not in the Finance approval box. 
   1782401, 1782403, 1782395, 1782394, 1782393,
   1782391, 1782388, 1782385, 1782383, 1782372
	
-- Case ID: 3217666
-- Client ID: 3419829 (TIFFANY WADE) - a833fe1a-78e0-4083-9eb5-3bc9e2b10826
-- Servuce Log ID: 842576 - Remedial/Special Education (Paid)
-- Auth ID: 1782401, 1782403, 1782395, 1782394, 1782393,
--			1782391, 1782388, 1782385, 1782383, 1782372

-- Provider Srevice ID: 119883 (delete_sw = 'Y')


-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Provider Module is having logic to insert new record in the tb_provider_services table 
--			   and soft delete the old one on any update. 
-- 			   This is causing Data integrity issue on CW side, as our Service Log table (tb_service_log)
--			   is capturing provider_service_id as FK (PK of tb_provider_services).
-- Pull request# TBD (Simar is working on the fix)
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update delete_sw = 'N' in tb_provider_services table
select provider_service_id, delete_sw, update_ts, update_user_id 
	from prov.tb_provider_services
where provider_service_id = 119883
	and delete_sw = 'Y' ;

update prov.tb_provider_services
set delete_sw = 'N',
	update_ts = now(), 
	update_user_id = 'CDM-15471'
where provider_service_id = 119883
	and delete_sw = 'Y' ;

