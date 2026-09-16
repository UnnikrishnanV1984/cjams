/*
Issue Description: 221030014180:Service Log Request Denials
Category/Module: User Request
Root cause: User Request, Requested to remove the purchase authorizations from Client id : 4074204  
Fix provided: Data fix is done to remove the purchase authorization for Auth id:3129948
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Request
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update tb_service_purchase_authorization
set delete_sw = 'Y', update_ts = now(), update_user_id = 'CJAMS-66543'
where authorization_id ='3129948' and delete_sw ='N' and sprvsr_approval_status_cd is null
and ads_approval_status_cd is null
and funding_approval_status_cd is null
and payment_approval_status_cd is null ;