/*Issue:Service log glitch for client katherine osorto lopez. servicelogs submitted on 02/02/2026 were not sent to supervisor for approval.
Root Cause: service log glitch caused duplicate purchase authorization records to be created for the same service log, which caused the system to not send the service log for supervisor approval.
Fix Provided (Data Fix Only):Data fix to solf-delete the duplicate purchase authorization records and update the service log records to mark them as deleted, which will allow the system to send the service logs for supervisor approval.
Data/Code fix ticket#: CJAMS-65628
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error caused by service log glitch. The purchase authorization records were created in error due to the service log glitch, which caused the system to not send the service logs for supervisor approval.
Backup before update/ delete:Query:
select * from tb_service_purchase_authorization where authorization_id  in('4237352','4237351','4237349','4237346','4237340','4237335','4237328','4237327','4237325','4237321','4237317','4237312');
l ;
*/


UPDATE tb_service_purchase_authorization
SET delete_sw = 'Y', 
update_ts= now(), 
update_user_id = 'CJAMS-65628' 
WHERE authorization_id  in('4237352','4237351','4237349','4237346','4237340','4237335','4237328','4237327','4237325','4237321','4237317','4237312') and delete_sw = 'N'
    and sprvsr_approval_status_cd is null
    and ads_approval_status_cd is null
    and funding_approval_status_cd is null
    and payment_approval_status_cd is null ;