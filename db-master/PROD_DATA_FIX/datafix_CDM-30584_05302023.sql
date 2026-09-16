-- CDM-30584 - Service log - End dates into the future
/*
-- Issue Description: 
   User request to remove the future Service Log End date 
  
-- Case ID: 3295673
-- Client ID: 3511573 (HEATHER MARIE CLOWER) - fdc72638-e283-439c-b801-f366994ac8e3
-- Service Log ID: 902081 - 2018-12-28 To 2025-12-28 - Transportation assistance (Paid) 
-- Vendor ID: 5063371 (Victory Cab Inc)

-- Client ID: 4068466 (PHIL	M ADAMS) - 25902696-eb40-4eef-9fe7-f0e05b8c6b48
-- Service Log ID: 927075 - 2019-01-17 To 2032-06-06 - Drug/Alcohol Assessment (Paid) 
-- Vendor ID: 5009184 (Friends Medical Lab, Inc.)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error  
-- Fix Provided: Datafix has been promoted to remove the requested Service Log End date 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Remove the Service Log End date (CDM-30584)
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id in ( 902081, 927075 )
	and delete_sw = 'N';	
	

update tb_service_log
set end_dt = (case when end_dt > current_date then NULL else end_dt end),
	end_service_reason_cd = NULL,
	update_ts = now(), 
	update_user_id = 'CDM-30584'
where service_log_id in ( 902081, 927075 )
	and delete_sw = 'N';	
