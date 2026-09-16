/*
Issue:Need data fix to remove the Purchase Authorization records.
Root Cause: requested to update   Purchase Authorization records
Fix Provided (Data Fix Only):Data fix was done by remove purchase authorization records
Data/Code fix ticket#: CJAMS-65333
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


UPDATE tb_service_purchase_authorization 
SET delete_sw = 'Y', update_ts= now(), update_user_id = 'CJAMS-65333' 
WHERE authorization_id in ('4237336', '4237338', '4237347') and delete_sw = 'N'  
    and sprvsr_approval_status_cd is null
    and ads_approval_status_cd is null
    and funding_approval_status_cd is null
    and payment_approval_status_cd is null ;
