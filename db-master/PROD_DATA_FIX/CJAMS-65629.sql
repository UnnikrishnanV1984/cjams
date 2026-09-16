
/*
Issue: CJAMS-65629 Delete duplicate purchase authorization records
Category/Module: Service log
Root cause:  Service log glitch caused duplicate purchase authorization records to be created for the same service log.
Fix provided:  Soft-delete the duplicate purchase authorization records.
Data/Code fix ticket#: CJAMS-65629
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error caused by service log glitch. The purchase authorization records were created in error due to the service log glitch.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
select * from tb_service_purchase_authorization where authorization_id in ('4237344','4237343','4237341','4237331','4237330','4237318','4237316','4237314','4237313','4237309');
*/

update tb_service_purchase_authorization
set delete_sw = 'Y', 
update_ts = now(), 
update_user_id= 'CJAMS-65629' 
where authorization_id in ('4237344','4237343','4237341','4237331','4237330','4237318','4237316','4237314','4237313','4237309')
and sprvsr_approval_status_cd is null
and ads_approval_status_cd is null
and funding_approval_status_cd is null
and payment_approval_status_cd is null;