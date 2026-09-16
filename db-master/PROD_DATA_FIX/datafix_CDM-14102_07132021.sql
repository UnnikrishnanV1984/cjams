-- CDM-14102 - Payment Issue
/*
-- Issue Description: 
   Purchase Authorization approval issue for Auth IDs: 1779152 & 1778974
   
-- Harford County User: Jill Latteri - 586909e6-04f0-4ca8-8434-0a046fbbbad8 - jill.latteri@maryland.gov
-- Case ID: 3069774
-- Client ID: 3606619 (JOSEPH F	CARROLL) - a450e5f5-1077-4d31-8d27-e8df5a6afddd
-- Private Organization: 5019256 (Community Services for Autistic Adults and Children, Inc.)
-- Auth IDs: 1779152 & 1778974
-- Service Log ID: 762145
-- Current provider_service_id 119883 (delete_sw = 'Y')
-- New provider_service_id 50010289

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
where service_log_id = 762145 
	and delete_sw  = 'N' ;

update tb_service_log 	
set provider_service_id = 50010289,
	update_ts = now(), 
	update_user_id = 'CDM-14102'
where service_log_id = 762145 
	and delete_sw  = 'N' ;
