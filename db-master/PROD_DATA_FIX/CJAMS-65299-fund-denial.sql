/*
Issue Description: CJAMS-65299 Returned service log
Category/Module: GAP Subsidy
Root cause: User requested to update the servicelog status to denied
Client ID: 4389101 (SKYLAR RADAR)
Provider ID#: 5013914 (Abigail Hamlin)
Auth ID#: 4126100
*/

/*

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('adf8261b-9296-4588-b7c5-26f64bfcdca4', 'PCAUTHR', 'e8c75833-c2bb-4381-990d-0f520f021f93', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '4126100', 44, 1, 'e8c75833-c2bb-4381-990d-0f520f021f93', '2026-01-30 13:06:57.588', 'e8c75833-c2bb-4381-990d-0f520f021f93', '2026-01-30 13:06:57.588', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('da0b4694-0ea6-4b6f-8e13-9296d6c71214', 'PCAUTH', 'e1afd4ef-a333-4e96-9f76-e118fdc13cc8', 'e8c75833-c2bb-4381-990d-0f520f021f93', '1c2a4db3-e774-43c1-bf2d-4d89ee1d2c50', 'CWSP', 'LDSSPM', '4126100', 42, 0, 'e1afd4ef-a333-4e96-9f76-e118fdc13cc8', '2026-01-30 13:00:44.871', 'e1afd4ef-a333-4e96-9f76-e118fdc13cc8', '2026-01-30 13:06:57.588', true, 'Forwarded to Program Manager Approval', NULL, 'Purchase Authorization Forwarded to Program Manager Approval', '251030516716', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('a42535d3-7ea0-4f08-984e-bccc2ad88f7c', 'PCAUTHR', 'e1afd4ef-a333-4e96-9f76-e118fdc13cc8', 'e8c75833-c2bb-4381-990d-0f520f021f93', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'LDSSPM', '4126100', 42, 0, 'e1afd4ef-a333-4e96-9f76-e118fdc13cc8', '2026-01-30 11:12:11.025', 'e1afd4ef-a333-4e96-9f76-e118fdc13cc8', '2026-01-30 13:00:44.871', true, 'Forwarded to Program Manager Approval', NULL, 'Purchase Authorization Forwarded to Program Manager Approval', '251030516716', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('f5ebe6d4-70cc-4dc9-aa5f-047e30451f9d', 'PCAUTHR', 'e1afd4ef-a333-4e96-9f76-e118fdc13cc8', 'e8c75833-c2bb-4381-990d-0f520f021f93', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'LDSSPM', '4126100', 62, 0, 'e1afd4ef-a333-4e96-9f76-e118fdc13cc8', '2026-01-30 09:06:04.284', 'e1afd4ef-a333-4e96-9f76-e118fdc13cc8', '2026-01-30 11:12:11.025', true, 'Denied', NULL, 'Justification needs to be corrected.  ', '251030516716', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


*/

DELETE FROM cjams.routing
WHERE routingid='adf8261b-9296-4588-b7c5-26f64bfcdca4';

DELETE FROM cjams.routing
WHERE routingid='da0b4694-0ea6-4b6f-8e13-9296d6c71214';

DELETE FROM cjams.routing
WHERE routingid='a42535d3-7ea0-4f08-984e-bccc2ad88f7c';

DELETE FROM cjams.routing
WHERE routingid='f5ebe6d4-70cc-4dc9-aa5f-047e30451f9d';





update routing 
set activeflag = 1,
	updatedby = 'CJAMS-65299',
	updatedon = now()	
where routingid = '06f11619-961b-47ba-b43d-5425e89a6a70'
and	eventcode = 'PCAUTHR'
and objectid = '4126100'
and activeflag = 0;