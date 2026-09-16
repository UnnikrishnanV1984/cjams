-- CDM-26925 - Purchase Auth
/*
-- Issue Description: 
   Purchase Authorizations with duplicate routing records 

-- Case ID: 3306868
-- Client ID: 1064156 (SINCERE TURNER) - 341a4323-4e2d-4dea-8441-d7e6b81a9e4f
-- Authorization ID: 1865431 - 2022-11-17 To 2022-11-23 - $688.80
-- Provider ID: 5002462	(Wicomico Co Dept Of Social Services)
-- Emergency Shelter (Paid) 

-- Case ID: 202109207020 
-- Client ID: 200141742	(TROY Leon POWELL) - 140d3f8e-6bd0-44cc-9c23-792c6a2d98fc
-- Authorization ID: 1863144 - 2022-11-07 To 2022-11-07 - $107.97
-- Provider ID: 5002462 (Wicomico Co Dept Of Social Services)
-- Clothing Purchase (Paid)  

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (duplicate multiple active records in routing table)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete duplicate active routing records 
-- Authorization ID: 1865431 - 2022-11-17 To 2022-11-23 - $688.80
/*
1	39	Forwarded to Case Supervisor	56c88730-8c64-4fd5-8a37-ff19892c3331
1	40	Forwarded to Funding Approval	401c5b66-9d58-421f-a0e4-fddc98a2cbb1
1	40	Forwarded to Funding Approval	1ec2d653-1abc-4720-a2fa-d0f005446a7f
1	40	Forwarded to Funding Approval	ff79fa06-3be5-4c48-a9f4-b3de8ebe6ced
1	40	Forwarded to Funding Approval	ced21399-9103-4f9e-bcb0-66b847d4b0d5
1	40	Forwarded to Funding Approval	24a5959d-03ec-4d74-b6d0-c983b7d6a04a
1	40	Forwarded to Funding Approval	390a9aac-f7cd-42ed-958a-e0e11d3da345
*/
select *
	from routing 
where routingid
	in ( 
			'56c88730-8c64-4fd5-8a37-ff19892c3331',
			'401c5b66-9d58-421f-a0e4-fddc98a2cbb1',
			'1ec2d653-1abc-4720-a2fa-d0f005446a7f',
			'ff79fa06-3be5-4c48-a9f4-b3de8ebe6ced',
			'ced21399-9103-4f9e-bcb0-66b847d4b0d5',
			'24a5959d-03ec-4d74-b6d0-c983b7d6a04a',
			'390a9aac-f7cd-42ed-958a-e0e11d3da345'
		)
	and objectid = '1865431'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and (select count(*) 
			from tb_payment_header 
	 	 where authorization_id  = 1865431
	 		and delete_sw = 'N'
 		) = 0
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid 
	in ( 
			'56c88730-8c64-4fd5-8a37-ff19892c3331',
			'401c5b66-9d58-421f-a0e4-fddc98a2cbb1',
			'1ec2d653-1abc-4720-a2fa-d0f005446a7f',
			'ff79fa06-3be5-4c48-a9f4-b3de8ebe6ced',
			'ced21399-9103-4f9e-bcb0-66b847d4b0d5',
			'24a5959d-03ec-4d74-b6d0-c983b7d6a04a',
			'390a9aac-f7cd-42ed-958a-e0e11d3da345'
		)
	and objectid = '1865431'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and (select count(*) 
			from tb_payment_header 
	 	 where authorization_id  = 1865431
	 		and delete_sw = 'N'
 		) = 0
	-- and activeflag = 1 
	;

-- Authorization ID: 1863144 - 2022-11-07 To 2022-11-07 - $107.97
/*
1	40	Forwarded to Funding Approval	2e095f26-f29e-4333-9bdb-417e494bbac0
1	40	Forwarded to Funding Approval	d56fa091-efed-46c1-889e-5b3c11ad16fb
1	40	Forwarded to Funding Approval	91966176-0f9b-4ad5-b3b6-55f86b929223
1	40	Forwarded to Funding Approval	7faeea06-d701-4e9d-bedb-8383b3507052
1	40	Forwarded to Funding Approval	a743e7ce-d106-49fa-b3eb-624d73741769
1	39	Forwarded to Case Supervisor	2e10426a-db7e-49fd-b10c-1becd8338793
*/

select *
	from routing 
where routingid
	in ( 
			'2e095f26-f29e-4333-9bdb-417e494bbac0',
			'd56fa091-efed-46c1-889e-5b3c11ad16fb',
			'91966176-0f9b-4ad5-b3b6-55f86b929223',
			'7faeea06-d701-4e9d-bedb-8383b3507052',
			'a743e7ce-d106-49fa-b3eb-624d73741769',
			'2e10426a-db7e-49fd-b10c-1becd8338793'
		)
	and objectid = '1863144'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and (select count(*) 
			from tb_payment_header 
	 	 where authorization_id  = 1863144
	 		and delete_sw = 'N'
 		) = 0
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid
	in ( 
			'2e095f26-f29e-4333-9bdb-417e494bbac0',
			'd56fa091-efed-46c1-889e-5b3c11ad16fb',
			'91966176-0f9b-4ad5-b3b6-55f86b929223',
			'7faeea06-d701-4e9d-bedb-8383b3507052',
			'a743e7ce-d106-49fa-b3eb-624d73741769',
			'2e10426a-db7e-49fd-b10c-1becd8338793'
		)
	and objectid = '1863144'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and (select count(*) 
			from tb_payment_header 
	 	 where authorization_id  = 1863144
	 		and delete_sw = 'N'
 		) = 0
	-- and activeflag = 1 
	;

/*
-- To Revert the data if needed

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('56c88730-8c64-4fd5-8a37-ff19892c3331'::uuid, 'PCAUTH', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', 'cf1efb9e-4629-4858-b57d-282bca838560', 'dbbc2a6e-0368-47ee-83bb-455d1f331129'::uuid, 'CWCW', 'CWSP', '1865431', 39, 1, '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-11-28 09:15:28.184', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-11-28 09:15:28.184', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3306868', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('390a9aac-f7cd-42ed-958a-e0e11d3da345'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1865431', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 09:48:12.480', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 09:48:12.480', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3306868', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('24a5959d-03ec-4d74-b6d0-c983b7d6a04a'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1865431', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 09:49:47.459', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 09:49:47.459', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3306868', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ced21399-9103-4f9e-bcb0-66b847d4b0d5'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1865431', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 09:51:02.751', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 09:51:02.751', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3306868', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ff79fa06-3be5-4c48-a9f4-b3de8ebe6ced'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1865431', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 09:59:30.343', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 09:59:30.343', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3306868', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('1ec2d653-1abc-4720-a2fa-d0f005446a7f'::uuid, 'PCAUTHR', 'fc4bbb12-0172-445a-b017-2156c261d052', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1865431', 40, 1, 'fc4bbb12-0172-445a-b017-2156c261d052', '2022-11-28 10:03:29.533', 'fc4bbb12-0172-445a-b017-2156c261d052', '2022-11-28 10:03:29.533', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3306868', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('401c5b66-9d58-421f-a0e4-fddc98a2cbb1'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1865431', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 14:59:01.620', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-28 14:59:01.620', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3306868', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2e10426a-db7e-49fd-b10c-1becd8338793'::uuid, 'PCAUTH', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', 'cf1efb9e-4629-4858-b57d-282bca838560', 'dbbc2a6e-0368-47ee-83bb-455d1f331129'::uuid, 'CWCW', 'CWSP', '1863144', 39, 1, '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-11-18 08:50:00.199', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-11-18 08:50:00.199', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '202109207020', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('a743e7ce-d106-49fa-b3eb-624d73741769'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1863144', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-18 10:48:45.111', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-18 10:48:45.111', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '202109207020', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7faeea06-d701-4e9d-bedb-8383b3507052'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1863144', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-18 10:53:00.188', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-18 10:53:00.188', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '202109207020', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('91966176-0f9b-4ad5-b3b6-55f86b929223'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1863144', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-18 10:53:37.685', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-18 10:53:37.685', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '202109207020', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('d56fa091-efed-46c1-889e-5b3c11ad16fb'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1863144', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-18 10:54:24.347', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-18 10:54:24.347', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '202109207020', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2e095f26-f29e-4333-9bdb-417e494bbac0'::uuid, 'PCAUTHR', 'cf1efb9e-4629-4858-b57d-282bca838560', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089'::uuid, 'CWSP', 'FNSFW', '1863144', 40, 1, 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-21 08:16:11.298', 'cf1efb9e-4629-4858-b57d-282bca838560', '2022-11-21 08:16:11.298', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '202109207020', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


*/	
