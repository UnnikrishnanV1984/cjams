/*
-- Issue Description: 
Need data fix to update the Purchase Authorization End date and Service Log Estimated and Actual End date with '10/27/2022'. 
Also the same needs to be fixed on the Purchase authorization and Service log prints.
Client ID :1885117 (SHEBA AVERY)
Vendor ID#: 5008913 (Baltimore County DSS)
Service: Financial Management (Paid)
Auth ID: 1859475
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates , Actual End date and Purchase Authorization End date  with '10/27/2022'.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select end_service_reason_cd,end_dt ,estimated_end_dt ,* from cjams.tb_service_log
where service_log_id = 1992435; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2022-10-27', 
	update_user_id='CJAMS-59590', 
	estimated_end_dt ='2022-10-27',
	update_ts=now() 
WHERE service_log_id = 1992435;

--select end_dt,reason_tx, authorization_id,* from tb_service_purchase_authorization tspa where authorization_id  = 1859475;

UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2022-10-27', 
	update_user_id='CJAMS-59590',
	update_ts =now() 
WHERE authorization_id  = 1859475;

/*
select update_user_id, * from tb_payment_header tph where authorization_id = 1859475; --for approved
select * from tb_payment_detail tpd where payment_id = 3256585
*/

update tb_payment_detail
set final_service_end_dt = '2022-10-27',
	update_user_id='CJAMS-59590',
	update_ts =now() 
where payment_id = 3256585;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 1859475;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2022-10-27', 
	update_user_id='CJAMS-59590',
	update_ts =now() 
WHERE authorization_id  = 1859475;