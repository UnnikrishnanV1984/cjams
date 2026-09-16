-- CDM-22931 - Stuck purchase authorization
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing records 

-- Case ID: 2020027403328
-- Client ID: 4221048 (NATALIE Candese RIVERA) - 054a4459-f7e2-4c5d-8e20-a0e79a0ed23e
-- Authorization ID: 1815709 - 06/01/2021 TO 06/18/2021 - $2575.20 - Educational-High School (Paid) 
-- Provider ID: 5001284	(Woodbourne Center)
-- Payment ID: 3145484 Date:02/11/2022 - $2575.20

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (duplicate multiple active records in routing table)
-- Fix Provided: Datafix has been promoted to remove the duplicate Pending routing records 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1815709 - Delete duplicate Pending routing records (CDM-22931)
/*
-- Delete 
1	39	Forwarded to Case Supervisor	b1b0cc0d-8442-4b89-bc29-6c9cb4cecc31
1	44	Forwarded to Funding Approval	5c0ec7f1-2b3c-468a-906a-3f44834b718b
0	42	Forwarded to Director Approval	8b92f765-87ff-4d41-9241-689c99071079
0	44	Forwarded to Funding Approval	a8d2d775-530d-431e-b77d-eb66749d78f7
0	42	Forwarded to Director Approval	20012ef6-1944-4f41-b9ba-8f575e9682d9

-- Update activeflag = 1
0	43	Approved	b46656a5-0418-4abe-97f5-1b53d6d22c8d

-- Okay
0	44	Forwarded to Funding Approval	c2e00de4-e6b6-40c8-b5ce-c93ee6d5a7b4
0	42	Forwarded to Director Approval	5f012579-d5c4-4451-af42-32bfc03db365
0	39	Forwarded to Case Supervisor	61fbf028-c138-46f7-83be-f7b575ce1b2f
*/

select *
	from routing 
where routingid 
	in ( 
			'b1b0cc0d-8442-4b89-bc29-6c9cb4cecc31',
			'5c0ec7f1-2b3c-468a-906a-3f44834b718b',
			'8b92f765-87ff-4d41-9241-689c99071079',
			'a8d2d775-530d-431e-b77d-eb66749d78f7',
			'20012ef6-1944-4f41-b9ba-8f575e9682d9'
		)	
	and objectid = '1815709'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid 
	in ( 
			'b1b0cc0d-8442-4b89-bc29-6c9cb4cecc31',
			'5c0ec7f1-2b3c-468a-906a-3f44834b718b',
			'8b92f765-87ff-4d41-9241-689c99071079',
			'a8d2d775-530d-431e-b77d-eb66749d78f7',
			'20012ef6-1944-4f41-b9ba-8f575e9682d9'
		)	
	and objectid = '1815709'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;

select objectid, objecttypekey, eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid = 'b46656a5-0418-4abe-97f5-1b53d6d22c8d'
	and objectid = '1815709'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 0 ;
	
update routing
set activeflag = 1, 
	updatedby = 'CDM-22931', 
	updatedon = now()
where routingid = 'b46656a5-0418-4abe-97f5-1b53d6d22c8d'
	and objectid = '1815709'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 0 ;

	
	
/*
-- To Revert the data if needed 1815709

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b1b0cc0d-8442-4b89-bc29-6c9cb4cecc31'::uuid, 'PCAUTH', 'c771366f-c929-4596-b2af-7825eb1a499c', 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', '1c28acd6-9ef9-4b46-9ab3-a3dfc386bacd'::uuid, 'CWCW', 'CWSP', '1815709', 39, 1, 'c771366f-c929-4596-b2af-7825eb1a499c', '2022-01-25 14:37:19.725', 'c771366f-c929-4596-b2af-7825eb1a499c', '2022-01-25 14:37:19.725', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '2020027403328', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('20012ef6-1944-4f41-b9ba-8f575e9682d9'::uuid, 'PCAUTH', 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', '0a24201d-7f71-44e2-b2a0-25cb58bf58cd', '5fbe9b6e-4c13-48d3-8a91-e36b9a16c507'::uuid, 'CWSP', 'CWSP', '1815709', 42, 0, 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', '2022-02-22 11:26:37.187', 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', '2022-02-23 09:44:44.766', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '2020027403328', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('8b92f765-87ff-4d41-9241-689c99071079'::uuid, 'PCAUTH', 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', '0a24201d-7f71-44e2-b2a0-25cb58bf58cd', '5fbe9b6e-4c13-48d3-8a91-e36b9a16c507'::uuid, 'CWSP', 'CWSP', '1815709', 42, 0, 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', '2022-04-06 16:46:19.814', 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', '2022-04-07 15:05:42.017', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '2020027403328', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('a8d2d775-530d-431e-b77d-eb66749d78f7'::uuid, 'PCAUTHR', '0a24201d-7f71-44e2-b2a0-25cb58bf58cd', NULL, 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c'::uuid, 'CWSP', 'FNSFW', '1815709', 44, 0, '0a24201d-7f71-44e2-b2a0-25cb58bf58cd', '2022-02-23 09:44:44.766', '0a24201d-7f71-44e2-b2a0-25cb58bf58cd', '2022-04-06 16:46:19.814', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020027403328', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('5c0ec7f1-2b3c-468a-906a-3f44834b718b'::uuid, 'PCAUTHR', '0a24201d-7f71-44e2-b2a0-25cb58bf58cd', NULL, 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c'::uuid, 'CWSP', 'FNSFW', '1815709', 44, 1, '0a24201d-7f71-44e2-b2a0-25cb58bf58cd', '2022-04-07 15:05:42.017', '0a24201d-7f71-44e2-b2a0-25cb58bf58cd', '2022-04-07 15:05:42.017', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020027403328', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
