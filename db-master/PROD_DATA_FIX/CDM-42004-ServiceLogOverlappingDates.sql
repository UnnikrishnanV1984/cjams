/*
Issue Description: Need to change the Service Log Estimated End date, Actual End date and Purchase Authorization End date from 07/31/2026 to 07/01/2020
Category/Module: Error
Root cause: Service log date was set to 2026 causing overlapping error when creating new ones
Fix provided: DB queries to change the dates
Data/Code fix ticket#: CDM-42004
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating dates in tb_service_log
update tb_service_log
set end_dt = '2020-07-01', estimated_end_dt = '2020-07-01', update_user_id = 'CDM-42004', update_ts = now()
where service_log_id = 1991453;

--Updating date in tb_service_purchase_authorization
update tb_service_purchase_authorization
set end_dt = '2020-07-01', update_user_id = 'CDM-42004', update_ts = now()
where authorization_id = 1768312;

--Updating tb_payment_detail
update tb_payment_detail
set final_service_end_dt = '2020-07-01', update_user_id = 'CDM-42004', update_ts = now()
where payment_id = 3035288;