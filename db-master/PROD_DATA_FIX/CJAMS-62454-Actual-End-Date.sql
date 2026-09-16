/*
Issue Description: :After providing the client with services, I am unable to add the "Actual End Date" so that the service case can be closed.
Category/Module: Support
Root cause: The Service log is associated with a CPS program ending on "09/05/2025" and the Purchase Auth# 3867629 is ended with "09/10/2025"  which is beyond the CPS program end date. The Estimated End date is not allowed to enter beyond the CPS program end date and the Actual End date is not allowed to enter prior to the Purchase Auth# end date and greater than the Estimated End date. 
Fix provided: DB queries to update  record in tb_service_log table.
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/

--"09/10/2025"
UPDATE cjams.tb_service_log
SET end_dt='2025-09-10', 
	estimated_end_dt = '2025-09-10',
	end_service_reason_cd = '1824', --service completed
	update_user_id='CJAMS-62454', 
	update_ts=now() 
WHERE service_log_id = 3768100;