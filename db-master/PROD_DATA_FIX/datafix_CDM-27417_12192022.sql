-- CDM-27417 - Unable to close services log
/*
-- Issue Description: 
   User Request to Close (End Date) the migrated Service Log record
  
-- Case ID: 3303174
-- Client ID: 4428362 (ANN'ABELLA DAVIS) - 92da6dc9-97fa-4320-8c1e-b5e365e0d8ea
-- Service Log ID: 1998311 - 05/14/2021 To Current - Furniture, Equipment (Paid) 
-- Provider ID: 5036607	(Baltimore City Department of Social Services)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: CJAMS is not allowing the users to Close (End Date) the migrated Service Log records
-- Fix Provided: Datafix has been provided to Close (End Date) the requested Service Log with 10/21/2022.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To update Service Log End Date: 10/21/2022
select service_log_id,estimated_start_dt, estimated_end_dt,
	start_dt, end_dt, update_ts, update_user_id 
from cjams.tb_service_log 
where service_log_id = 1998311
	and delete_sw = 'N' ;
	
update tb_service_log
set end_dt = '2022-10-21'::date,
	update_ts = now(), 
	update_user_id = 'CDM-27417'
where service_log_id = 1998311
	and delete_sw = 'N' ;
