/*
Issue Description: Need to change the Purchase Authorization End date from 02/16/2027 to 10/27/2022
Category/Module: Error
Root cause: Service log date was set to 2027 causing overlapping error when creating new ones
Fix provided: DB query to change the purchase authorization date
Data/Code fix ticket#: CDM-42007
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating date in tb_service_purchase_authorization
update tb_service_purchase_authorization
set end_dt = '2022-10-27', update_user_id = 'CDM-42007', update_ts = now()
where authorization_id = 1859456;

--Updating tb_payment_detail
update tb_payment_detail
set final_service_end_dt = '2022-10-27', update_user_id = 'CDM-42007', update_ts = now()
where payment_id = 3256572;