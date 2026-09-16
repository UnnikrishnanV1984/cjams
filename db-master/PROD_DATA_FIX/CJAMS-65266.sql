
/*
Issue: Removed the duplicate service purchase authorizations created in error.
Root Cause: Multiple flex funds for the same date during a system timeout
Fix Provided (Data Fix Only): Soft deleted the duplicate purchase authorizations created in error from the tb_service_purchase_authorization table.
Data/Code fix ticket#: CJAMS-65266
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue caused by system timeout.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
select * from tb_service_purchase_authorization where authorization_id in ('4237348','4237339','4237333','4237332','4237326','4237319') and delete_sw = 'N';
*/

UPDATE tb_service_purchase_authorization
SET delete_sw = 'Y', 
update_ts= now(), 
update_user_id = 'CJAMS-65266' 
WHERE authorization_id  in('4237348','4237339','4237333','4237332','4237326','4237319') and delete_sw = 'N'
    and sprvsr_approval_status_cd is null
    and ads_approval_status_cd is null
    and funding_approval_status_cd is null
    and payment_approval_status_cd is null ;