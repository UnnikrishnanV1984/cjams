-- CDM-26295 - Service log issue
/*
-- Issue Description: 
   User request to remove Purchase authorization with status as Returned to worker.
   Preventing the Provider Closure. 	
   
-- Provider ID: 5069740 (Janet Alexander)
-- Case ID: 211030010310
-- Client ID: 200776331 (My'Asia Cherry) - 576f9bba-4ab7-476c-b934-817b25b3d259
-- Autorization ID: 1813586 - Respite Care (Paid) - 2021-12-27 To 2022-01-01
 
-- Client ID: 200776338	(Miracle Cherry) - 14e282a7-29a1-4bd1-b8dc-d4d0a2771628
-- Autorization ID: 1813580 - Respite Care (Paid) - 2021-12-27 To 2022-01-01

-- Service Logs:
-- 2027434 update end date as 01/01/2022
-- 2039393 update end date as 04/12/2022

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Incomplte Purchase authorization - Migrated Data 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Autorization ID: 1813586 - Respite Care (Paid) - 2021-12-27 To 2022-01-01
-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, sprvsr_approval_status_cd, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1813586
	and delete_sw = 'N' 
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-26295'
where authorization_id = 1813586
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

 
-- Client ID: 200776338	(Miracle Cherry) - 14e282a7-29a1-4bd1-b8dc-d4d0a2771628
-- Autorization ID: 1813580 - Respite Care (Paid) - 2021-12-27 To 2022-01-01
select service_log_id, start_dt, end_dt, sprvsr_approval_status_cd, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1813580
	and delete_sw = 'N' ;

update tb_service_purchase_authorization 	
set sprvsr_approval_status_cd = '3281', -- Denied
	update_ts = now(), 
	update_user_id = 'CDM-26295'
where authorization_id = 1813580
	and delete_sw = 'N';


-- Service Logs:
-- 2027434 update end date as 01/01/2022
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id = 2027434
	and delete_sw = 'N';	
	
update tb_service_log
set end_dt = '2022-01-01'::date,
	end_service_reason_cd = '1824', -- Service Completed
	update_ts = now(), 
	update_user_id = 'CDM-26295'
where service_log_id = 2027434
	and delete_sw = 'N';	
	
-- 2039393 update end date as 04/12/2022
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id = 2039393
	and delete_sw = 'N';	
	
update tb_service_log
set end_dt = '2022-04-12'::date,
	end_service_reason_cd = '1824', -- Service Completed
	update_ts = now(), 
	update_user_id = 'CDM-26295'
where service_log_id = 2039393
	and delete_sw = 'N';	
