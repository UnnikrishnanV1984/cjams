/*
-- Issue Description: 
   Not able to close the provider 
  
-- Case ID: 3146048
-- Client ID: 2245299 ( Captain Pierre Hill)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: 2010 old migrated Purchase authorization missing the service log start date leading not to populate the PA link. 
-- Fix Provided: Datafix has been promoted to update the service log estimated start date/end date 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_service_log
set estimated_start_dt = '08-19-2010'::date,
	start_dt = '08-19-2010'::date,
	estimated_end_dt = '09-02-2010'::date ,
	end_dt = '09-02-2010'::date,
	update_ts = now(),
	update_user_id = 'CJAMS-61650'
where service_log_id = 260824
	and delete_sw = 'N';	