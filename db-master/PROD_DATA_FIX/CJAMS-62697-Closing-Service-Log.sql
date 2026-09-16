/*
Issue: 3304006:Hi, I am trying to close am Out of Home case from a youth who has aged out of care. Prior to closing his case i attempted to close one of his service logs and i am unable.
Root Cause: User Error, . As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.
In this case, the client program is ended prior to the latest purchase authorization end-date in the service log. So data fix is needed to ended the respective open service log with 08/31/2025.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_log table.
Data/Code fix ticket#: CJAMS-59848
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

UPDATE cjams.tb_service_log
SET end_dt='2025-08-31', 
	estimated_end_dt = '2025-08-31',
	end_service_reason_cd = '1824', --service completed
	update_user_id='CJAMS-62697', 
	update_ts=now() 
WHERE service_log_id = 2944379;