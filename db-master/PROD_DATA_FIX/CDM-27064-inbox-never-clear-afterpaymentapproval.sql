/*
   Issue Description: CDM-27064
   Category/ Module  :  Inbox never clears after pymt approved
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

Case Number :3170619
case Number : 2020024802862

*/

-- Authorization ID: 1844450 


-- -- Delete
-- 1 39 Forwarded to Case Supervisor 152adfdd-897b-4721-b343-5d7380d90532
-- 1 40 Forwarded to Funding Approval a78bd0ee-1ddf-4295-afd4-f225b8420652
-- 1 43 Approved 60b7b6ed-d2c6-485f-ab4e-5c4a8eef2a87
-- 1 43 Approved 99c49f27-f939-43e9-b745-68a7fe689fb6


select *
	from routing 
where routingid
	in ( 
			'152adfdd-897b-4721-b343-5d7380d90532',
			'a78bd0ee-1ddf-4295-afd4-f225b8420652',
			'99c49f27-f939-43e9-b745-68a7fe689fb6',
			'60b7b6ed-d2c6-485f-ab4e-5c4a8eef2a87'
		)
	and objectid = '1844450'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;


delete from routing   
where routingid 
	in ( 
			'152adfdd-897b-4721-b343-5d7380d90532',
			'a78bd0ee-1ddf-4295-afd4-f225b8420652',
			'99c49f27-f939-43e9-b745-68a7fe689fb6',
			'60b7b6ed-d2c6-485f-ab4e-5c4a8eef2a87'
		)
	and objectid = '1844450'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;

-------------------------------------

-- 1844430
-- Delete
-- 40 Forwarded to Funding Approval 1 4c7c31f0-0ea9-4696-bc9d-258e3a0dc98e
-- 43 Approved 1 99c8270d-e8e2-4744-bc4a-4733b8951aec
-- 40 Forwarded to Funding Approval 1 1a52fca2-d1b5-46ba-a47a-26ad990f3fba
-- 40 Forwarded to Funding Approval 1 0d8eea35-d6ac-4ad8-99c3-3eaf507aa257
-- 39 Forwarded to Case Supervisor 1 8981f0f9-e426-4388-8d8a-831057dd29c8


select *
	from routing 
where routingid
	in ( 
			'8981f0f9-e426-4388-8d8a-831057dd29c8',
			'0d8eea35-d6ac-4ad8-99c3-3eaf507aa257',
			'1a52fca2-d1b5-46ba-a47a-26ad990f3fba',
			'4c7c31f0-0ea9-4696-bc9d-258e3a0dc98e',
			'99c8270d-e8e2-4744-bc4a-4733b8951aec'
		)
	and objectid = '1844430'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;


    delete from routing   
where routingid 
	in ( 
			'8981f0f9-e426-4388-8d8a-831057dd29c8',
			'0d8eea35-d6ac-4ad8-99c3-3eaf507aa257',
			'1a52fca2-d1b5-46ba-a47a-26ad990f3fba',
			'4c7c31f0-0ea9-4696-bc9d-258e3a0dc98e',
			'99c8270d-e8e2-4744-bc4a-4733b8951aec'
			
		)
	and objectid = '1844430'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
    ;


-------------------------------------

-- 1843441
-- Delete
-- 1 39 Forwarded to Case Supervisor 7c4c4418-b30d-424f-84fc-dbe7c8c93b6d
-- 1 40 Forwarded to Funding Approval 91ccc9cf-e0d0-446e-bcee-4486b91df8cd
-- 1 40 Forwarded to Funding Approval 2cee433e-cb30-4130-b973-eba7fcbd297f


select *
	from routing 
where routingid
	in ( 
			'7c4c4418-b30d-424f-84fc-dbe7c8c93b6d',
			'2cee433e-cb30-4130-b973-eba7fcbd297f',
			'91ccc9cf-e0d0-446e-bcee-4486b91df8cd'
		)
	and objectid = '1843441'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;


delete from routing   
where routingid 
	in ( 
			'7c4c4418-b30d-424f-84fc-dbe7c8c93b6d',
			'2cee433e-cb30-4130-b973-eba7fcbd297f',
			'91ccc9cf-e0d0-446e-bcee-4486b91df8cd'
			
		)
	and objectid = '1843441'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;

------------------------------------------------

-- 1833148
-- Delete
-- 1 39 Forwarded to Case Supervisor 3f963e8d-c033-4f6c-a87f-39a77078446f
-- 1 40 Forwarded to Funding Approval ef68c500-ea66-4088-9538-15fdc5b24bcf
-- 1 40 Forwarded to Funding Approval 9c35c00e-d34a-4ecc-8e90-ad98f491f0c3
-- 1 40 Forwarded to Funding Approval bcce75f3-16e3-4d7c-a063-19640b2fad3b
-- 1 40 Forwarded to Funding Approval b1a28511-8869-48b5-9df5-604a1cbac63e



select *
	from routing 
where routingid
	in ( 
			'3f963e8d-c033-4f6c-a87f-39a77078446f',
			'b1a28511-8869-48b5-9df5-604a1cbac63e',
			'bcce75f3-16e3-4d7c-a063-19640b2fad3b',
			'9c35c00e-d34a-4ecc-8e90-ad98f491f0c3',
			'ef68c500-ea66-4088-9538-15fdc5b24bcf'
		)
	and objectid = '1833148'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;



    delete from routing   
where routingid 
	in ( 
			'3f963e8d-c033-4f6c-a87f-39a77078446f',
			'b1a28511-8869-48b5-9df5-604a1cbac63e',
			'bcce75f3-16e3-4d7c-a063-19640b2fad3b',
			'9c35c00e-d34a-4ecc-8e90-ad98f491f0c3',
			'ef68c500-ea66-4088-9538-15fdc5b24bcf'
			
		)
	and objectid = '1833148'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;



-- To Revert the data if needed
/*

-- Authorization ID: 1844450 

    INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', 'a78bd0ee-1ddf-4295-afd4-f225b8420652'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '5816a125-382b-4d18-8a95-b59cf54a9e7d', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1844450', 40, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 15:06:10.193', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 15:06:10.193', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3170619', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 43, 'Approved', '60b7b6ed-d2c6-485f-ab4e-5c4a8eef2a87'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '89f8a00c-e1dc-4fe3-9d54-c394e0daab7b', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFS', '1844450', 43, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 14:55:55.859', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 14:55:55.859', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3170619', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 43, 'Approved', '99c49f27-f939-43e9-b745-68a7fe689fb6'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '89f8a00c-e1dc-4fe3-9d54-c394e0daab7b', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFS', '1844450', 43, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 14:55:53.996', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 14:55:53.996', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3170619', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 39, 'Forwarded to Case Supervisor', '152adfdd-897b-4721-b343-5d7380d90532'::uuid, 'PCAUTH', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '44ae52aa-6389-425a-a422-2a8bf24c3aae', 'dbbc2a6e-0368-47ee-83bb-455d1f331129'::uuid, 'CWCW', 'CWSP', '1844450', 39, 1, '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-07-26 14:26:29.904', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-07-26 14:26:29.904', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3170619', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


-- Authorization ID: 1844430

INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', '4c7c31f0-0ea9-4696-bc9d-258e3a0dc98e'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '5816a125-382b-4d18-8a95-b59cf54a9e7d', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1844430', 40, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 15:08:03.098', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 15:08:03.098', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3170619', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 43, 'Approved', '99c8270d-e8e2-4744-bc4a-4733b8951aec'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '7e3ba3db-6d76-4800-9623-46f80762a619', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFS', '1844430', 43, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 15:07:47.164', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 15:07:47.164', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3170619', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', '1a52fca2-d1b5-46ba-a47a-26ad990f3fba'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '5816a125-382b-4d18-8a95-b59cf54a9e7d', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1844430', 40, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 15:07:07.171', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 15:07:07.171', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3170619', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', '0d8eea35-d6ac-4ad8-99c3-3eaf507aa257'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '5816a125-382b-4d18-8a95-b59cf54a9e7d', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1844430', 40, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 14:48:40.507', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-26 14:48:40.507', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3170619', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 39, 'Forwarded to Case Supervisor', '8981f0f9-e426-4388-8d8a-831057dd29c8'::uuid, 'PCAUTH', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '44ae52aa-6389-425a-a422-2a8bf24c3aae', 'dbbc2a6e-0368-47ee-83bb-455d1f331129'::uuid, 'CWCW', 'CWSP', '1844430', 39, 1, '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-07-26 14:04:53.860', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-07-26 14:04:53.860', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3170619', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


-- Authorization ID: 1843441 

INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', '91ccc9cf-e0d0-446e-bcee-4486b91df8cd'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '5816a125-382b-4d18-8a95-b59cf54a9e7d', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1843441', 40, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-21 07:43:56.549', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-21 07:43:56.549', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020024802862', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', '2cee433e-cb30-4130-b973-eba7fcbd297f'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '5816a125-382b-4d18-8a95-b59cf54a9e7d', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1843441', 40, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-20 17:22:18.944', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-07-20 17:22:18.944', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020024802862', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 39, 'Forwarded to Case Supervisor', '7c4c4418-b30d-424f-84fc-dbe7c8c93b6d'::uuid, 'PCAUTH', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '44ae52aa-6389-425a-a422-2a8bf24c3aae', 'dbbc2a6e-0368-47ee-83bb-455d1f331129'::uuid, 'CWCW', 'CWSP', '1843441', 39, 1, '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-07-19 16:00:45.600', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-07-19 16:00:45.600', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '2020024802862', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


-- Authorization ID: 1833148

INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', 'ef68c500-ea66-4088-9538-15fdc5b24bcf'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1833148', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-10-20 13:38:12.679', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-10-20 13:38:12.679', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020024802862', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', '9c35c00e-d34a-4ecc-8e90-ad98f491f0c3'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1833148', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-10-20 13:37:14.240', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-10-20 13:37:14.240', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020024802862', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', 'bcce75f3-16e3-4d7c-a063-19640b2fad3b'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1833148', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-10-20 13:33:24.982', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-10-20 13:33:24.982', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020024802862', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 40, 'Forwarded to Funding Approval', 'b1a28511-8869-48b5-9df5-604a1cbac63e'::uuid, 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '5816a125-382b-4d18-8a95-b59cf54a9e7d', 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1833148', 40, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-05-17 17:19:59.744', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-05-17 17:19:59.744', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020024802862', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(1, 39, 'Forwarded to Case Supervisor', '3f963e8d-c033-4f6c-a87f-39a77078446f'::uuid, 'PCAUTH', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '44ae52aa-6389-425a-a422-2a8bf24c3aae', 'dbbc2a6e-0368-47ee-83bb-455d1f331129'::uuid, 'CWCW', 'CWSP', '1833148', 39, 1, '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-05-17 16:07:27.989', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-05-17 16:07:27.989', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '2020024802862', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);



*/