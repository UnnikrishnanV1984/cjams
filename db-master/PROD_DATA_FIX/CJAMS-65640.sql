/*
Issue:Need data fix to remove the Purchase Authorization records for Auth ID # 4237169 
Root Cause: requested to update   Purchase Authorization records
Fix Provided (Data Fix Only):Data fix was done by remove purchase authorization records
Data/Code fix ticket#: CJAMS-65640
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


UPDATE tb_service_purchase_authorization SET delete_sw = 'Y', update_ts= now(), 
update_user_id = 'CJAMS-65640' WHERE authorization_id  ='4237169' and delete_sw = 'N';
