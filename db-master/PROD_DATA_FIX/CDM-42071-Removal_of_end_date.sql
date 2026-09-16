--CDM-42071 Removal of end date
/*
-- Issue Description: 
   User request to  remove the Service Log Estimated End date, Actual End date and Purchase Authorization End date from 07/31/2026 to  8/15/2023.
--  Case# 3297536 , Client ID: 2150333 ( SAMUEL ADAMS )

-- Case# 3297536 , Client ID: 2150332 ( NEAL ADAMS ),
User request to  remove the Service Log Estimated End date, Actual End date and Purchase Authorization End date from 07/03/2026 to  12/31/2023
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates , Actual End date and Purchase Authorization End date from 07/31/2026 to  8/15/2023.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Case# 3297536 , Client ID: 2150332 ( NEAL ADAMS ),
/*
select end_service_reason_cd,end_dt,estimated_end_dt,* from cjams.tb_service_log
where service_log_id = 1996918; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2023-12-31', 
	update_user_id='CDM-42071', 
	estimated_end_dt ='2023-12-31',
	update_ts=now() 
WHERE service_log_id = 1996918;


/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 1996918;
*/
/*update tb_service_purchase_authorization table with authorization_id = 1859451
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2023-12-31', 
	update_user_id='CDM-42071',
	update_ts =now() 
WHERE authorization_id  = 1859451;

/*payment table --> tb_payment_detail -> final_service_end_dt
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail where final_service_end_dt = '2026-07-03'
where  client_id = 1846387 and delete_sw = 'N' and payment_id = 3035303
and final_service_end_dt = '2026-07-03'
-- payment_id = 3035284;
*/

update tb_payment_detail
set final_service_end_dt = '2023-12-31',
	update_user_id='CDM-42071',
	update_ts =now() 
where payment_id = 3256566;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 1859451;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2023-12-31', 
	update_user_id='CDM-42071',
	update_ts =now() 
WHERE authorization_id  = 1859451;



/*
Case# 3297536 , Client ID: 2150333 ( SAMUEL ADAMS ), 
Need to change the Service Log Estimated End date, Actual End date and Purchase Authorization End date to 8/15/2023
Provider: 5008913 (Baltimore County DSS), Service: Financial Management (Paid) and Purchase authorization (1859452).
*/
UPDATE cjams.tb_service_log
SET end_dt='2023-08-15', 
	update_user_id='CDM-42071', 
	estimated_end_dt ='2023-08-15',
	update_ts=now() 
WHERE service_log_id = 1996931;


/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 1996931;
*/
/*update tb_service_purchase_authorization table with authorization_id = 1859451
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2023-08-15', 
	update_user_id='CDM-42071',
	update_ts =now() 
WHERE authorization_id  = 1859452;

/*payment table --> tb_payment_detail -> final_service_end_dt
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail where final_service_end_dt = '2027-04-28'
where  client_id = 1846387 and delete_sw = 'N' and payment_id = 3035303
and final_service_end_dt = '2026-07-03'
-- payment_id = 3035284;
*/

update tb_payment_detail
set final_service_end_dt = '2023-08-15',
	update_user_id='CDM-42071',
	update_ts =now() 
where payment_id = 3256569;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 1859452;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2023-08-15', 
	update_user_id='CDM-42071',
	update_ts =now() 
WHERE authorization_id  = 1859452;


