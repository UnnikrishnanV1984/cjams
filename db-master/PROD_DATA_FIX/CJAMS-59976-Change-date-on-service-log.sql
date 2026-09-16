--CJAMS-59976
/*
-- Issue Description: 
    Case# 3164013, Client ID: 2322770 (ISAAC AVERY)
    Provider ID: 5008913 (Baltimore County DSS)
    Service: Financial Management (Paid)
    Auth ID: 1859480
    Payment ID: 3256582
    Check #: 188579

    Need data fix as mentioned below,
        Service Log - Estimated End date and Actual End date needs to be update to "10/27/2022"
        Same dates needs to be updated on the Service Log print.
        Purchase Authorization (1859480) End date needs to be updated to "10/27/2022"
        Same End date needs to be updated on the Purchase Authorization print.

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User kept the future date for the one of the service log 08/08/2028 blocking user to create new service log.
-- Fix Provided: Datafix has been promoted to update the requested Service Log, PA End dates  from 08/08/2028 to "10/27/2022".
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select end_service_reason_cd,end_dt ,estimated_end_dt ,* from cjams.tb_service_log
where service_log_id = 2025042; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2022-10-27', 
	update_user_id='CJAMS-59976', 
	estimated_end_dt ='2022-10-27',
	update_ts=now() 
WHERE service_log_id = 2025042;

/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 2025042;--1859480
*/
/*update tb_service_purchase_authorization table with authorization_id = 1859480
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2022-10-27', 
	update_user_id='CJAMS-59976',
	update_ts =now() 
WHERE authorization_id  = 1859480;

/*payment table --> tb_payment_detail -> final_service_end_dt
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail 
where  client_id = 1846387 and delete_sw = 'N' and payment_id = 3035303
and final_service_end_dt = '2026-07-31'
-- payment_id = 3035284;
*/

--select * from tb_payment_detail tpd where client_id = '2322770' and case_id = '3164013' 

update tb_payment_detail
set final_service_end_dt = '2022-10-27',
	update_user_id='CJAMS-59976',
	update_ts =now() 
where payment_id = 3256582
	and payment_detail_id = 4478578;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 1859480;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2022-10-27', 
	update_user_id='CJAMS-59976',
	update_ts =now() 
WHERE authorization_id  = 1859480;