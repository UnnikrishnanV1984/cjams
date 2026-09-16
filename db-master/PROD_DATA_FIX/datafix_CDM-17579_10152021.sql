-- CDM-17579 - Bill keeps coming back after approval
/*
-- Issue Description: 
   This purchase authorization continues to come back despite approving it multiple times.
   Purchase Authorization with duplicate Pending routing record 

-- Case ID: 2020015001331
-- Client ID: 3274953 (CHANDLER	DAVID MELTON) - d6825d85-1d16-4d4e-acd6-32cac2345efa
-- Service Log ID: 2016617 - Other (Paid) 
-- Provider ID: 5034713 (Comptroller Of The Treasury - Md) 
-- Auth ID: 1799103 - 2021-10-08 To 2021-10-11 - $506.68
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
/*
1	40	Forwarded to Funding Approval	31c7f13a-bc89-4b2a-8c87-228b071ce0eb
1	40	Forwarded to Funding Approval	ad80cbae-09bc-4a3a-b85a-ed920348d5a5
1	40	Forwarded to Funding Approval	7980e9fa-7065-468f-8f34-cc419c9c7da5
1	39	Forwarded to Case Supervisor	212a46d1-1a4d-42c3-8e15-c78445c2ffb9
*/

select *
	from routing 
where routingid  in
	(	'31c7f13a-bc89-4b2a-8c87-228b071ce0eb',
		'ad80cbae-09bc-4a3a-b85a-ed920348d5a5',
		'7980e9fa-7065-468f-8f34-cc419c9c7da5',
		'212a46d1-1a4d-42c3-8e15-c78445c2ffb9'
	)
	and objectid = '1799103'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid  in
	(	'31c7f13a-bc89-4b2a-8c87-228b071ce0eb',
		'ad80cbae-09bc-4a3a-b85a-ed920348d5a5',
		'7980e9fa-7065-468f-8f34-cc419c9c7da5',
		'212a46d1-1a4d-42c3-8e15-c78445c2ffb9'
	)
	and objectid = '1799103'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('212a46d1-1a4d-42c3-8e15-c78445c2ffb9', 'PCAUTH', '750e968a-30e5-4c24-b354-c653d682be59', '5584f32e-f6d8-4960-8e66-081aac2d35c8', 'f8c0dec9-4809-475b-a576-c2803d4b7598', 'CWCW', 'CWSP', '1799103', 39, 1, '750e968a-30e5-4c24-b354-c653d682be59', '2021-10-12 10:35:18.892', '750e968a-30e5-4c24-b354-c653d682be59', '2021-10-12 10:35:18.892', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '2020015001331', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('31c7f13a-bc89-4b2a-8c87-228b071ce0eb', 'PCAUTHR', '5584f32e-f6d8-4960-8e66-081aac2d35c8', NULL, '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'CWSP', 'FNSFS', '1799103', 40, 1, '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-10-13 08:12:50.759', '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-10-13 08:12:50.759', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020015001331', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ad80cbae-09bc-4a3a-b85a-ed920348d5a5', 'PCAUTHR', '5584f32e-f6d8-4960-8e66-081aac2d35c8', NULL, '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'CWSP', 'FNSFS', '1799103', 40, 1, '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-10-13 08:10:09.199', '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-10-13 08:10:09.199', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020015001331', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7980e9fa-7065-468f-8f34-cc419c9c7da5', 'PCAUTHR', '5584f32e-f6d8-4960-8e66-081aac2d35c8', '753c40c4-34fd-4e88-9e2a-f974a416d51a', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'CWSP', 'FNSFS', '1799103', 40, 1, '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-10-12 13:24:04.582', '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-10-12 13:24:04.582', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020015001331', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	