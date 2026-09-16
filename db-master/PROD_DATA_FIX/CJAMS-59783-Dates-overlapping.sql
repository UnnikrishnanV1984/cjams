/*
Issue Description: Case# 251030461551, Client ID: 200669877 (Xavier Moorer Jr.)
    Service log dated (04/29/2025 - 04/29/2025) - Need to change the Estimated & Actual begin date to '04/01/2025', the end date remains same.
    Service log date (05/05/2025 - 05/05/2025)  - Need to change the Estimated & Actual begin date to '05/01/2025' and Estimated & Actual end date to '05/31/2025'. The same needs to be updated on the Service log print as well.
Category/Module: Support
Root cause: User Error
Fix provided: DB query to update the start and end date of the service log
Regression Impacts: Service log
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update tb_service_log
set start_dt = '2025-04-01',
	estimated_start_dt = '2025-04-01',
	update_user_id = 'CJAMS-59783', 
	update_ts = now()
where service_log_id = 3685647 and delete_sw = 'N';

update tb_service_log
set start_dt = '2025-05-01',
	estimated_start_dt = '2025-05-01',
	end_dt = '2025-05-31',
	estimated_end_dt= '2025-05-31',
	update_user_id = 'CJAMS-59783', 
	update_ts = now()
where service_log_id = 3686473 and delete_sw = 'N';
