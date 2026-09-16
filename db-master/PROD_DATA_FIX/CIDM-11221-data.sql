/*
Issue:Need data fix to remove the Purchase Authorization records for Auth ID # 4303995 
Root Cause: requested to update   Purchase Authorization records
Fix Provided (Data Fix Only):Data fix was done by remove purchase authorization records
Data/Code fix ticket#: CIDM-11221
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


UPDATE tb_service_purchase_authorization SET delete_sw = 'Y', update_ts= now()::character varying, 
update_user_id = 'CIDM-11221' WHERE authorization_id in ( 4303995 ) 
    AND delete_sw = 'N'
    AND sprvsr_approval_status_cd IS NULL
    AND ads_approval_status_cd IS NULL
    AND funding_approval_status_cd IS NULL
    AND payment_approval_status_cd IS NULL;