/*
Issue Description: 3121145:service log payment issue
Category/Module: User Request
Root cause: User Request, Requested to remove the purchase authorizations from Client ID: 1753262 (TYAJA DRAPER) 
Fix provided: Data fix is done to remove the purchase authorization for Auth id: 4237273, 4237198, 4237196, 4237194, 4237188, 4237187, 4237186, 4237185, 4237182, and 4237180
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Request
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update tb_service_purchase_authorization
set delete_sw = 'Y', update_ts = now(), update_user_id = 'CJAMS-67934'
where authorization_id in ('4237273', '4237198', '4237196', '4237194','4237188', '4237187', '4237186', '4237185', '4237182', '4237180') and delete_sw ='N' and sprvsr_approval_status_cd is null
and ads_approval_status_cd is null
and funding_approval_status_cd is null
and payment_approval_status_cd is null ;