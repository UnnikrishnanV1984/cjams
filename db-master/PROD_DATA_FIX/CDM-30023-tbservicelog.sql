/*
   Issue Description: CDM-30023
   Category/ Module  :
   Root cause: For the Case 3295673:The Actual end date for these service logs need to be taken out. The case will probably close before 2030 and 2032. Those actual end dates need to be removed and kept open. 
                and Updated the end_dt to null in tb_service_log table
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2030-05-06
update
	tb_service_log
set
	end_dt = null,
	estimated_end_dt = null,
	update_user_id = 'CDM-30023',
	update_ts = now()
where
	service_log_id = 919558;