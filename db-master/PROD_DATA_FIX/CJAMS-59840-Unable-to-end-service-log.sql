/*
   Issue Description: CJAMS-59840- service log end date
   Category/ Module  : Service log
   Root cause: User Error
   Fix Provided: Data fix to update the end date requested by user
*/
--select end_dt,estimated_end_dt ,* from tb_service_log tsl where service_log_id  = '909866'

update tb_service_log
set end_dt = '2025-02-21',
	estimated_end_dt = '2025-02-21',
	end_service_reason_cd = '1824',
	update_ts = now(), 
	update_user_id = 'CJAMS-59840'
where delete_sw = 'N' and service_log_id in (909866);
