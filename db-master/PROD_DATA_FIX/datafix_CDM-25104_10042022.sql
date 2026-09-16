-- CDM-25104 - Service Provider Closure
/*
-- Issue Description: 
   Purchase authorization pending routing record where Srevice Log is a deleted record 
   
-- Provider ID: 5001962	(Trala Matthews) - Local Department Home
-- Case ID: 3014284
-- Client ID: 1063347 (TYSHEKIA	L WAPLES) - 53b306c2-404c-4c81-83a2-7e37bd51e8c1
-- Auth # 182984 - 2011-05-11 To 2011-05-14 - $120.00 - Respite Care (Paid) 

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Incomplte Purchase authorization - Migrated Data 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, sprvsr_approval_status_cd, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 182984
	and delete_sw = 'N' ;

update tb_service_purchase_authorization 	
set sprvsr_approval_status_cd = '3281', -- Denied
	update_ts = now(), 
	update_user_id = 'CDM-25104'
where authorization_id = 182984
	and delete_sw = 'N';
	
-- NO routing data