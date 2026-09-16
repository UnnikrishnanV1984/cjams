/*
Issue Description:3300795:Unable to locate outstanding purchase authorization in service case 3300795 that is preventing provider 5040669 closure 
Root cause: User request to change the satus.due to they do not have access to create.
Fix provided: DB query to udate tb_service_purchase_authorization.
Data/Code fix ticket#:CJAMS-61651
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
 update_user_id = 'CJAMS-61651'
where authorization_id = 1816669
and delete_sw = 'N';

--  routing
update routing 
set activeflag=0, updatedby = 'CJAMS-61651', updatedon = now() 
where routingid = '28d1e3b8-da4b-4db9-af53-98f4b213ee28' and activeflag = 1;

--routing
insert into routing
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,activeflag,insertedby,insertedon,updatedby,updatedon,isreviewrequest,remarks,servicerequestnumber,objecttypekey)
values(gen_random_uuid(),'PCAUTH','e65ee966-5d41-431a-b7f8-5bdf1fbd91b2','b60589bc-8886-40ef-a876-a5273ee42597','6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6',
'CWSP','FNSFS','1816669','62',1,'CJAMS-61651',now() ,'CJAMS-61651',now() ,true,'Denied','3300795','ServiceCase');