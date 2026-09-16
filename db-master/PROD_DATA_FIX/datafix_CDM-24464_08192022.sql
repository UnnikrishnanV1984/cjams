-- CDM-24464 - Duplicate Purchase Auth approval
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing records 

-- Case ID: 3295044
-- Client ID: 200023579 (Josiah Jacks) - 30ba9a34-c2d8-4976-b60b-acb5bab20bcd
-- Authorization ID: 1847621 - Child Care (Paid)   
-- Provider ID: 5085235 (Chris Learning Center Inc.)
-- Payment ID: 3220926 - 08/16/2022 - $1200.00


-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	39	Forwarded to Case Supervisor	7dec9cca-c63f-4a40-9f68-f581c458d7b0
-- 0	42	Forwarded to Director Approval	a6620b18-8de0-4c74-94dc-a4a31e5dca09

select *
	from routing 
where routingid in ('7dec9cca-c63f-4a40-9f68-f581c458d7b0','a6620b18-8de0-4c74-94dc-a4a31e5dca09')
	and objectid = '1847621'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid in ('7dec9cca-c63f-4a40-9f68-f581c458d7b0','a6620b18-8de0-4c74-94dc-a4a31e5dca09')
	and objectid = '1847621'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
/*
-- To Revert the data if needed

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('a6620b18-8de0-4c74-94dc-a4a31e5dca09'::uuid, 'PCAUTH', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', 'a26dcd1d-a287-43bb-afc9-da75f966f69b', '263e4d5d-cf6c-4e7d-8c35-394a62e46028'::uuid, 'CWSP', 'CWSP', '1847621', 42, 0, '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2022-08-12 14:26:18.169', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2022-08-12 15:52:59.344', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '3295044', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7dec9cca-c63f-4a40-9f68-f581c458d7b0'::uuid, 'PCAUTH', '8691ebb4-e8e7-4efd-8ea9-95e93f8d324d', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', 'a4bf63ee-9314-458b-95d9-0c7095db11a4'::uuid, 'CWCW', 'CWSP', '1847621', 39, 1, '8691ebb4-e8e7-4efd-8ea9-95e93f8d324d', '2022-08-11 13:22:08.486', '8691ebb4-e8e7-4efd-8ea9-95e93f8d324d', '2022-08-11 13:22:08.486', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3295044', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/	

