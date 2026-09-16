/*
   Issue Description: CDM-15415
   Category/ Module  : payment approval
   Root cause: user wants to change
   Pull request# for code fix: 
   Reason why no related code fix: user wants to removal pending approval even after it is approved so removing with status 40 and active flag1  record
  backup data:
   
	INSERT INTO cjams.routing
	(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('159543fa-f35b-433b-bed8-6d0e4b395900'::uuid, 'PCAUTHR', '7cf77857-7a72-4b32-999d-fd0eacf88f37', 'df4e91fc-5824-45b0-baae-788cacf3bc79', '31eabbb0-f686-41dc-94d3-a3c26b12043a'::uuid, 'CWSP', 'FNSFS', '1784483', 40, 1, '7cf77857-7a72-4b32-999d-fd0eacf88f37', '2021-07-09 13:33:45.501', '7cf77857-7a72-4b32-999d-fd0eacf88f37', '2021-07-09 13:33:45.501', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020024402740', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
		
	delete from routing where routingid='159543fa-f35b-433b-bed8-6d0e4b395900';