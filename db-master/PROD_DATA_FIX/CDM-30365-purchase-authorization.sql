/*
   Issue Description: CDM-30365
   Category/ Module  : Purchase authorization
   Root cause: User requested to delete the pending approval for purchase authorization as its already approved 
   Pull request# for code fix:
   Reason why no related code fix: 
    requested a data fix to resolve

    -- To Revert the data if needed

  INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, insertedon, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 43, 'Approved', '2021-11-15 18:59:38.714', '2e5b723b-5e2e-481d-9ca2-15f893a425b0', 'PCAUTHR', 'c07b1fd9-106b-4488-8f7e-0c26876723f7', '676ac1ec-f338-4646-a786-b3af379986f9', '2546af4b-b0f4-4b5f-a21f-5d27602a7c9d', 'FNSFS', 'FNSFS', '1803232', 43, 1, 'c07b1fd9-106b-4488-8f7e-0c26876723f7', '2021-11-15 18:59:38.714', 'c07b1fd9-106b-4488-8f7e-0c26876723f7', '2021-11-15 18:59:38.714', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, insertedon, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 43, 'Approved', '2021-11-15 18:59:13.921', 'f7fd16e6-6bc7-4a14-bc3b-582785fcd62c', 'PCAUTHR', 'c07b1fd9-106b-4488-8f7e-0c26876723f7', '676ac1ec-f338-4646-a786-b3af379986f9', '2546af4b-b0f4-4b5f-a21f-5d27602a7c9d', 'FNSFS', 'FNSFS', '1803232', 43, 1, 'c07b1fd9-106b-4488-8f7e-0c26876723f7', '2021-11-15 18:59:13.921', 'c07b1fd9-106b-4488-8f7e-0c26876723f7', '2021-11-15 18:59:13.921', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, insertedon, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', '2021-11-08 14:26:24.935', 'b93f6804-4cfb-40a2-8dc3-1184f70dc593', 'PCAUTHR', 'bb4ef31b-f5f2-453e-88dc-f3789f2f8ba3', 'c07b1fd9-106b-4488-8f7e-0c26876723f7', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFW', '1803232', 40, 1, 'bb4ef31b-f5f2-453e-88dc-f3789f2f8ba3', '2021-11-08 14:26:24.935', 'bb4ef31b-f5f2-453e-88dc-f3789f2f8ba3', '2021-11-08 14:26:24.935', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3108183', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, insertedon, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', '2021-11-08 14:25:27.943', 'c9d3f17c-0f96-4282-b03c-cb9b2f9a9018', 'PCAUTHR', 'bb4ef31b-f5f2-453e-88dc-f3789f2f8ba3', 'c07b1fd9-106b-4488-8f7e-0c26876723f7', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFW', '1803232', 40, 1, 'bb4ef31b-f5f2-453e-88dc-f3789f2f8ba3', '2021-11-08 14:25:27.943', 'bb4ef31b-f5f2-453e-88dc-f3789f2f8ba3', '2021-11-08 14:25:27.943', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3108183', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, insertedon, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 39, 'Forwarded to Case Supervisor', '2021-11-08 11:36:44.534', '70da6f41-f226-4d66-9adb-d9ea5ac4c0de', 'PCAUTH', '04aa31cf-b21a-48eb-83e6-c7d10df652c2', 'bb4ef31b-f5f2-453e-88dc-f3789f2f8ba3', 'b3d2dd67-8cc0-4d57-9f59-1f493a6326a3', 'CWCW', 'CWSP', '1803232', 39, 1, '04aa31cf-b21a-48eb-83e6-c7d10df652c2', '2021-11-08 11:36:44.534', '04aa31cf-b21a-48eb-83e6-c7d10df652c2', '2021-11-08 11:36:44.534', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3108183', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

delete from routing where routingid
	in ( 
			'2e5b723b-5e2e-481d-9ca2-15f893a425b0',
			'f7fd16e6-6bc7-4a14-bc3b-582785fcd62c',
			'b93f6804-4cfb-40a2-8dc3-1184f70dc593',
			'c9d3f17c-0f96-4282-b03c-cb9b2f9a9018',
			'70da6f41-f226-4d66-9adb-d9ea5ac4c0de'
			
		)
	and objectid = '1803232' ;