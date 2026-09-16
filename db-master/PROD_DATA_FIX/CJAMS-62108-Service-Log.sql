/*
   Issue Description: 3240461:This case has two service logs that we are unable to close because they are overlapping. They are both under Anita Sheldon. 
   Category/ Module  : Service Log
   Root cause: As per system design, duplicate or multiple service logs can not be created on the same date period for the same client ID, Provider/Vendor ID and Service.
   Client ID: 3553695 (Anita Sheldon)
	Provider ID: 5075238 (Easy Transport, LLC)
	Service: Transportation assistance (Paid)
	Latest Auth End Date: 11/04/2023

	Client ID: 3553695 (Anita Sheldon)
	Provider ID: 5009233 (Jimmy's Cab)
	Service: Transportation assistance (Paid)
	Latest Auth End Date: 02/28/2025

   Fix Provided: Data fix has been done to endate the service log 
   Data/Code fix ticket#: CJAMS-58981
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/
--select end_reason_desc_tx ,end_service_reason_cd ,estimated_end_dt ,* from tb_service_log tsl where client_id = '3553695' and end_dt is null;

update tb_service_log
set end_dt = '2023-11-04'::date,
	update_ts = now(), 
	end_service_reason_cd = '1824',
	estimated_end_dt = '2023-11-04', --Mar 26, 2024
	update_user_id = 'CJAMS-62108' 
where service_log_id = 2061366
      and case_id =  3240461
      and client_id = 3553695;     
     
update tb_service_log
set end_dt = '2025-02-28'::date,
	update_ts = now(), 
	end_service_reason_cd = '1824',
	estimated_end_dt = '2025-02-28', --2030-12-31
	update_user_id = 'CJAMS-62108' 
where service_log_id = 2586033
      and case_id =  3240461
      and client_id = 3553695;