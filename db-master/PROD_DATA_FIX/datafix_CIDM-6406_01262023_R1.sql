-- CIDM-6406 - CPS closed cases history not showing in application under decision tab
/*
-- Issue Description: 
  Datafix to Close impacted CPS cases in CJAMS 
  where the requested CPS worker status was inactive at the time of apporval  

-- Category/ Module: GAP (Case Management) 
-- Root cause: Flaw in the code, code fix has been promoted as a part of this defect. 
-- Fix Provided: Datafix has been promoted to remove Program Assignment End date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: 01/26/2023
*/

-- Delete  
select count(*) from routing where insertedby = 'CIDM-6406-R1' and activeflag = 1 ;
delete from routing where insertedby = 'CIDM-6406-R1' and activeflag = 1 ;

-- Inactive Workers
-- IR	20200216027140	f5643585-dbcd-46eb-8b27-6fa7d8228867
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'b0177f51-d7ac-4739-be6f-5853d05032f5', 
		'fc5aef60-c994-4575-88e1-74e286073eee', '5da69eb1-7274-4bb5-82ac-dfdc962c9e9a'::uuid, 
		'CWSP', 'CWCW', '8709aa2a-b938-4387-8590-eb4e6b74844d', 16, 1, 
		'CIDM-6406-R1', '2020-09-14 09:20:02.563', 'CIDM-6406-R1', '2020-09-14 09:20:02.563', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '20200216027140', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);


-- AR	2020034015187	7d486e5b-5ec9-44e2-8827-3bd9980402cc
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'b0177f51-d7ac-4739-be6f-5853d05032f5', 
		'fc5aef60-c994-4575-88e1-74e286073eee', '5da69eb1-7274-4bb5-82ac-dfdc962c9e9a'::uuid, 
		'CWSP', 'CWCW', '5f86203a-1a90-444c-9e51-dfc8d49f23a0', 16, 1, 
		'CIDM-6406-R1', '2020-02-20 07:58:20.586', 'CIDM-6406-R1', '2020-02-20 07:58:20.586', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2020034015187', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	202101030100955	ca8dc034-e37e-4e2c-b927-c808e56e8e19
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '30af9b82-e4d5-441f-8ede-a19af5447151', 
		'123c6461-d61c-4920-bd7f-7b2ad84a0252', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', 'e194054f-882c-473c-8f60-de10b87c6352', 16, 1, 
		'CIDM-6406-R1', '2021-08-24 15:25:28.928', 'CIDM-6406-R1', '2021-08-24 15:25:28.928', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '202101030100955', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);

-- IR	202101100102660	dd1360f6-6840-4150-96c1-3835af4b15df
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '30af9b82-e4d5-441f-8ede-a19af5447151', 
		'123c6461-d61c-4920-bd7f-7b2ad84a0252', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', '58bffeb5-e3fe-435c-83af-674f746047d0', 16, 1, 
		'CIDM-6406-R1', '2021-08-13 17:55:05.333', 'CIDM-6406-R1', '2021-08-13 17:55:05.333', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '202101100102660', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	202101110103242	777eada4-0df2-4629-827e-0f9100809885
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '30af9b82-e4d5-441f-8ede-a19af5447151', 
		'123c6461-d61c-4920-bd7f-7b2ad84a0252', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', 'a40da126-be3e-4c3a-980c-5cd92ab6fd09', 16, 1, 
		'CIDM-6406-R1', '2021-08-13 17:51:41.502', 'CIDM-6406-R1', '2021-08-13 17:51:41.502', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '202101110103242', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	202101170104864	557a43c7-a0cc-4047-89db-cc20e5d22120
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '7f6bd981-7fba-430a-a290-c4fabe0c1f93', 
		'e5b60173-955a-439f-aee3-36c11b9be479', '7ad14ba0-5ceb-42b6-8a96-5d2553d5d13f'::uuid, 
		'CWSP', 'CWCW', '5a814f7a-e3e7-47fc-91c0-e980ac7f7349', 16, 1, 
		'CIDM-6406-R1', '2021-06-22 13:38:19.146', 'CIDM-6406-R1', '2021-06-22 13:38:19.146', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '202101170104864', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);

-- IR	202101230106109	67f426de-3605-4c33-91ea-b2261b2f747b
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '7f6bd981-7fba-430a-a290-c4fabe0c1f93', 
		'e5b60173-955a-439f-aee3-36c11b9be479', '7ad14ba0-5ceb-42b6-8a96-5d2553d5d13f'::uuid, 
		'CWSP', 'CWCW', '6cb18053-56ae-4dfa-9958-c5e0e2400ddb', 16, 1, 
		'CIDM-6406-R1', '2021-06-22 13:28:00.505', 'CIDM-6406-R1', '2021-06-22 13:28:00.505', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '202101230106109', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	2021050083204	ff0189c7-392f-46ae-8a57-9ba411edacf0
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '8b83e1bf-f8d9-4430-92d5-ce6278bee1f0', 
		'db7f58f3-671b-40d4-a6a2-baf9f164204e', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', '39f85bd4-58d5-4667-b4b7-a6e80f2956c4', 16, 1, 
		'CIDM-6406-R1', '2021-03-25 13:00:13.448', 'CIDM-6406-R1', '2021-03-25 13:00:13.448', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2021050083204', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	2021057085725	c0682d64-16d2-4b97-9b02-ba280d2cc0af
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'c078eed8-fab6-490d-b099-47f9b968a5dc', 
		'd1232ab5-4c7d-4570-9d41-2f0bbbed9af7', '7d7ceed0-b1f0-4132-80de-63c26ad657da'::uuid, 
		'CWSP', 'CWCW', 'd39f9fa7-6382-44af-99d7-14709310c8a9', 16, 1, 
		'CIDM-6406-R1', '2021-04-15 08:55:57.568', 'CIDM-6406-R1', '2021-04-15 08:55:57.568', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2021057085725', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	2021060086028	e86cb6c6-7fde-479a-82c1-858c710bb830
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '8b83e1bf-f8d9-4430-92d5-ce6278bee1f0', 
		'db7f58f3-671b-40d4-a6a2-baf9f164204e', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', '976af6e1-3372-42e4-9123-ebcdf73f26de', 16, 1, 
		'CIDM-6406-R1', '2021-03-29 10:48:41.129', 'CIDM-6406-R1', '2021-03-29 10:48:41.129', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2021060086028', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	2021081093764	04fa1c6f-1d23-4b7a-8ce8-d6f4aebf9ce3
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '8b83e1bf-f8d9-4430-92d5-ce6278bee1f0', 
		'b8599e98-dfc8-44bd-b7f5-d668d21b5f10', '31669792-e3c1-40f8-be61-27b2e0c0aa5c'::uuid, 
		'CWSP', 'CWCW', 'e9ba3315-fa01-4cbb-bd1e-e6a4ea669404', 16, 1, 
		'CIDM-6406-R1', '2021-04-12 20:50:08.270', 'CIDM-6406-R1', '2021-04-12 20:50:08.270', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2021081093764', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	2021082094578	2e3bcd53-6769-4163-9d37-f3fa65804181
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '8b83e1bf-f8d9-4430-92d5-ce6278bee1f0', 
		'b8599e98-dfc8-44bd-b7f5-d668d21b5f10', '31669792-e3c1-40f8-be61-27b2e0c0aa5c'::uuid, 
		'CWSP', 'CWCW', '5c199fdc-5453-41a6-bb95-f6dd0ee57bb3', 16, 1, 
		'CIDM-6406-R1', '2021-04-12 20:45:14.185', 'CIDM-6406-R1', '2021-04-12 20:45:14.185', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2021082094578', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	2021084095551	6acfd6c6-398e-42ac-bcb9-a18e6f1c978d
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '77c1d20d-c76d-4106-ab99-e751bafff384', 
		'033171f2-5551-4aa8-bf3a-111108d0514d', '98419d15-06db-4703-95ec-137eb38f7fa0'::uuid, 
		'CWSP', 'CWCW', '37a2dab8-4aa5-4301-bc0e-ca4a0fae08f5', 16, 1, 
		'CIDM-6406-R1', '2021-04-21 16:01:50.169', 'CIDM-6406-R1', '2021-04-21 16:01:50.169', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2021084095551', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	2021085095931	4831acd2-d2b3-4e04-b1a8-7461784eb443
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '8b83e1bf-f8d9-4430-92d5-ce6278bee1f0', 
		'b8599e98-dfc8-44bd-b7f5-d668d21b5f10', '31669792-e3c1-40f8-be61-27b2e0c0aa5c'::uuid, 
		'CWSP', 'CWCW', '6995f640-9b56-4f25-9a02-76b8f76543b6', 16, 1, 
		'CIDM-6406-R1', '2021-04-12 20:47:31.862', 'CIDM-6406-R1', '2021-04-12 20:47:31.862', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2021085095931', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- AR	2021090097316	70dbbf66-1a50-4086-87d5-4428f3f5d36b
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'b212e3d2-4ffa-44e3-9038-91648f194bb2', 
		'd9da02c5-d25d-4e31-b758-bfa7effbf525', 'b8d4d6d4-bd06-4087-b38a-b085abb266db'::uuid, 
		'CWSP', 'CWCW', '579a9922-0ee3-4b99-95ff-5cc3e8b652a5', 16, 1, 
		'CIDM-6406-R1', '2021-04-20 12:29:56.267', 'CIDM-6406-R1', '2021-04-20 12:29:56.267', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2021090097316', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	20210990100298	2174070e-ff16-4bd2-8635-5d5e3588b1ad
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '30af9b82-e4d5-441f-8ede-a19af5447151', 
		'123c6461-d61c-4920-bd7f-7b2ad84a0252', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', 'a70be249-e8af-46be-a546-e3af3d8e2f26', 16, 1, 
		'CIDM-6406-R1', '2021-08-13 18:13:55.060', 'CIDM-6406-R1', '2021-08-13 18:13:55.060', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '20210990100298', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	211020117707	670a970a-f02b-4ceb-af5e-50e8c2d08b84
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '30af9b82-e4d5-441f-8ede-a19af5447151', 
		'123c6461-d61c-4920-bd7f-7b2ad84a0252', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', '2c6d7e34-3faa-4ee7-9129-cd23c81281d9', 16, 1, 
		'CIDM-6406-R1', '2021-08-13 18:11:54.701', 'CIDM-6406-R1', '2021-08-13 18:11:54.701', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '211020117707', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	211020117884	752988e3-6918-4778-ab7b-67f0ad871827
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '30af9b82-e4d5-441f-8ede-a19af5447151', 
		'123c6461-d61c-4920-bd7f-7b2ad84a0252', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', 'b91f1800-836d-4310-8db9-86d239a6f9c3', 16, 1, 
		'CIDM-6406-R1', '2021-08-13 18:02:38.213', 'CIDM-6406-R1', '2021-08-13 18:02:38.213', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '211020117884', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	211020118328	9abdddf0-3e28-4581-8cb8-734bcb9edb89
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '30af9b82-e4d5-441f-8ede-a19af5447151', 
		'123c6461-d61c-4920-bd7f-7b2ad84a0252', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', '847ada65-aa5e-4d62-a94e-ab0efa0945a4', 16, 1, 
		'CIDM-6406-R1', '2021-08-12 17:56:29.165', 'CIDM-6406-R1', '2021-08-12 17:56:29.165', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '211020118328', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	211020120733	a8de64f0-5821-4a30-84cc-0e7b5fa50c31
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '30af9b82-e4d5-441f-8ede-a19af5447151', 
		'123c6461-d61c-4920-bd7f-7b2ad84a0252', '2857b901-5406-443f-9feb-93027a8c1fd4'::uuid, 
		'CWSP', 'CWCW', 'ba9794dd-b65f-40ae-b9a6-dcddeef427a5', 16, 1, 
		'CIDM-6406-R1', '2021-08-13 18:06:23.565', 'CIDM-6406-R1', '2021-08-13 18:06:23.565', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '211020120733', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	211020153156	cfb13857-a03d-40aa-89f5-3be5ecf87bb3
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '7f6bd981-7fba-430a-a290-c4fabe0c1f93', 
		'2a53ac95-5fda-424b-b454-31188408e3f3', '7ad14ba0-5ceb-42b6-8a96-5d2553d5d13f'::uuid, 
		'CWSP', 'CWCW', '2ab695d8-28c9-4ccc-8524-dd2c366df5d5', 16, 1, 
		'CIDM-6406-R1', '2021-12-21 14:36:06.103', 'CIDM-6406-R1', '2021-12-21 14:36:06.103', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '211020153156', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	211020155880	9024d000-31c4-4204-9f8a-11303f5d1552
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'c078eed8-fab6-490d-b099-47f9b968a5dc', 
		'2ac40b14-461e-4301-9ce7-eff5b6608e50', '7d7ceed0-b1f0-4132-80de-63c26ad657da'::uuid, 
		'CWSP', 'CWCW', '08976a9c-ee19-4f49-9c54-f933a136fa8f', 16, 1, 
		'CIDM-6406-R1', '2021-12-23 09:19:44.220', 'CIDM-6406-R1', '2021-12-23 09:19:44.220', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '211020155880', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- AR	221020179575	07e1fde4-dc3e-4610-93cf-50b0117849f7
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'b212e3d2-4ffa-44e3-9038-91648f194bb2', 
		'ef587980-3885-41c0-b612-9a6891c41224', 'b8d4d6d4-bd06-4087-b38a-b085abb266db'::uuid, 
		'CWSP', 'CWCW', '66789512-6f10-47dd-a718-6f891d5ca074', 16, 1, 
		'CIDM-6406-R1', '2022-03-14 11:56:53.391', 'CIDM-6406-R1', '2022-03-14 11:56:53.391', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '221020179575', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- AR	221020181792	c12b1bd4-fe14-4c7b-9917-3cce12a35fa1
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'b212e3d2-4ffa-44e3-9038-91648f194bb2', 
		'ef587980-3885-41c0-b612-9a6891c41224', 'b8d4d6d4-bd06-4087-b38a-b085abb266db'::uuid, 
		'CWSP', 'CWCW', '09f17000-22cd-4d30-91ec-2d9b68b98373', 16, 1, 
		'CIDM-6406-R1', '2022-03-14 12:03:28.069', 'CIDM-6406-R1', '2022-03-14 12:03:28.069', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '221020181792', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	221020184705	15015784-89ab-46a6-a9fd-b7f556a4a7aa
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'b212e3d2-4ffa-44e3-9038-91648f194bb2', 
		'ef587980-3885-41c0-b612-9a6891c41224', 'b8d4d6d4-bd06-4087-b38a-b085abb266db'::uuid, 
		'CWSP', 'CWCW', 'beab8f07-0391-4029-8c2b-0deecb54119e', 16, 1, 
		'CIDM-6406-R1', '2022-03-21 15:56:52.401', 'CIDM-6406-R1', '2022-03-21 15:56:52.401', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '221020184705', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	221020190307	c8b1a635-c5d0-47e1-8373-10afcf72ccb7
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'b212e3d2-4ffa-44e3-9038-91648f194bb2', 
		'ef587980-3885-41c0-b612-9a6891c41224', 'b8d4d6d4-bd06-4087-b38a-b085abb266db'::uuid, 
		'CWSP', 'CWCW', 'f2fa7b9d-e4d2-4969-8185-6821197b8438', 16, 1, 
		'CIDM-6406-R1', '2022-03-14 13:02:49.968', 'CIDM-6406-R1', '2022-03-14 13:02:49.968', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '221020190307', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- IR	221020208070	34630a33-1493-485c-9880-10fc5ef9541d
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '7bdb0176-c528-4519-a8b5-69817dae7eb8', 
		'f33a0600-e70b-42b5-bcc6-09840a9f4e07', '169338e8-ab3c-401c-b52d-9e1ace79a8c1'::uuid, 
		'CWSP', 'CWCW', 'f3a04bb1-e0fe-4b74-8574-a7f6bbb23e6c', 16, 1, 
		'CIDM-6406-R1', '2022-06-23 15:57:57.898', 'CIDM-6406-R1', '2022-06-23 15:57:57.898', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '221020208070', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- AR	221020254022	c0fbdec6-324b-4cb3-bbbb-3686093010a4
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '40d63914-2a9e-4abe-9616-c49bf0c269d3', 
		'97c3dd11-db4f-42c9-bf36-02180bf2de1e', 'ee40a757-5378-409f-a7c6-118368415a99'::uuid, 
		'CWSP', 'CWCW', '30d1d1b5-caba-44ee-b50e-3c84fa2f2a00', 16, 1, 
		'CIDM-6406-R1', '2022-12-21 13:42:14.506', 'CIDM-6406-R1', '2022-12-21 13:42:14.506', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '221020254022', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);


-- End date open CPS program assignmnets 
select personprogramid, entityid, programkey, subprogramkey, startdate, enddate, updatedon, updatedby,
	(select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ) as new_end_date
from personprogramarea  
where programkey = 'CPS'
	and activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid::character varying
				from intakeservicerequest 
			where servicerequestnumber  
				in ( '20200216027140', '2020034015187', '221020208070', '221020254022', '211020155880',
					'2021084095551', '2021057085725', '221020179575', '221020184705', '2021090097316',
					'221020181792', '221020190307', '20210990100298', '2021060086028', '202101030100955',
					'211020117707', '2021050083204', '211020118328', '2021081093764', '202101110103242',
					'202101100102660', '211020117884', '2021082094578', '211020120733', '2021085095931',
					'211020153156', '202101170104864', '202101230106109'
					)
				and activeflag  = 1
			) ;

update personprogramarea
set enddate = (select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ),
	updatedon = now(),
	updatedby = 'CIDM-6406-R1'
where programkey = 'CPS'
	and activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid::character varying
				from intakeservicerequest 
			where servicerequestnumber  
				in ( '20200216027140', '2020034015187', '221020208070', '221020254022', '211020155880',
					'2021084095551', '2021057085725', '221020179575', '221020184705', '2021090097316',
					'221020181792', '221020190307', '20210990100298', '2021060086028', '202101030100955',
					'211020117707', '2021050083204', '211020118328', '2021081093764', '202101110103242',
					'202101100102660', '211020117884', '2021082094578', '211020120733', '2021085095931',
					'211020153156', '202101170104864', '202101230106109'
					)
				and activeflag  = 1
			) ;


-- AR	2020034015187	7d486e5b-5ec9-44e2-8827-3bd9980402cc
select personprogramid, entityid, programkey, subprogramkey, startdate, enddate, updatedon, updatedby,
	(select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ) as new_end_date  
from personprogramarea
where programkey = 'CPS'
	and activeflag = 1
	and enddate  is null
	and objectid = '7d486e5b-5ec9-44e2-8827-3bd9980402cc' ;

update personprogramarea
set enddate = '2020-02-20 07:58:20.586',
	updatedon = now(),
	updatedby = 'CIDM-6406-R1'
where programkey = 'CPS'
	and activeflag = 1
	and enddate  is null
	and objectid = '7d486e5b-5ec9-44e2-8827-3bd9980402cc' ;
	