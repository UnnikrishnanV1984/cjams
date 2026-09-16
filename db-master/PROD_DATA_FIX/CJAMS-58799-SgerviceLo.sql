
/*
Issue Description: Service Log end date overlapping with another service log. 
Category/Module: Support
Root cause: Service Log end date is missing which is preventing the user to close the case.
Fix provided: DB queries to update  record in tb_service_log table.
Data/Code fix ticket#: CJAMS-58799
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/

--10/02/2024
UPDATE cjams.tb_service_log
SET end_dt='2024-10-02', 
	end_service_reason_cd = '1824', --service completed
	update_user_id='CJAMS-58799', 
	update_ts=now() 
WHERE service_log_id = 1998330;
