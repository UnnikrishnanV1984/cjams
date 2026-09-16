-- CDM-26920 - Stuck approval
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Case ID: 3246801
-- Client ID: 200178673	(Nikolai A Alphioroff) - 9f974d85-21aa-47ea-9ddf-763abb339f14
-- Auth ID: 1864895 - Child Care (Paid) - 11/28/2022 To 12/11/2022 - $380.00
-- Provider ID: 6000337	(Lifehouse Learning Center, LLC)

-- Case ID: 3242900
-- Client ID: 2929175 (JOSIAH SENCERE SWEENEY) - 1bfe0c8a-dee1-4eaf-b69d-6a925ae84a00
-- Auth ID: 1838978 - Other (Paid) - 06/13/2022 To 06/13/2022 - $306.09
-- Provider ID: 6006360	(Lisa Doyle)

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1864895 - Delete duplicate Pending routing records 
/*
1	39	Forwarded to Case Supervisor	cb0ccaec-b028-4793-9dfc-b4086b07e8a1
1	40	Forwarded to Funding Approval	db5d646b-944a-457b-912a-f01a02aba6fe
1	40	Forwarded to Funding Approval	6a8360bd-2206-4bd2-8259-f05ee77d08ad
1	40	Forwarded to Funding Approval	3842334d-17cc-4f37-bcfb-02541ffbf434
1	40	Forwarded to Funding Approval	aebff12f-b951-431b-bb79-ae852e03b498
1	40	Forwarded to Funding Approval	36a9ab46-ef85-4cef-bc2e-2653903e09d0
*/

select *
	from routing 
where routingid 
	in ( 
			'cb0ccaec-b028-4793-9dfc-b4086b07e8a1',
			'db5d646b-944a-457b-912a-f01a02aba6fe',
			'6a8360bd-2206-4bd2-8259-f05ee77d08ad',
			'3842334d-17cc-4f37-bcfb-02541ffbf434',
			'aebff12f-b951-431b-bb79-ae852e03b498',
			'36a9ab46-ef85-4cef-bc2e-2653903e09d0'
		)
	and objectid = '1864895'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid 
	in ( 
			'cb0ccaec-b028-4793-9dfc-b4086b07e8a1',
			'db5d646b-944a-457b-912a-f01a02aba6fe',
			'6a8360bd-2206-4bd2-8259-f05ee77d08ad',
			'3842334d-17cc-4f37-bcfb-02541ffbf434',
			'aebff12f-b951-431b-bb79-ae852e03b498',
			'36a9ab46-ef85-4cef-bc2e-2653903e09d0'
		)
	and objectid = '1864895'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

-- 1838978 Delete 
/*
1	39	Forwarded to Case Supervisor	d0b3fab8-7235-4c55-9676-679278dc76cc
1	43	Approved	74808ff8-65a3-42d3-8943-82c36b09290c
1	43	Approved	353bccfc-331e-4d21-aba8-46636ee275a1
1	43	Approved	8531a2a6-df10-4ca7-ac6e-c15db55dc435
*/

select *
	from routing 
where routingid 
	in ( 
			'd0b3fab8-7235-4c55-9676-679278dc76cc',
			'74808ff8-65a3-42d3-8943-82c36b09290c',
			'353bccfc-331e-4d21-aba8-46636ee275a1',
			'8531a2a6-df10-4ca7-ac6e-c15db55dc435'
		)
	and objectid = '1838978'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid 
	in ( 
			'd0b3fab8-7235-4c55-9676-679278dc76cc',
			'74808ff8-65a3-42d3-8943-82c36b09290c',
			'353bccfc-331e-4d21-aba8-46636ee275a1',
			'8531a2a6-df10-4ca7-ac6e-c15db55dc435'
		)
	and objectid = '1838978'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
	
/*
-- To Revert the data if needed 1864895
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('cb0ccaec-b028-4793-9dfc-b4086b07e8a1'::uuid, 'PCAUTH', '097281cc-d73a-40e7-ae28-85de45adebe1', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', 'f367fc82-9044-4f74-a40e-6d96db9e8625'::uuid, 'CWCW', 'CWSP', '1864895', 39, 1, '097281cc-d73a-40e7-ae28-85de45adebe1', '2022-11-23 13:23:34.902', '097281cc-d73a-40e7-ae28-85de45adebe1', '2022-11-23 13:23:34.902', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3246801', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3842334d-17cc-4f37-bcfb-02541ffbf434'::uuid, 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '753c40c4-34fd-4e88-9e2a-f974a416d51a', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1864895', 40, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-23 14:02:08.607', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-23 14:02:08.607', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3246801', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('6a8360bd-2206-4bd2-8259-f05ee77d08ad'::uuid, 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '753c40c4-34fd-4e88-9e2a-f974a416d51a', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1864895', 40, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-23 14:04:12.610', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-23 14:04:12.610', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3246801', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('db5d646b-944a-457b-912a-f01a02aba6fe'::uuid, 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '753c40c4-34fd-4e88-9e2a-f974a416d51a', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1864895', 40, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-23 14:06:42.459', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-23 14:06:42.459', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3246801', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('36a9ab46-ef85-4cef-bc2e-2653903e09d0'::uuid, 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', NULL, '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1864895', 40, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-30 16:40:06.079', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-30 16:40:06.079', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3246801', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('aebff12f-b951-431b-bb79-ae852e03b498'::uuid, 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', NULL, '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1864895', 40, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-30 16:44:21.729', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-11-30 16:44:21.729', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3246801', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- To Revert the data if needed 1838978
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('d0b3fab8-7235-4c55-9676-679278dc76cc'::uuid, 'PCAUTH', '50714e61-37fc-4274-a3e4-88313c081498', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', 'f367fc82-9044-4f74-a40e-6d96db9e8625'::uuid, 'CWCW', 'CWSP', '1838978', 39, 1, '50714e61-37fc-4274-a3e4-88313c081498', '2022-06-21 10:01:23.316', '50714e61-37fc-4274-a3e4-88313c081498', '2022-06-21 10:01:23.316', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3242900', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('8531a2a6-df10-4ca7-ac6e-c15db55dc435'::uuid, 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '981a9650-770e-46aa-8686-00c8fc2ddbe8', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1838978', 43, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-06-21 10:07:17.324', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-06-21 10:07:17.324', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3242900', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('353bccfc-331e-4d21-aba8-46636ee275a1'::uuid, 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '981a9650-770e-46aa-8686-00c8fc2ddbe8', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1838978', 43, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-06-21 10:07:38.720', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-06-21 10:07:38.720', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3242900', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('74808ff8-65a3-42d3-8943-82c36b09290c'::uuid, 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '981a9650-770e-46aa-8686-00c8fc2ddbe8', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1838978', 43, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-06-22 10:06:59.197', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2022-06-22 10:06:59.197', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3242900', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
