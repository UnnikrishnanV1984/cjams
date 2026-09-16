/*
Issue Description: Need data fix to end date the Service Log with 09/02/2024.
Category/Module: Error
Root cause: Child's removal was end-dated which end dated the Program assignment.
Fix provided: DB queriy to modify estimated and actual start date
Data/Code fix ticket#: CDM-41589
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CDM-41589
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating end dates in tb_service_log
update tb_service_log
set 
	start_dt = '2024-09-02', estimated_start_dt = '2024-09-02', end_dt = '2024-09-02', estimated_end_dt = '2024-09-02',
	end_service_reason_cd = 1824, update_user_id = 'CDM-41589', update_ts = now()
where service_log_id = 3503802;