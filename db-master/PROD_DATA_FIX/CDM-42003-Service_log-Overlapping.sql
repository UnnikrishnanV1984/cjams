--CDM-42003-Service_log- Overlapping Dates
/*
-- Issue Description: 
   User request to  remove the Service Log Estimated End date, Actual End date and Purchase Authorization End date from 07/31/2026 to 2020-07-01.
--  Case# 3299565, Client ID: 4040404 (TASHAMERE CARTER), 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates , Actual End date and Purchase Authorization End date from 07/31/2026 to 2020-07-01.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select end_service_reason_cd,* from cjams.tb_service_log
where service_log_id = 1991182; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2020-07-01', 
	update_user_id='CDM-42003', 
	estimated_end_dt ='2020-07-01',
	update_ts=now() 
WHERE service_log_id = 1991182;


/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 1991182;
*/
/*update tb_service_purchase_authorization table with authorization_id = 1767925
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2020-07-01', 
	update_user_id='CDM-42003',
	update_ts =now() 
WHERE authorization_id  = 1767925;

/*payment table --> tb_payment_detail -> final_service_end_dt 
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail 
where final_service_end_dt = '2026-07-31' and final_service_start_dt = '2020-07-01' 
and client_id = 4040404 
and case_id = 3299565;
*/
-- payment_id = 3035311;

update tb_payment_detail
set final_service_end_dt = '2020-07-01',
	update_user_id='CDM-42003',
	update_ts =now() 
where payment_id = 3035311;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 1767925;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2020-07-01', 
	update_user_id='CDM-42003',
	update_ts =now() 
WHERE authorization_id  = 1767925;