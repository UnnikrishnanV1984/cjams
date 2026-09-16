/*
   Issue Description: End date Service Log CJAMS-62609
   Category/ Module  : Service Log
   Root cause: 1. Provider ID: 5090612 (Rolling Hills Hospital, LLC), Service: Remedial/Special Education (Paid), Actual Begin Date: 03/01/2020. 
   Data fix to update the "Estimated End Date" and "Actual End Date" as "05/31/2020"
   2. Provider ID: 5036607 (Baltimore City Department of Social Services), Service: Financial Management (Paid), Actual Begin Date: 02/21/20219. 
   Data fix to update the "Estimated End Date" and "Actual End Date" as "08/05/2025"
   Fix Provided: Data fix has been done to endate the service log 
   Data/Code fix ticket#: CJAMS-62609
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/

update tb_service_log
  set end_dt = '2020-05-31'::date,
    estimated_end_dt = '2020-05-31',
	update_ts = now(), 
	end_service_reason_cd = '1824',
	update_user_id = 'CJAMS-62609' 
where case_id = '3156935' 
  and client_id = '1644099' 
  and service_log_id = '1971968';
     
update tb_service_log
  set end_dt = '2025-08-05'::date,
    estimated_end_dt = '2025-08-05',
	update_ts = now(), 
	end_service_reason_cd = '1824',
	update_user_id = 'CJAMS-62609' 
where case_id = '3156935' 
  and client_id = '1644099' 
  and service_log_id = '905935';   
