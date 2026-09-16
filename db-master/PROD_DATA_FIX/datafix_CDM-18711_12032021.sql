-- CDM-18711 -	Not getting pending approval alerts
/*
-- Issue Description: 
   Authorization Approval Issue - Routing data issue 
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Was error in prior User story code 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: 
						This is resolved and the code fix is moved to PROD
*/

-- Delete duplicate routing records 
-- 1805361 -- 6343ea38-a095-4c1e-9317-f68c0b3224b3
select *
	from routing 
where routingid = '6343ea38-a095-4c1e-9317-f68c0b3224b3'
	and objectid = '1805361'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;

delete from routing   
where routingid = '6343ea38-a095-4c1e-9317-f68c0b3224b3'
	and objectid = '1805361'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;

-- 1806440 -- e933f19c-ed08-487d-9c20-b27fcc11bc5f	
select *
	from routing 
where routingid = 'e933f19c-ed08-487d-9c20-b27fcc11bc5f'
	and objectid = '1806440'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
delete from routing   
where routingid = 'e933f19c-ed08-487d-9c20-b27fcc11bc5f'
	and objectid = '1806440'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;

-- Mass Datafix to update default supervisors as tosecurityusersid
select routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
	routingstatustypeid, updatedby, updatedon 
	,(	select up.supervisorid 
			from userprofile up 
		where up.securityusersid = ro.fromsecurityusersid 
	 ) as supervisorid 
from routing ro
where eventcode = 'PCAUTH'
	and activeflag = 1
	and routingstatustypeid = 39
	and tosecurityusersid is null ;

update routing ro
set tosecurityusersid 
		= (	select up.supervisorid 
				from userprofile up 
			where up.securityusersid = ro.fromsecurityusersid 
		  ),
	updatedon = now(), 
	updatedby = 'CDM-18711'
where eventcode = 'PCAUTH'
	and activeflag = 1
	and routingstatustypeid = 39
	and tosecurityusersid is null ;
		
/*
-- Data to revert if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('6343ea38-a095-4c1e-9317-f68c0b3224b3'::uuid, 'PCAUTH', 'efc73713-a472-47a2-bb55-da6a4daa500f', NULL, 'd2698961-4b15-4ac1-b9c1-2337406e8c4d'::uuid, 'CWCW', 'CWSP', '1805361', 39, 1, 'efc73713-a472-47a2-bb55-da6a4daa500f', '2021-11-23 15:05:28.096', 'efc73713-a472-47a2-bb55-da6a4daa500f', '2021-11-23 15:05:28.096', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3282116', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('e933f19c-ed08-487d-9c20-b27fcc11bc5f'::uuid, 'PCAUTH', '258cfaf9-ebe7-4996-b3b9-2d6a3cdcea94', NULL, 'c7915c01-783a-40f4-bb8e-5b2b42b51318'::uuid, 'CWCW', 'CWSP', '1806440', 39, 1, '258cfaf9-ebe7-4996-b3b9-2d6a3cdcea94', '2021-12-01 21:39:20.777', '258cfaf9-ebe7-4996-b3b9-2d6a3cdcea94', '2021-12-01 21:39:20.777', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3279442', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/