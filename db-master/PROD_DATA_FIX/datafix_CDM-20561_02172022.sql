-- CDM-20561 - Payment Can Not be Processed
/*
-- Issue Description: 
   Purchase Authorization with duplicate routing records 

-- Service case - 3307054
-- Authorization ID: 1810074
-- Paid: Paymment ID: 3124180- Date: 2021-12-29 - $478.80
   
-- Service case - 3296624   
-- Authorization ID: 1818223
-- Purchase Authorization Forwarded to Funding Approval
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Authorization ID: 1810074
-- Paid: Paymment ID: 3124180- Date: 2021-12-29 - $478.80
/*
-- Delete 
1	40	Forwarded to Funding Approval	e3d8b5f1-2c65-4263-b889-815f7b5638e5
1	40	Forwarded to Funding Approval	c8ae43d5-ecb5-425c-9e66-0e5a0152ee9d
1	40	Forwarded to Funding Approval	afdd07e9-310d-4769-9877-039f131984e8
1	40	Forwarded to Funding Approval	40303651-1b18-439f-a083-afed7093d3a2
1	40	Forwarded to Funding Approval	339657cd-a263-45e4-b1ff-62ef0e3f105b
1	40	Forwarded to Funding Approval	4097f005-2786-4477-9729-5221cbd31b2f
1	39	Forwarded to Case Supervisor	892880eb-943a-4a9a-b088-1e92210b27e0

-- Okay
1	43	Approved						c51f0c17-59d2-4e2d-be80-94eb1946891c
0	40	Forwarded to Funding Approval	c9871a4c-eca1-407f-ab2c-16e64005795e
0	39	Forwarded to Case Supervisor	9ba6ad27-6f46-4d84-bab8-3c5e825fa07e
*/
			
select activeflag, routingstatustypeid, remarks,  *
	from routing 
where routingid
		in (	'e3d8b5f1-2c65-4263-b889-815f7b5638e5',
				'c8ae43d5-ecb5-425c-9e66-0e5a0152ee9d',
				'afdd07e9-310d-4769-9877-039f131984e8',
				'40303651-1b18-439f-a083-afed7093d3a2',
				'339657cd-a263-45e4-b1ff-62ef0e3f105b',
				'4097f005-2786-4477-9729-5221cbd31b2f',
				'892880eb-943a-4a9a-b088-1e92210b27e0'				
		   )
	and objectid = '1810074'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid
		in (	'e3d8b5f1-2c65-4263-b889-815f7b5638e5',
				'c8ae43d5-ecb5-425c-9e66-0e5a0152ee9d',
				'afdd07e9-310d-4769-9877-039f131984e8',
				'40303651-1b18-439f-a083-afed7093d3a2',
				'339657cd-a263-45e4-b1ff-62ef0e3f105b',
				'4097f005-2786-4477-9729-5221cbd31b2f',
				'892880eb-943a-4a9a-b088-1e92210b27e0'				
		   )
	and objectid = '1810074'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;


-- Authorization ID: 1818223
-- Purchase Authorization Forwarded to Funding Approval
/*
-- Delete 
1	40	Forwarded to Funding Approval	c22da628-857d-4132-923f-124fd946ac3b
1	40	Forwarded to Funding Approval	2c32c030-2039-4cb7-8220-28ec0d29818c
1	39	Forwarded to Case Supervisor	03979919-6959-4002-a6a9-7708fce30da5

-- okay
1	40	Forwarded to Funding Approval	6e86ca96-217b-475f-819e-5a0ebefb5053
0	39	Forwarded to Case Supervisor	3f8dfe03-461f-4a73-b2c4-8a8eb712c73f
*/

select activeflag, routingstatustypeid, remarks,  *
	from routing 
where routingid
		in (	'c22da628-857d-4132-923f-124fd946ac3b',
				'2c32c030-2039-4cb7-8220-28ec0d29818c',
				'03979919-6959-4002-a6a9-7708fce30da5'
		   )
	and objectid = '1818223'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid
		in (	'c22da628-857d-4132-923f-124fd946ac3b',
				'2c32c030-2039-4cb7-8220-28ec0d29818c',
				'03979919-6959-4002-a6a9-7708fce30da5'
		   )
	and objectid = '1818223'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;


/*
For Back-up & rollback 
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('892880eb-943a-4a9a-b088-1e92210b27e0'::uuid, 'PCAUTH', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'a2311121-a429-497b-91ad-18fdc1574819'::uuid, 'CWCW', 'CWSP', '1810074', 39, 1, '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2021-12-14 09:04:05.699', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2021-12-14 09:04:05.699', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3307054', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('e3d8b5f1-2c65-4263-b889-815f7b5638e5'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1810074', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-01-21 15:23:39.581', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-01-21 15:23:39.581', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3307054', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('c8ae43d5-ecb5-425c-9e66-0e5a0152ee9d'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1810074', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-01-05 17:22:56.736', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-01-05 17:22:56.736', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3307054', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('afdd07e9-310d-4769-9877-039f131984e8'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1810074', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-01-05 17:22:39.466', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-01-05 17:22:39.466', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3307054', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('40303651-1b18-439f-a083-afed7093d3a2'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1810074', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-01-03 07:47:25.041', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-01-03 07:47:25.041', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3307054', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('4097f005-2786-4477-9729-5221cbd31b2f'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '7ce4e320-310f-494b-9f43-82d38571d6c7', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1810074', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2021-12-20 11:49:06.421', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2021-12-20 11:49:06.421', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3307054', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('339657cd-a263-45e4-b1ff-62ef0e3f105b'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '7ce4e320-310f-494b-9f43-82d38571d6c7', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1810074', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2021-12-20 11:53:15.685', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2021-12-20 11:53:15.685', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3307054', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('03979919-6959-4002-a6a9-7708fce30da5'::uuid, 'PCAUTH', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'a2311121-a429-497b-91ad-18fdc1574819'::uuid, 'CWCW', 'CWSP', '1818223', 39, 1, '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-02-09 13:27:19.180', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-02-09 13:27:19.180', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('c22da628-857d-4132-923f-124fd946ac3b'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1818223', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-11 11:08:59.583', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-11 11:08:59.583', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2c32c030-2039-4cb7-8220-28ec0d29818c'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1818223', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-09 16:54:01.646', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-09 16:54:01.646', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

