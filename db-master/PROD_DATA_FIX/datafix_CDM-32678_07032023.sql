-- CDM-32678 - Unable to approve payment
/*
-- Issue Description: 
   Unable to approve Purchase Authorization payment

-- Case ID: 211030010108
-- Client ID: 200793862 (ReJohnay Henderson) - 9c1aff87-eb77-4598-ab9a-a72a2b979ce9
-- Authorization ID: 2237832 - 2023-04-25 To 2023-05-12 - $46.35 - Dental (Paid) 
-- Providre ID: 6052929	(Tidewater, LLC)
-- Payment ID: 3489416 - 07/03/2023 - $46.35 - Payment Approved on 07/03/2023

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
1	43	Approved	cf9c54f2-3692-4885-98cd-66a082730a91
1	43	Approved	3180fa51-35b5-436c-893e-7f129dade72f
0	39	Forwarded to Case Supervisor	bf602eed-ef74-407a-afc5-3cf4c3eb9ee5
*/

select *
	from routing 
where routingid 
	in (	'cf9c54f2-3692-4885-98cd-66a082730a91',
			'3180fa51-35b5-436c-893e-7f129dade72f',
			'bf602eed-ef74-407a-afc5-3cf4c3eb9ee5'
		)	
	and objectid = '2237832'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid 
	in (	'cf9c54f2-3692-4885-98cd-66a082730a91',
			'3180fa51-35b5-436c-893e-7f129dade72f',
			'bf602eed-ef74-407a-afc5-3cf4c3eb9ee5'
		)	
	and objectid = '2237832'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
/*
-- To Revert the data if needed 

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('bf602eed-ef74-407a-afc5-3cf4c3eb9ee5', 'PCAUTH', 'c5e0a74b-8f3c-4804-8ec7-af7038043f3f', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '60296e7e-5bb8-40b2-9bba-bb8a87a325c9', 'CWCW', 'CWSP', '2237832', 39, 0, 'c5e0a74b-8f3c-4804-8ec7-af7038043f3f', '2023-06-30 14:07:52.455', 'c5e0a74b-8f3c-4804-8ec7-af7038043f3f', '2023-06-30 14:36:16.427', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030010108', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('cf9c54f2-3692-4885-98cd-66a082730a91', 'PCAUTHR', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', 'a7b7b759-341a-4604-a853-3a922c75fb4d', 'b1de819d-0f16-4f9e-a86d-d1b89d0474da', 'CWSP', 'FNSFS', '2237832', 43, 1, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-06-30 14:55:30.841', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-06-30 14:55:30.841', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '211030010108', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3180fa51-35b5-436c-893e-7f129dade72f', 'PCAUTHR', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', 'a7b7b759-341a-4604-a853-3a922c75fb4d', 'b1de819d-0f16-4f9e-a86d-d1b89d0474da', 'CWSP', 'FNSFS', '2237832', 43, 1, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-06-30 14:36:16.427', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-06-30 14:36:16.427', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '211030010108', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

