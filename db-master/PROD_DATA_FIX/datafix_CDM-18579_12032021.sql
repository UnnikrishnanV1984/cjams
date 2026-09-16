-- CDM-18579 - Stuck Purchase Authorization
/*
-- Issue Description: 
	This Purchase authorization is stuck. It will not process through different 
	approval levels and therefore it cannot be processed as a complete payment.

    Purchase Authorization with duplicate Pending routing record 

-- Case ID: 3193098
-- Client ID: 4216522 (DANIEL A	ORELLANA HENRIQUEZ) - 3e864cdc-8a12-439c-8128-26a671da7d77
-- Service Log ID: 1968255 - 2020-09-14 To Current - Child Care- Formal (Paid)
-- Provider ID: 5094577	(NIST Child Care Center)
-- Authorization ID: 1803349
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
/*
1	41	Forwarded to Payment Approval	be1741f5-fc76-4b11-b419-33ab33ae2b6a
1	41	Forwarded to Payment Approval	8e0859c7-1564-460c-a3a3-9a49110200b2
1	43	Approved						3847872f-4019-4130-a9f7-beffe6e6e153
1	41	Forwarded to Payment Approval	8ba027a2-8ae6-42c5-8145-115ea5d1b42c
0	41	Forwarded to Payment Approval	c4d0f4c6-dfef-4a16-9b9f-fe780df5142e
0	41	Forwarded to Payment Approval	de269175-272b-434c-89c6-ba975fcad659
0	40	Forwarded to Funding Approval	050a9d15-9bfb-4c2b-9153-a2851314afb1
1	40	Forwarded to Funding Approval	1f1f8c1c-947b-4db0-8b1d-a1c371c4bea5
*/

select *
	from routing 
where routingid  in
	(	'be1741f5-fc76-4b11-b419-33ab33ae2b6a',
		'8e0859c7-1564-460c-a3a3-9a49110200b2',
		'3847872f-4019-4130-a9f7-beffe6e6e153',
		'8ba027a2-8ae6-42c5-8145-115ea5d1b42c',
		'c4d0f4c6-dfef-4a16-9b9f-fe780df5142e',
		'de269175-272b-434c-89c6-ba975fcad659',
		'050a9d15-9bfb-4c2b-9153-a2851314afb1',
		'1f1f8c1c-947b-4db0-8b1d-a1c371c4bea5'	
	)
	and objectid = '1803349'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid  in
	(	'be1741f5-fc76-4b11-b419-33ab33ae2b6a',
		'8e0859c7-1564-460c-a3a3-9a49110200b2',
		'3847872f-4019-4130-a9f7-beffe6e6e153',
		'8ba027a2-8ae6-42c5-8145-115ea5d1b42c',
		'c4d0f4c6-dfef-4a16-9b9f-fe780df5142e',
		'de269175-272b-434c-89c6-ba975fcad659',
		'050a9d15-9bfb-4c2b-9153-a2851314afb1',
		'1f1f8c1c-947b-4db0-8b1d-a1c371c4bea5'	
	)
	and objectid = '1803349'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;

-- Mass update for "Purchase Authorization Forwarded to Payment Approval"
-- all are forwared to crystal.stewart@montgomerycountymd.gov - e4271184-e42a-4639-88a5-4168eb1814f7
select ro.routingid, ro.eventcode, ro.routingstatustypeid,
	ro.fromroleid, ro.tosecurityusersid, ro.updatedby, ro.updatedon 
from routing ro
where ro.eventcode = 'PCAUTH'
	and ro.routingstatustypeid  = 41
	and ro.activeflag = 1
	and ro.fromroleid <> 'FNSFS'
	and ( select count(*) 
			 from tb_payment_header ph 
		  where ph.authorization_id = ro.objectid::bigint
			and ph.delete_sw  = 'N'
		) = 0 ;

update routing ro
set fromroleid = 'FNSFS',
	updatedon = now(), 
	updatedby = 'CDM-18579'
where ro.eventcode = 'PCAUTH'
	and ro.routingstatustypeid  = 41
	and ro.activeflag = 1
	and ro.fromroleid <> 'FNSFS'
	and ( select count(*) 
			 from tb_payment_header ph 
		  where ph.authorization_id = ro.objectid::bigint
			and ph.delete_sw  = 'N'
		) = 0 ;


/*
-- Data to revert if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('be1741f5-fc76-4b11-b419-33ab33ae2b6a'::uuid, 'PCAUTHR', 'e4271184-e42a-4639-88a5-4168eb1814f7', NULL, 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 'FNSFS', 'FNSFS', '1803349', 41, 1, 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-11-19 15:00:29.205', 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-11-19 15:00:29.205', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('8e0859c7-1564-460c-a3a3-9a49110200b2'::uuid, 'PCAUTHR', 'e4271184-e42a-4639-88a5-4168eb1814f7', NULL, 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 'FNSFS', 'FNSFS', '1803349', 41, 1, 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-11-19 14:59:37.038', 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-11-19 14:59:37.038', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3847872f-4019-4130-a9f7-beffe6e6e153'::uuid, 'PCAUTHR', 'e4271184-e42a-4639-88a5-4168eb1814f7', 'a28308ae-8989-4f66-b47c-f26db59c1118', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 'FNSFS', 'FNSFS', '1803349', 43, 1, 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-11-19 14:59:18.973', 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-11-19 14:59:18.973', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('1f1f8c1c-947b-4db0-8b1d-a1c371c4bea5'::uuid, 'PCAUTHR', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '390fe84f-bf06-4f80-9795-065f4d170df3', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c'::uuid, 'CWSP', 'FNSFW', '1803349', 40, 1, 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2021-11-09 15:56:51.420', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2021-11-09 15:56:51.420', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3193098', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('8ba027a2-8ae6-42c5-8145-115ea5d1b42c'::uuid, 'PCAUTH', '390fe84f-bf06-4f80-9795-065f4d170df3', 'e4271184-e42a-4639-88a5-4168eb1814f7', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 'CWCW', 'FNSFS', '1803349', 41, 1, '390fe84f-bf06-4f80-9795-065f4d170df3', '2021-11-10 10:30:02.125', '390fe84f-bf06-4f80-9795-065f4d170df3', '2021-11-10 10:30:02.125', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('c4d0f4c6-dfef-4a16-9b9f-fe780df5142e'::uuid, 'PCAUTH', '390fe84f-bf06-4f80-9795-065f4d170df3', 'e4271184-e42a-4639-88a5-4168eb1814f7', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 'CWCW', 'FNSFS', '1803349', 41, 0, '390fe84f-bf06-4f80-9795-065f4d170df3', '2021-11-09 16:40:56.804', '390fe84f-bf06-4f80-9795-065f4d170df3', '2021-11-10 10:28:18.029', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('050a9d15-9bfb-4c2b-9153-a2851314afb1'::uuid, 'PCAUTHR', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '390fe84f-bf06-4f80-9795-065f4d170df3', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c'::uuid, 'CWSP', 'FNSFW', '1803349', 40, 0, 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2021-11-09 15:57:11.679', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2021-11-09 16:39:40.337', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3193098', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('de269175-272b-434c-89c6-ba975fcad659'::uuid, 'PCAUTH', '390fe84f-bf06-4f80-9795-065f4d170df3', 'e4271184-e42a-4639-88a5-4168eb1814f7', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 'CWCW', 'FNSFS', '1803349', 41, 0, '390fe84f-bf06-4f80-9795-065f4d170df3', '2021-11-09 16:39:40.337', '390fe84f-bf06-4f80-9795-065f4d170df3', '2021-11-09 16:40:56.804', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	
