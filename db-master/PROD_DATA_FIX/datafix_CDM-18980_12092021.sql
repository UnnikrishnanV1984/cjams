-- CDM-18980 - stuck purchase authorization
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Case ID: 3280186
-- Client ID: 4462700 (DIANA SKOK) - 722fadca-f034-469a-9d7b-219d03459b5f  
-- Service Log ID: 2019915 - 04/01/2021 To Open - Child Care (Paid)  
-- Provider ID: 5040369 (Just Us Kids)
-- Authorization ID: 1805599
-- Payment ID: 3119834 Date: 12/07/2021 - $810.00
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	41	Forwarded to Payment Approval	47de2656-c52c-4913-b661-112242f1cd51
-- 1	41	Forwarded to Payment Approval	273bec6a-76a3-4479-8043-83c4541bf15f
-- 1	43	Approved						38b5c0a3-be76-44a9-91b0-e46b94dbfd5f
-- 1	40	Forwarded to Funding Approval	31901984-afa8-4239-b432-5766d3182453

select *
	from routing 
where routingid  in
	(	'47de2656-c52c-4913-b661-112242f1cd51', 
		'273bec6a-76a3-4479-8043-83c4541bf15f',
		'38b5c0a3-be76-44a9-91b0-e46b94dbfd5f',
		'31901984-afa8-4239-b432-5766d3182453'
	)
	and objectid = '1805599'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid  in
	(	'47de2656-c52c-4913-b661-112242f1cd51', 
		'273bec6a-76a3-4479-8043-83c4541bf15f',
		'38b5c0a3-be76-44a9-91b0-e46b94dbfd5f',
		'31901984-afa8-4239-b432-5766d3182453'
	)
	and objectid = '1805599'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('31901984-afa8-4239-b432-5766d3182453'::uuid, 'PCAUTHR', '27920e1e-978e-4231-a9d5-ea7323ceb413', 'e4271184-e42a-4639-88a5-4168eb1814f7', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c'::uuid, 'CWSP', 'FNSFW', '1805599', 40, 1, '27920e1e-978e-4231-a9d5-ea7323ceb413', '2021-12-06 11:16:04.318', '27920e1e-978e-4231-a9d5-ea7323ceb413', '2021-12-06 11:16:04.318', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3280186', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('47de2656-c52c-4913-b661-112242f1cd51'::uuid, 'PCAUTHR', 'e4271184-e42a-4639-88a5-4168eb1814f7', NULL, 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 'FNSFS', 'FNSFS', '1805599', 41, 1, 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-12-07 18:26:48.449', 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-12-07 18:26:48.449', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('273bec6a-76a3-4479-8043-83c4541bf15f'::uuid, 'PCAUTHR', 'e4271184-e42a-4639-88a5-4168eb1814f7', NULL, 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 'FNSFS', 'FNSFS', '1805599', 41, 1, 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-12-07 18:26:21.968', 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-12-07 18:26:21.968', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('38b5c0a3-be76-44a9-91b0-e46b94dbfd5f'::uuid, 'PCAUTHR', 'e4271184-e42a-4639-88a5-4168eb1814f7', 'a28308ae-8989-4f66-b47c-f26db59c1118', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 'FNSFS', 'FNSFS', '1805599', 43, 1, 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-12-07 18:25:53.060', 'e4271184-e42a-4639-88a5-4168eb1814f7', '2021-12-07 18:25:53.060', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	
