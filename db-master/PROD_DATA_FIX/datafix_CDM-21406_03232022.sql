-- CDM-21406 - Stuck Flex Fund
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Case ID: 211030012066
-- Client ID: 3832678 (TARRYN Z	ATKINS) - f3de208b-2cdc-46eb-a76a-16f5f715260a
-- Service Log ID: 2030405 - Food (Paid)
-- Vendor ID: 5011518 (Giant Food) 
-- Auth ID: 1816704 - Date: 02/01/2022 To 02/28/2022 - $250.00
-- Payment ID: 3148704 Date: 03/01/2022

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
/*
-- 1 39	Forwarded to Case Supervisor bf199734-704a-43a2-a760-9dddb5f77432
*/

select *
	from routing 
where routingid = 'bf199734-704a-43a2-a760-9dddb5f77432'
	and objectid = '1816704'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid = 'bf199734-704a-43a2-a760-9dddb5f77432'
	and objectid = '1816704'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('bf199734-704a-43a2-a760-9dddb5f77432', 'PCAUTH', '9b9ecf80-d190-49e7-a06e-17674ef909e8', 'b60589bc-8886-40ef-a876-a5273ee42597', '77658fe0-e2f4-41d1-af4a-90ab3cb17ac8', 'CWCW', 'CWSP', '1816704', 39, 1, '9b9ecf80-d190-49e7-a06e-17674ef909e8', '2022-02-01 11:26:12.333', '9b9ecf80-d190-49e7-a06e-17674ef909e8', '2022-02-01 11:26:12.333', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030012066', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	
