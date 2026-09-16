/*
-- Issue Description: CDM-44138
    user requested to change the purchase authorization (3688799) end date (11/01/2025) to (12/30/2024). 
    Because User unable to process vendor payment actual start and end dates rejected
-- Case ID: 202107406579
-- Client ID: 200301082 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the purchase authorization (3688799) end date (11/01/2025) to (12/30/2024). 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select * from tb_service_purchase_authorization where authorization_id = '3688799'
*/

--Updating date in tb_service_purchase_authorization
update tb_service_purchase_authorization
set end_dt = '2024-12-30', update_user_id = 'CDM-44138', update_ts = now()
where authorization_id = 3688799;

/*
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail 
where --final_service_end_dt = '2026-07-31' and final_service_start_dt = '2020-07-01' 
 client_id =  200301082
and case_id = 202107406579;--payment_id: 4655858
*/

update tb_payment_detail
set final_service_end_dt = '2024-12-30',
	update_user_id='CDM-44138',
	update_ts =now() 
where payment_id = 4655858;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 3688799;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2024-12-30', 
	update_user_id='CDM-44138',
	update_ts =now() 
WHERE authorization_id  = 3688799;