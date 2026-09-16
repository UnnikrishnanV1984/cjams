-- CDM-16731 - can't approve service logs
/*
-- Issue Description: 
   The Authorization # 1792603 & 1789606 is not in the Finance approval box. 
	
-- Case ID: 3270208
-- Client ID: 3682589 (DOMINIC NATHANIEL ARJUNE) - 8eff0f38-f93f-4707-846d-4e67d07717dd
-- Service Log ID: 1993924 - Service ID: 11338 One-on-One (Paid) 
-- Provider ID: 6001003	(Madi's Place, Inc.)
-- Auth ID: 1792603 - 08/01/2021 To 08/12/2021 - $3640.00
-- Auth ID: 1789606 - 07/01/2021 To 07/30/2021 - $8470.00
	
-- Current Provider Service ID: 50008640 (delete_sw = 'Y')
-- New Provider Service ID: 50011578 (delete_sw = 'N')

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: tb_service_log & tb_provider_services Data Integrity Issue
--			   Code fix was done and deployed in production by Simar 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- For all Srevice Logs
/*
Service Log ID	Case #	Client #
---------------------------------------
1993924			3682589	3270208
2004016			3216708	3199884
*/

-- Update provider_service_id in Service Log table
select service_log_id , provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 50008640
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50011578,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 50008640
	and delete_sw = 'N' ;

-- Datafix for all other records
-- old   - New
---------------------------
-- 10199 - 50010478
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 10199
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010478,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 10199
	and delete_sw = 'N' ;
	
	
-- 12030 - 50010509
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 12030
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010509,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 12030
	and delete_sw = 'N' ;
	
-- 139884 - 50010440
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 139884
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010440,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 139884
	and delete_sw = 'N' ;

-- 139886 - 50010438
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 139886
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010438,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 139886
	and delete_sw = 'N' ;

-- 151252 - 50010446
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 151252
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010446,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 151252
	and delete_sw = 'N' ;

-- 164329 - 50010635
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 164329
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010635,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 164329
	and delete_sw = 'N' ;

-- 181673 - 50010374
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 181673
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010374,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 181673
	and delete_sw = 'N' ;
	
-- 191351 - 50010500
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 191351
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010500,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 191351
	and delete_sw = 'N' ;

-- 198583 - 50010497
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 198583
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010497,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 198583
	and delete_sw = 'N' ;

-- 198964 - 50010466
select service_log_id, provider_service_id, update_ts, update_user_id, case_id, client_id 
	from tb_service_log   
where provider_service_id = 198964
	and delete_sw = 'N' ;

update tb_service_log 	
set provider_service_id = 50010466,
	update_ts = now(), 
	update_user_id = 'CDM-16731'
where provider_service_id = 198964
	and delete_sw = 'N' ;
