--CDM-42805-Service Log/Purchase Auth Dates

/*
-- Issue Description: 
   User request for  3259325:Need to change the end date- 2025 was selected instead of 2024 
--  Client ID: 1130628 (FREDERICA GROSS)
    Provider ID: 5091274 (Ammon Analytical Laboratories L.L.C.)
    Purchase Auth ID: 3667398
    Payment ID: 4612972 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the Purchase Authorization End date from 09/27/2025 to 09/27/2024.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select end_dt,reason_tx, authorization_id,* from tb_service_purchase_authorization tspa where service_log_id = 3532619;
*/

/*update tb_service_purchase_authorization table with authorization_id = 3667398
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2024-09-27', 
	update_user_id='CDM-42805',
	update_ts =now() 
WHERE authorization_id  = 3667398;

/*payment table --> tb_payment_detail -> final_service_end_dt 
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail where payment_id = 4612972;
where final_service_end_dt = '2026-07-31' and final_service_start_dt = '2020-07-01' 
and client_id = 4040404 
and case_id = 3299565;
*/
-- payment_id = 3035311;

update tb_payment_detail
set final_service_end_dt = '2024-09-27',
	update_user_id='CDM-42805',
	update_ts =now() 
where payment_id = 4612972;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 3667398;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2024-09-27', 
	update_user_id='CDM-42805',
	update_ts =now() 
WHERE authorization_id  = 3667398;