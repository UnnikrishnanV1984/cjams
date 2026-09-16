/*
-- Issue Description: 
   User request to  remove the Service Log Estimated End date, Actual End date and Purchase Authorization End date.
    Case# 3202528, Client ID: (3242303) Miranda Pace, Provider ID: 5087977 (Shore United Bank, Inc.), Service: Financial Management (Paid)
    Need to remove the Service Log End date (12/03/2025), the 'Service End Reason' needs to be blank and the same needs to be fixed on the PDF print as well.
    Need to change the Purchase Authorization (3684661) End date from (12/03/2025) to (12/03/2024) and the same needs to be fixed on the PDF print as well.

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates, Purchase Authorization End date from (12/03/2025) to (12/03/2024) and update PDF.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select end_service_reason_cd,end_dt ,estimated_end_dt ,* from cjams.tb_service_log
where service_log_id = 3548400; 
*/

UPDATE cjams.tb_service_log
SET end_dt= Null, 
	end_service_reason_cd = null,
	update_user_id='CJAMS-58962', 
	update_ts=now() 
WHERE service_log_id = 3548400;

--select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 3548400;

UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2024-12-03', 
	update_user_id='CJAMS-58962',
	update_ts =now() 
WHERE authorization_id  = 3684661;

/*
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail 
where  client_id = 3242303 and delete_sw = 'N' 
and final_service_end_dt = '2025-12-03'
*/

update tb_payment_detail
set final_service_end_dt = '2024-12-03',
	update_user_id='CJAMS-58962',
	update_ts =now() 
where payment_id = 4630650;

--select end_dt ,* from tb_slpa_snapshot where authorization_id  = 3684661;

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2024-12-03', 
	update_user_id='CJAMS-58962',
	update_ts =now() 
WHERE authorization_id  = 3684661;