/*
Issue Description: Service Log end date overlapping with another service log. 
    Case ID: 3277101
    Client ID: 3018202 (ADIMERE OYUELAFLORES)
    Provider ID: 5036607 (Baltimore City Department of Social Services)
    Client Program Name: Out of Home (OOH)
    OOH PA End Date: 08/19/2025
    Last Auth End Date: 08/31/2025
Category/Module: Support
Root cause: User Request, As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.
In this case, the client program is ended prior to the latest purchase authorization end-date in the service log. So data fix is needed to ended the respective open service log with 08/31/2025.
Fix provided: DB queries to update  record in tb_service_log table.
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/

--"2025-08-31"
UPDATE cjams.tb_service_log
SET end_dt='2025-08-31', 
	estimated_end_dt = '2025-08-31',
	end_service_reason_cd = '1824', --service completed
	update_user_id='CJAMS-62451', 
	update_ts=now() 
WHERE service_log_id = 2704612;