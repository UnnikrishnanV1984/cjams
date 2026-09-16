-- CDM-24375 - Pending purchase auth needs deleted
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing records 

-- Case ID: 3203347
-- Client ID: 2741266 (JERRY WAYNE GUE) - d05c78de-359c-4a67-a7e7-e9095f4d2d19
-- Authorization ID: 1844421 - Financial Management (Paid)  
-- Provider ID: 5092105 (Shared Horizons Inc. Wesley Vinner Memorial Trust)
-- Payment ID: 3218186 - 08/03/2022 - $1613.26

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	42	Forwarded to Director Approval	1807d12c-c424-4ad9-acba-1a06e2320805
-- 1	44	Forwarded to Funding Approval	0bc293a5-bc23-45d1-a304-4cec97fa23d3


select *
	from routing 
where routingid in ('1807d12c-c424-4ad9-acba-1a06e2320805','0bc293a5-bc23-45d1-a304-4cec97fa23d3')
	and objectid = '1844421'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid in ('1807d12c-c424-4ad9-acba-1a06e2320805','0bc293a5-bc23-45d1-a304-4cec97fa23d3')
	and objectid = '1844421'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('1807d12c-c424-4ad9-acba-1a06e2320805'::uuid, 'PCAUTHR', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', 'fff5f374-8a84-481c-8814-81e62ca36f43', 'a00579a8-139b-42ed-9c4d-662dd7cee47c'::uuid, 'CWSP', 'CWSP', '1844421', 42, 1, 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2022-07-26 13:59:56.784', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2022-07-26 13:59:56.784', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '3203347', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0bc293a5-bc23-45d1-a304-4cec97fa23d3'::uuid, 'PCAUTHR', 'fff5f374-8a84-481c-8814-81e62ca36f43', '8a987827-dbd9-40c3-9d08-bfca35fa4136', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8'::uuid, 'CWSP', 'FNSFW', '1844421', 44, 1, 'fff5f374-8a84-481c-8814-81e62ca36f43', '2022-07-28 09:47:46.796', 'fff5f374-8a84-481c-8814-81e62ca36f43', '2022-07-28 09:47:46.796', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3203347', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	

