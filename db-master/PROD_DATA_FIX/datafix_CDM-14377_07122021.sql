-- CDM-14377 - Can't approve service logs
/*
-- Issue Description: 
   Purchase Authorization approval issue for Auth IDs: 1782313 & 1782315
   
-- Montgomery County User: Lisa Merkin - 0a24201d-7f71-44e2-b2a0-25cb58bf58cd
-- Case ID: 3177971
-- Client ID: 1209271 (JORDON I	PALMER) - 91367d24-dbe6-466e-9db3-dd17c58947ab
-- Auth IDs: 1782313 & 1782315
-- Service Log ID: 1974790
-- Current provider_service_id 117806 (delete_sw = 'Y')
-- New provider_service_id 50010475

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update provider_service_id in Service Log table
select provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where service_log_id = 1974790 
	and delete_sw  = 'N' ;

update tb_service_log 	
set provider_service_id = 50010475,
	update_ts = now(), 
	update_user_id = 'CDM-14377'
where service_log_id = 1974790 
	and delete_sw  = 'N' ;

