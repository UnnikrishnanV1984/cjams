 /*  Issue Description: CDM-7071-Vouchers in Funding Approval
   Category/ Module  :  Service log purchase authorization
   Root cause: Unable to reproduce it.So making data fix for removing the unwanted routing
   Pull request# for code fix: Unable to reproduce it.
   Reason why no related code fix: Unable to reproduce it.
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup for deletion: 
  INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('fc496595-f060-4c6d-bff9-38937ccfeb0f', 'PCAUTHR', '07973380-5006-4c77-a5f5-8194e523a481', '753c40c4-34fd-4e88-9e2a-f974a416d51a', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'CWSP', 'FNSFS', '1748862', 40, 1, '07973380-5006-4c77-a5f5-8194e523a481', '2020-11-04 10:26:26.640', '07973380-5006-4c77-a5f5-8194e523a481', '2020-11-04 10:26:26.640', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '20200140855', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
 delete from routing where objectid=1748862 and routingstatustypeid=40 and activeflag=1 and routingid = 'fc496595-f060-4c6d-bff9-38937ccfeb0f';
update routing set tosecurityusersid='753c40c4-34fd-4e88-9e2a-f974a416d51a',activeflag=0,updatedby='CDM-7071',updatedon=now() where objectid=1745972 and 
routingstatustypeid=40 and activeflag=1 and routingid = '036b4670-f863-413b-b923-c4615864b232';