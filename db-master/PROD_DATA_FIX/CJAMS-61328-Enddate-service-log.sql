/*
Issue Description:CJAMS-61328 Unable to end service logs - preventing case closure
Category/Module: Service Logs
Root cause: Service log not enddate for the client : 3438856 (Lyrik Grayson), Provider ID: 6004697 (Beatrice Collins), Service: Housing (Paid), Start date: 04/01/2020.
			This is preventing closure of ROH.
			Data fix needed for the following
			1. The Service log Estimated End date and Actual End date needs to be "09/24/2021".
			2. The same dates needs to be updated on the Service log print as well.
Fix provided: Data fix has been done to end date the estimated and actual service log.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: Service log needs to be endated for ROH closure and data fix should resolve it.
*/

update tb_service_log
set end_dt= '2021-09-24',
	estimated_end_dt = '2021-09-24',
	update_ts= now(),
	update_user_id = 'CJAMS-61328'
where 	client_id=3438856 
	and service_log_id=2021918