/*
-- Issue Description: 
 unable to add a new FSYP service log due to the old one being end dated for the future.
    Need data fix to update the Purchase Authorization End date and Service Log Estimated and Actual End date with '07/01/2021'. 
    Also the same needs to be fixed on the Purchase authorization and Service log prints.
    Client ID : 1660953 (LAYLA CHRISTIAN)
    Vendor ID#: 5008913 (Baltimore County DSS)
    Service: Financial Management (Paid)
    Auth ID: 1805522
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates , Actual End date and Purchase Authorization End date  with '07/01/2021'.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select end_service_reason_cd,end_dt ,estimated_end_dt ,* from cjams.tb_service_log
where service_log_id = 2021729; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2021-07-01', 
	update_user_id='CJAMS-59588', 
	estimated_end_dt ='2021-07-01',
	update_ts=now() 
WHERE service_log_id = 2021729;

--select end_dt,reason_tx, authorization_id,* from tb_service_purchase_authorization tspa where authorization_id  = 1805522;

UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2021-07-01', 
	update_user_id='CJAMS-59588',
	update_ts =now() 
WHERE authorization_id  = 1805522;

/*
select update_user_id, * from tb_payment_header tph where authorization_id = 1805522; --for approved
select * from tb_payment_detail tpd where payment_id = 3131235
*/

update tb_payment_detail
set final_service_end_dt = '2021-07-01',
	update_user_id='CJAMS-59588',
	update_ts =now() 
where payment_id = 3131235;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 1805522;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2021-07-01', 
	update_user_id='CJAMS-59588',
	update_ts =now() 
WHERE authorization_id  = 1805522;