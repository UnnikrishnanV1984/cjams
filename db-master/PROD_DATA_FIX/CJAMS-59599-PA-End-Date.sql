
/*
-- Issue Description: 
    Need data fix to update the Purchase Authorization End date with '03/19/2025'. Also the same needs to be fixed on the Purchase authorization print.
    Client ID: 3117211 (MIA MAJOR)
    Provider ID: 6006662 (Maryland Family Visitation)
    Service: Child Development (Paid)
    Purchase Auth ID#: 3768813
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the Purchase Authorization End date from '04/19/2025'. to '03/19/2025'.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--select end_dt,reason_tx, authorization_id,* from tb_service_purchase_authorization tspa where authorization_id  = 3768813;
/*update tb_service_purchase_authorization table with authorization_id = 3667398
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2025-03-19', 
	update_user_id='CJAMS-59599',
	update_ts =now() 
WHERE authorization_id  = 3768813;

/*
 * as the PA is already approved so we need to update on tb_payment_detail
payment table --> tb_payment_detail -> final_service_end_dt 
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail where payment_id = 4718352;
--where final_service_end_dt = '2026-07-31' and final_service_start_dt = '2020-07-01' 
where client_id = 3117211 
and case_id = 3191386;

-- payment_id = 4718352;
*/
--select * from tb_payment_header tph where payment_id = 4718352;

update tb_payment_detail
set final_service_end_dt = '2025-03-19',
	update_user_id='CJAMS-59599',
	update_ts =now() 
where payment_id = 4718352;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 3768813;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2025-03-19', 
	update_user_id='CJAMS-59599',
	update_ts =now() 
WHERE authorization_id  = 3768813;