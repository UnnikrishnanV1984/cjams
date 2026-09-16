/*  Issue Description: CDM-7482-Cannot Approve Payment
   Category/ Module  :  Service log purchase authorization
   Root cause: Unable to reproduce it.So making data fix for removing the unwanted routing
   Pull request# for code fix: Unable to reproduce it.
   Reason why no related code fix: Unable to reproduce it.
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup for deletion: 
	INSERT INTO cjams.routing
	(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('fe27b27c-8bf5-4455-bb12-52bea0e584ec', 'PCAUTH', 'b343fc35-3b92-4f00-a0da-c2552709c326', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '96b16cd3-9894-4afa-ae33-8c92d35f615c', 'CWCW', 'CWSP', '1751937', 39, 1, 'b343fc35-3b92-4f00-a0da-c2552709c326', '2020-11-23 13:58:32.147', 'b343fc35-3b92-4f00-a0da-c2552709c326', '2020-11-23 13:58:32.147', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3302709', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
	INSERT INTO cjams.routing
	(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('60047d47-bf38-4322-b323-02c763a7cfcd', 'PCAUTHR', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', NULL, 'e8fa60b9-84fa-4e2f-97d2-25496b4cb0f3', 'CWSP', 'FNSFS', '1751937', 40, 1, '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2020-12-03 13:23:27.426', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2020-12-03 13:23:27.426', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3302709', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


*/
 delete from routing where objectid=1751937 and routingstatustypeid in (39,40) and activeflag=1 and routingid in ('fe27b27c-8bf5-4455-bb12-52bea0e584ec','60047d47-bf38-4322-b323-02c763a7cfcd');
update routing set activeflag=1,updatedby='CDM-7482',updatedon=now() where objectid=1751937 and routingstatustypeid=41 and routingid='87644fbc-c81f-4262-b54e-d02b69b2a925';
 