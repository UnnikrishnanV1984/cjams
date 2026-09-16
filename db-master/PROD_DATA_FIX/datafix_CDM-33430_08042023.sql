-- CDM-33430 - Payment approval pending
/*
-- Issue Description: 
   Unable to approve Purchase Authorization payment

-- Case ID: 3187781
-- Client ID: 1153175 (LATERRIONA L	HALL) - a31054e2-b15f-4c68-b627-bb95ec9612bf
-- Authorization ID: 2369683 Date: 02/04/2023 To 02/04/2023 - $225.00 - Individual Counseling (Paid) 
-- Provider ID: 5090200	(Cynthia Mohamed)
-- Payment ID: 3566782 - Payment Approved on 08/04/2023

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Duplicate multiple active records in routing table)
-- Fix Provided: Datafix has been promoted to remove the pending routing records.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete the duplicate routing records (CDM-33430)
/*
-- Delete 
1	43	Approved						80c18e6f-87c7-4434-a429-490a27718c85
1	43	Approved						ac509247-65e1-4336-8616-32b1a02aae9b
0	39	Forwarded to Case Supervisor	aef2dd2f-a88d-4938-be71-560488413f7c

-- Keep 
1	43	Approved	3e2a517b-3ba8-4bea-b7ea-4f33b5c40ebe
0	40	Forwarded to Funding Approval	5f235f8c-e7cf-441b-8f08-80abe235a4e1
0	39	Forwarded to Case Supervisor	290df01f-c550-4087-a6fa-33664eaa453b

*/

select *
	from routing 
where routingid 
	in (	'80c18e6f-87c7-4434-a429-490a27718c85',
			'ac509247-65e1-4336-8616-32b1a02aae9b',
			'aef2dd2f-a88d-4938-be71-560488413f7c'
		)	
	and objectid = '2369683'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid 
	in (	'80c18e6f-87c7-4434-a429-490a27718c85',
			'ac509247-65e1-4336-8616-32b1a02aae9b',
			'aef2dd2f-a88d-4938-be71-560488413f7c'
		)	
	and objectid = '2369683'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
/*
-- To Revert the data if needed 
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('aef2dd2f-a88d-4938-be71-560488413f7c', 'PCAUTH', '52f46641-70f6-4e8d-aefd-1dbaa11c56a0', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '60296e7e-5bb8-40b2-9bba-bb8a87a325c9', 'CWCW', 'CWSP', '2369683', 39, 0, '52f46641-70f6-4e8d-aefd-1dbaa11c56a0', '2023-08-03 12:12:46.989', '52f46641-70f6-4e8d-aefd-1dbaa11c56a0', '2023-08-03 14:31:26.504', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3187781', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ac509247-65e1-4336-8616-32b1a02aae9b', 'PCAUTHR', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', 'a7b7b759-341a-4604-a853-3a922c75fb4d', 'b1de819d-0f16-4f9e-a86d-d1b89d0474da', 'CWSP', 'FNSFS', '2369683', 43, 1, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-08-03 14:31:26.504', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-08-03 14:31:26.504', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3187781', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('80c18e6f-87c7-4434-a429-490a27718c85', 'PCAUTHR', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', 'a7b7b759-341a-4604-a853-3a922c75fb4d', 'b1de819d-0f16-4f9e-a86d-d1b89d0474da', 'CWSP', 'FNSFS', '2369683', 43, 1, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-08-03 14:42:14.253', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-08-03 14:42:14.253', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3187781', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

