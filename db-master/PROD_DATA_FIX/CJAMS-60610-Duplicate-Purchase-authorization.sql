
/*
Issue:241030398924:Duplicate service log created. CJAMS froze and created a second service log without me even opening a new one. 3835303 needs to be deleted
Root Cause:User could not able to delete the one without any status should be removed from the Purchase Authorization list. They can only create .
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_purchase_authorization.
Data/Code fix ticket#: CJAMS-60610
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_service_purchase_authorization
set delete_sw = 'Y',update_ts = now(), update_user_id = 'CJAMS-60610'
where authorization_id = '3835303' and service_log_id = '3726951' and delete_sw ='N';