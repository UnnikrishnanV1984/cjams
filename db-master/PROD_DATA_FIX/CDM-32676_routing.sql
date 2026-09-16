-- CDM-32678 - Unable to approve payment
/*
-- Issue Description: 
   Unable to approve Purchase Authorization payment

-- Case ID: 231030071971
-- Client ID: 200985681 (Zaelaria Jones) - 9c1aff87-eb77-4598-ab9a-a72a2b979ce9
-- Authorization ID: 2233737 - 07/11/2023 to 07/11/2023 - $27.00 - Discretionary Day Care-Foster Care(7132)
-- Providre ID: 5057816	King's Kids Child Care

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Duplicate multiple active records in routing table)
-- Fix Provided: Datafix has been promoted to remove the pending routing records.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete the duplicate routing records 
/*
-- Delete 
1	40	Approved	85f99bd5-19c7-4db4-bae7-89e2072f4e20
1	40	Approved	437c09c5-9bd0-4a19-8586-d18150bfb959
1	40	Approved	1b970936-a5c0-4a71-921d-4cc6025674f3
1	40	Approved	d5342401-8c0f-47c6-a855-c2fe6d713d09
1	39	Forwarded to Case Supervisor	46a7f56f-2cc3-44d5-96e2-e4b9a9ac357b
*/

select *
	from routing 
where routingid 
	in (	'85f99bd5-19c7-4db4-bae7-89e2072f4e20',
			'437c09c5-9bd0-4a19-8586-d18150bfb959',
            '1b970936-a5c0-4a71-921d-4cc6025674f3',
            'd5342401-8c0f-47c6-a855-c2fe6d713d09',
			'46a7f56f-2cc3-44d5-96e2-e4b9a9ac357b'
		)	
	and objectid = '2233737'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	;
	
delete from routing   
where routingid 
	in ( '85f99bd5-19c7-4db4-bae7-89e2072f4e20',
         '437c09c5-9bd0-4a19-8586-d18150bfb959',
         '1b970936-a5c0-4a71-921d-4cc6025674f3',
         'd5342401-8c0f-47c6-a855-c2fe6d713d09',
         '46a7f56f-2cc3-44d5-96e2-e4b9a9ac357b'
	    )	
	and objectid = '2233737'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	;
	
/*
-- To Revert the data if needed 

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('46a7f56f-2cc3-44d5-96e2-e4b9a9ac357b', 'PCAUTH', '097281cc-d73a-40e7-ae28-85de45adebe1', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', 'f367fc82-9044-4f74-a40e-6d96db9e8625', 'CWCW', 'CWSP', '2233737', 39, 1, '097281cc-d73a-40e7-ae28-85de45adebe1', '2023-06-29 14:38:13.484', '097281cc-d73a-40e7-ae28-85de45adebe1', '2023-06-29 14:38:13.484', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '231030071971', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('1b970936-a5c0-4a71-921d-4cc6025674f3', 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '6f49f182-2740-4648-b688-19980ba32ff4', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'CWSP', 'FNSFS', '2233737', 40, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2023-06-30 11:50:30.774', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2023-06-30 11:50:30.774', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '231030071971', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('d5342401-8c0f-47c6-a855-c2fe6d713d09', 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '6f49f182-2740-4648-b688-19980ba32ff4', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'CWSP', 'FNSFS', '2233737', 40, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2023-06-30 11:53:10.872', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2023-06-30 11:53:10.872', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '231030071971', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('437c09c5-9bd0-4a19-8586-d18150bfb959', 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '6f49f182-2740-4648-b688-19980ba32ff4', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'CWSP', 'FNSFS', '2233737', 40, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2023-06-30 11:43:01.185', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2023-06-30 11:43:01.185', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '231030071971', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('85f99bd5-19c7-4db4-bae7-89e2072f4e20', 'PCAUTHR', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '6f49f182-2740-4648-b688-19980ba32ff4', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'CWSP', 'FNSFS', '2233737', 40, 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2023-06-30 11:43:10.516', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2023-06-30 11:43:10.516', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '231030071971', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

