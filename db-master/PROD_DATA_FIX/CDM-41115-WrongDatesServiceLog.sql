/*
Issue Description: Please do a data fix to update the purchase authorization dates
Category/Module: Error
Root cause: Case Worker entered too long of a time frame for the service logs
Fix provided: DB query change the dates
Data/Code fix ticket#: CDM-41115
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating dates in tb_service_purchase_authorization
update tb_service_purchase_authorization
set end_dt = '2024-06-10', update_user_id = 'CDM-41115', update_ts = now()
where authorization_id = 3159987;

update tb_service_purchase_authorization
set start_dt = '2024-06-11', end_dt = '2024-06-11', update_user_id = 'CDM-41115', update_ts = now()
where authorization_id = 3428784;

--Updating dates in tb_payment_detail
update tb_payment_detail
set final_service_end_dt = '2024-06-10', update_user_id = 'CDM-41115', update_ts = now()
where payment_detail_id = 5424638;

update tb_payment_detail
set final_service_start_dt = '2024-06-11', final_service_end_dt = '2024-06-11', update_user_id = 'CDM-41115', update_ts = now()
where payment_detail_id = 5646098;