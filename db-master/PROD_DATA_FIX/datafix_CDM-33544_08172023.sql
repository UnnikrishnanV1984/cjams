-- CDM-33544 - Payment approval pending
/*
-- Issue Description: 
   Purchase Authorization 2384311 has been approved by supervisor however it still says pending. 
   
-- Case ID: 3257200
-- Client ID: 1154414 (SHAKEYA A MACKALL) - 7deed421-810e-4497-a63a-74dd5e7125a3
-- Authorization ID: 2384311 Date: 08/01/2023 To 08/31/2023 - $865.00 - Mental Health-Counseling (Paid)  
-- Provider ID: 6001532 (A New Hope Family Therapeutic Services LLC)
-- Payment ID: 3579854 - Date: 08/11/2023

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Duplicate multiple active records in routing table)
-- Fix Provided: Datafix has been promoted to remove the pending routing records.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete the duplicate routing records (CDM-33544)
/*

-- Delete 
0	39	Forwarded to Case Supervisor	17f9c8e8-5916-43c4-a6bd-509c2744fbdc
1	43	Approved						240f036e-1318-4827-aeab-6e7b2f306cac

-- Keep
1	43	Approved	5e320d94-bc00-43de-ab62-9b1928e8dbf2
0	40	Forwarded to Funding Approval	af8da70c-0335-496b-a851-65de4209d5fd
0	39	Forwarded to Case Supervisor	9fd684fa-bf8f-4c0e-b64b-31d2aaff503f


*/

select *
	from routing 
where routingid 
	in (	'17f9c8e8-5916-43c4-a6bd-509c2744fbdc',
			'240f036e-1318-4827-aeab-6e7b2f306cac'
		)	
	and objectid = '2384311'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid 
	in (	'17f9c8e8-5916-43c4-a6bd-509c2744fbdc',
			'240f036e-1318-4827-aeab-6e7b2f306cac'
		)	
	and objectid = '2384311'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
/*
-- To Revert the data if needed 

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('17f9c8e8-5916-43c4-a6bd-509c2744fbdc', 'PCAUTH', 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '60296e7e-5bb8-40b2-9bba-bb8a87a325c9', 'CWCW', 'CWSP', '2384311', 39, 0, 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', '2023-08-09 12:51:56.542', 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', '2023-08-09 14:13:41.325', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3257200', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('240f036e-1318-4827-aeab-6e7b2f306cac', 'PCAUTHR', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '8302bc5c-35f0-4a49-a397-361305939deb', 'b1de819d-0f16-4f9e-a86d-d1b89d0474da', 'CWSP', 'FNSFS', '2384311', 43, 1, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-08-09 14:13:41.325', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2023-08-09 14:13:41.325', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3257200', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

