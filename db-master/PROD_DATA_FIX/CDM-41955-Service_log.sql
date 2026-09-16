--CDM-41955-Service_log- remove the service log actual end date
/*
-- Issue Description:   
   User request to  remove the service log actual end date of 7/1/2026 in order to submit FYSP service log for FY25.
   Additional information was missing about purchase authroization details. Hence, this is the enhanced datafix
    
1. Client ID: 2844074 (LYRIC HIRSCH),
a) Need to end the Service Log and Purchase Authorization (2114587) with 10/03/2022.
b) Need to end the Purchase Authorization (2883397) with 07/01/2023.
 
2. Client ID: 2844099 (ELIJAH HIRSCH),
a) Need to end the Service Log and Purchase Authorization (2114588) with 07/01/2022.
b) Need to end the Purchase Authorization (2883463) with 07/01/2023 and remove the Service Log End date (07/01/2026)

-- Case ID: 3182561
-- Client ID: 2844074

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates as 09/06/2023 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
1. Client ID: 2844074 (LYRIC HIRSCH),
a) Need delete end date of 7/1/2026 in order to submit FYSP service log for FY25. and 
 to end the Purchase Authorization (2883397) with 07/01/2023.
b) Need to end the Service Log and Purchase Authorization (2114587) with 10/03/2022.
*/

--- 1a
/*
select estimated_end_dt,* from cjams.tb_service_log where service_log_id = 2933884
*/


UPDATE cjams.tb_service_log
SET end_dt=NULL, 
	end_service_reason_cd = null,
	update_user_id='CDM-41955', update_ts=now() 
WHERE service_log_id = 2933884;

/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 2933884;
*/
/*update tb_service_purchase_authorization table with authorization_id = 2883397
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2023-07-01', 
	update_user_id='CDM-41955',
	update_ts =now() 
WHERE authorization_id  = 2883397;

/*payment table --> tb_payment_detail -> final_service_end_dt
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail where client_id = 2844074
and  delete_sw = 'N' 
-- payment_id = 3960290;*/


update tb_payment_detail
set final_service_end_dt = '2023-07-01',
	update_user_id='CDM-41955',
	update_ts =now() 
where payment_id = 3960290;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 2883397;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2023-07-01', 
	update_user_id='CDM-41955',
	update_ts =now() 
WHERE authorization_id  = 2883397;


-- 1b
-- Need to end the Service Log and Purchase Authorization (2114587) with 10/03/2022.
/*
select estimated_end_dt,start_dt,end_service_reason_cd,end_dt,* from cjams.tb_service_log where service_log_id = 2302709
*/


UPDATE cjams.tb_service_log
SET end_dt='2022-10-03', 
	estimated_end_dt= '2022-10-03',
	end_service_reason_cd = 1824,
	update_user_id='CDM-41955', update_ts=now() 
WHERE service_log_id = 2302709;


/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 2302709;
*/
/*update tb_service_purchase_authorization table with authorization_id = 2114587
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2022-10-03', 
	update_user_id='CDM-41955',
	update_ts =now() 
WHERE authorization_id  = 2114587;

/*payment table --> tb_payment_detail -> final_service_end_dt
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail where client_id = 2844074
and  delete_sw = 'N' 
-- payment_id = 3427221;*/


update tb_payment_detail
set final_service_end_dt = '2022-10-03',
	update_user_id='CDM-41955',
	update_ts =now() 
where payment_id = 3427221;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 2114587;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2022-10-03', 
	update_user_id='CDM-41955',
	update_ts =now() 
WHERE authorization_id  = 2114587;



/*
2. Client ID: 2844099 (ELIJAH HIRSCH),
a) Need to end the Service Log and Purchase Authorization (2114588) with 07/01/2022.
b) Need to end the Purchase Authorization (2883463) with 07/01/2023 and remove the Service Log End date (07/01/2026)
*/

--2a
--a) Need to end the Service Log and Purchase Authorization (2114588) with 07/01/2022.

UPDATE cjams.tb_service_log
SET end_dt='2022-07-01', 
	estimated_end_dt= '2022-07-01',
	end_service_reason_cd = 1824,
	update_user_id='CDM-41955', update_ts=now() 
WHERE service_log_id = 2302742;


/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 2302742;
*/
/*update tb_service_purchase_authorization table with authorization_id = 2114588
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2022-07-01', 
	update_user_id='CDM-41955',
	update_ts =now() 
WHERE authorization_id  = 2114588;

/*payment table --> tb_payment_detail -> final_service_end_dt
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail where client_id = 2844099
and  delete_sw = 'N' 
-- payment_id = 3427219;*/


update tb_payment_detail
set final_service_end_dt = '2022-07-01',
	update_user_id='CDM-41955',
	update_ts =now() 
where payment_id = 3960323;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 2114588;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2022-07-01', 
	update_user_id='CDM-41955',
	update_ts =now() 
WHERE authorization_id  = 2114588;


--2b
--b) Need to end the Purchase Authorization (2883463) with 07/01/2023 and remove the Service Log End date (07/01/2026)

/*
select estimated_end_dt,* from cjams.tb_service_log where service_log_id = 2933984
*/

UPDATE cjams.tb_service_log
SET end_dt=NULL, 
	end_service_reason_cd = null,
	update_user_id='CDM-41955', update_ts=now() 
WHERE service_log_id = 2933984;


/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 2933984;
*/
/*update tb_service_purchase_authorization table with authorization_id = 2883463
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2023-07-01', 
	update_user_id='CDM-41955',
	update_ts =now() 
WHERE authorization_id  = 2883463;

/*payment table --> tb_payment_detail -> final_service_end_dt
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail where client_id = 2844074
and  delete_sw = 'N' 
-- payment_id = 3960290;*/


update tb_payment_detail
set final_service_end_dt = '2023-07-01',
	update_user_id='CDM-41955',
	update_ts =now() 
where payment_id = 3960290;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 2883463;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2023-07-01', 
	update_user_id='CDM-41955',
	update_ts =now() 
WHERE authorization_id  = 2883463;