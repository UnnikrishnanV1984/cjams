/*
Issue Description: Need to change the Service Log Estimated End date, Actual End date and Purchase Authorization End date to 06/30/2021
Category/Module: Error
Root cause: Service log date was set to 2026 causing overlapping error when creating new ones
Fix provided: DB query to change the purchase authorization date
Data/Code fix ticket#: CDM-42070
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating tb_service_log
update tb_service_log
set estimated_end_dt = '2021-06-30', end_dt = '2021-06-30', update_user_id = 'CDM-42070', update_ts = now()
where service_log_id = 1990534;

--Updating tb_service_purchase_authorization
update tb_service_purchase_authorization
set end_dt = '2021-06-30', update_user_id = 'CDM-42070', update_ts = now()
where authorization_id = 1767236;

--Updating tb_payment_detail
update tb_payment_detail
set final_service_end_dt = '2021-06-30', update_user_id = 'CDM-42070', update_ts = now()
where payment_detail_id = 4179441;