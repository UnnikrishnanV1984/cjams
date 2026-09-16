 /*
   Issue Description:  CIDM-5900 Accidentally Submit Request in Production Environment
   Category/ Module  :  Purchase auth
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

delete from routing   
where routingid = '468a2256-5f0f-4318-8780-1bdd2d07f579'
	and objectid = '1786732'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;	
	
/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('468a2256-5f0f-4318-8780-1bdd2d07f579', 'PCAUTH', '9df19efb-3082-45eb-8bd2-e75f3554524f', '546a4780-3036-4bca-93d1-dc3722871dba', '452febf8-428b-4836-b8e2-9125ace6307b', 'CWPS', 'CWSP', '1786732', 39, 0, '9df19efb-3082-45eb-8bd2-e75f3554524f', '2022-10-20 06:48:23.252', 'CIDM-5900', '2022-10-26 07:27:00.469', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3301982', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
