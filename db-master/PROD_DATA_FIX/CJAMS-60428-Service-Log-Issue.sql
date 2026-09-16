/*
-- Issue Description: 
    Case# 3012500, Client ID: 2627935 (Olivia Barber)
    Provider ID: 5002462 (Wicomico Co Dept Of Social Service)

    Update the "Purchase Authorization (3773123)" end date and "Service log" Estimated and Actual end date with "04/14/2025"
    Update the "Purchase Authorization (3773137)" end date and "Service log" Estimated and Actual end date with "04/09/2025"
    Update the same end dates on the Purchase Authorization and Service Log prints (Reports). --  Case# 3299565, Client ID: 4040404 (TASHAMERE CARTER), 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates , Actual End date and Purchase Authorization End date as requested.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Update the "Purchase Authorization (3773123)" end date and "Service log" Estimated and Actual end date with "04/14/2025"
/*
select end_service_reason_cd,end_dt ,* from cjams.tb_service_log
where service_log_id = 3651931; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2025-04-14', 
	update_user_id='CJAMS-60428', 
	estimated_end_dt ='2025-04-14',
	update_ts=now() 
WHERE service_log_id = 3651931;

/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 3651931;
*/
/*update tb_service_purchase_authorization table with authorization_id = 3773123
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2025-04-14', 
	update_user_id='CJAMS-60428',
	update_ts =now() 
WHERE authorization_id  = 3773123;

/*payment table --> tb_payment_detail -> final_service_end_dt 

select * from tb_payment_header p where authorization_id = '3773123'

select final_service_start_dt, final_service_end_dt, * from tb_payment_detail 
where client_id = 2627935 
and case_id = 3012500 and payment_id  =4720663 ;*/
-- payment_id = 4720663;

update tb_payment_detail
set final_service_end_dt = '2025-04-14',
	update_user_id='CJAMS-60428',
	update_ts =now() 
where payment_id = 4720663;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 3773123;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2025-04-14', 
	update_user_id='CJAMS-60428',
	update_ts =now() 
WHERE authorization_id  = 3773123;


--Update the "Purchase Authorization (3773137)" end date and "Service log" Estimated and Actual end date with "04/14/2025"

/*
select end_service_reason_cd,end_dt ,* from cjams.tb_service_log
where service_log_id = 3652000; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2025-04-09', 
	update_user_id='CJAMS-60428', 
	estimated_end_dt ='2025-04-09',
	update_ts=now() 
WHERE service_log_id = 3652000;

/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 3652000;
*/
/*update tb_service_purchase_authorization table with authorization_id = 3773137
(There can be multiple authorizations for the same service_log_id )
*/

UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2025-04-09', 
	update_user_id='CJAMS-60428',
	update_ts =now() 
WHERE authorization_id  = 3773137;

/*payment table --> tb_payment_detail -> final_service_end_dt 

select * from tb_payment_header p where authorization_id = '3773137'

select final_service_start_dt, final_service_end_dt, * from tb_payment_detail 
where client_id = 2627935 
and case_id = 3012500 and payment_id  =4720653 ;*/
-- payment_id = 4720653;

update tb_payment_detail
set final_service_end_dt = '2025-04-09',
	update_user_id='CJAMS-60428',
	update_ts =now() 
where payment_id = 4720653;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 3773137;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2025-04-09', 
	update_user_id='CJAMS-60428',
	update_ts =now() 
WHERE authorization_id  = 3773137;