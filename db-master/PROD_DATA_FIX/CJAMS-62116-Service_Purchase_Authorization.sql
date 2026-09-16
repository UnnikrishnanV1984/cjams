/*
Issue Description:3023977:This is an old service log, that needs to be deleted. : This provider cannot be closed until all outstanding purchase authorizations (( Case ID: 3168775, Auth ID: 296320, Date: 2012-10-20 )) 
Root cause: User request to change the satus.due to they do not have access to create.
Fix provided: DB query to udate tb_service_purchase_authorization.
Data/Code fix ticket#:CJAMS-62116
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
 update_user_id = 'CJAMS-62116'
where authorization_id = 226908
and delete_sw = 'N';


update routing set activeflag=0, updatedby = 'CJAMS-62116', updatedon = now() 
where routingid = '7016b317-3b48-420a-992f-cce5c3b0620d' and activeflag = 1;



insert into routing
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,activeflag,insertedby,insertedon,
updatedby,updatedon,isreviewrequest,remarks,servicerequestnumber,objecttypekey)
values(gen_random_uuid(),'PCAUTH','7c747736-2fdc-4698-8925-86a76732f7b7','25fb64ec-1346-4a3e-9a20-d47d15b9010f','3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a',
'CWSP','FNSFS','226908','62',1,'CJAMS-62116',now() ,'CJAMS-62116',now() ,true,'Denied','3023977','ServiceCase');