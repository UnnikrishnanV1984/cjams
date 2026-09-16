
/*
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Incomplte Purchase authorization - Migrated Data 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select service_log_id, start_dt, end_dt, sprvsr_approval_status_cd, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 212779
	and delete_sw = 'N' ;

update tb_service_purchase_authorization 	
set sprvsr_approval_status_cd = '3281', -- Denied
	update_ts = now(), 
	update_user_id = 'CDM-24213'
where authorization_id = 212779
	and delete_sw = 'N';
