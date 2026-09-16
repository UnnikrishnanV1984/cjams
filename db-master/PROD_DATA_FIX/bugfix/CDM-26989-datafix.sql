-- CDM-26989 - Service Log - Purchase Authorization approval
/*
-- Issue Description: 
	1. Purchase Authorization is still showing as pending even after it is approved.
	
-- Category/ Module: Pending Approval Inbox
-- Root cause: Multiple records exists with pending approval status.

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('3299e919-1a94-462b-9c60-5d31b92d529d', 'PCAUTH', '00b6c98a-472c-481e-ae79-ccdd318ded4f', 'fa484839-8478-4808-9412-261477e894e7', '5c0dcfd4-59bc-4280-8bc2-fd2f724389b7', 'CWCW', 'CWSP', '1864020', 39, 1, '00b6c98a-472c-481e-ae79-ccdd318ded4f', '2022-11-22 11:34:20.275', 'CDM-6989', '2022-11-30 12:08:23.806', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3306552', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('73513555-37df-463c-aaf3-01eaa3e8e857', 'PCAUTHR', 'fa484839-8478-4808-9412-261477e894e7', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c', 'CWSP', 'FNSFS', '1864020', 40, 1, 'fa484839-8478-4808-9412-261477e894e7', '2022-11-23 10:38:25.753', 'CDM-6989', '2022-11-30 12:08:23.806', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3306552', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('9062f9b7-cbe1-4ede-949c-cb67e18c06a8', 'PCAUTHR', 'fa484839-8478-4808-9412-261477e894e7', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c', 'CWSP', 'FNSFS', '1864020', 40, 1, 'fa484839-8478-4808-9412-261477e894e7', '2022-11-23 10:39:26.366', 'fa484839-8478-4808-9412-261477e894e7', '2022-11-23 10:39:26.366', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3306552', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


select 	routingstatustypeid, activeflag, * from routing
where 	routingid in ('3299e919-1a94-462b-9c60-5d31b92d529d',
		'73513555-37df-463c-aaf3-01eaa3e8e857',
		'9062f9b7-cbe1-4ede-949c-cb67e18c06a8');

delete 	from routing
where 	routingid in ('3299e919-1a94-462b-9c60-5d31b92d529d',
		'73513555-37df-463c-aaf3-01eaa3e8e857',
		'9062f9b7-cbe1-4ede-949c-cb67e18c06a8');
