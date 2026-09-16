/*
 Issue Description: CJAMS-68677
 Category/Module: Case pending approval
 Root cause: User requested to remove the purchase auth from case pending approval dashboard
 Fix Provided: As requested by user fix was provided by removing the purchase auth from case pending approval dashboard
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/


update routing
set activeflag =0, updatedby ='CJAMS-68677', updatedon =now()
where objectid ='4442597' and routingid ='192f60d2-7cbf-4ab2-82d3-1e3ea52a88a4' and activeflag =1;

update tb_service_purchase_authorization
set delete_sw='Y', update_user_id ='CJAMS-68677', update_ts =now()
where authorization_id = 4442597 and delete_sw = 'N' ;