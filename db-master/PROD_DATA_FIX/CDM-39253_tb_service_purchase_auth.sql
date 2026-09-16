/*
   Issue Description: CDM-39253
   Category/ Module :  Purchase auth funding dashboard
   Root cause: purchase auth was sent again but the funding date is not null
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.tb_service_purchase_authorization
SET funding_approval_status_cd=null, update_ts=now(), update_user_id='CDM-39253', funding_approval_dt= null
WHERE authorization_id=3039054 and service_log_id=1996677;
