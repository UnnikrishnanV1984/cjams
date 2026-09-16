/*
Issue Description:3168775:This is an old service log, that needs to be deleted. : This provider cannot be closed until all outstanding purchase authorizations (( Case ID: 3168775, Auth ID: 296320, Date: 2012-10-20 )) 
Root cause: User request to change the satus.due to they do not have access to create.
Fix provided: DB query to udate tb_service_purchase_authorization.
Data/Code fix ticket#:CJAMS-61614
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


--Updating this authorization as Denied
-- Update tb_service_purchase_authorization
update tb_service_purchase_authorization
set ads_approval_status_cd = '3281', -- Denied
 ads_approval_dt = now(),
 update_ts = now(), 
 update_user_id = 'CJAMS-61614'
where authorization_id = 296320
and delete_sw = 'N';


update routing set activeflag=0, updatedby = 'CJAMS-61614', updatedon = now() 
where routingid = '310c236e-82ee-4e5c-9d17-54fb02ab6b77' and activeflag = 1;



insert into routing
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,activeflag,insertedby,insertedon,updatedby,updatedon,isreviewrequest,remarks,servicerequestnumber,objecttypekey)
values(gen_random_uuid(),'PCAUTH','f3ba0abc-1278-4f79-ae3c-dfb167940c87','73815178-37a6-492e-9466-3b43144c0202','3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a',
'CWSP','FNSFS','296320','62',1,'CJAMS-61614',now() ,'CJAMS-61614',now() ,true,'Denied','3168775','ServiceCase');

