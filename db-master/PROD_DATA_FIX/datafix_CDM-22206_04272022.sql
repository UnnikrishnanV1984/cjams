-- CDM-22206 - Flex fund
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Case ID: 211030011843
-- Client ID: 200767325 (SHAKIRRA L	BUSH) - 527e6621-fdd1-454c-a1d9-fbbd910eae21
-- Service Log ID: 2039124 - 2022-04-13	To 2022-06-13 - Rent Payments/Deposit (Paid)
-- Vendor: 6003130 (Atlantic Realty Management Holdings) 
-- Auth ID: 1827777

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
/*
-- 1	40	Forwarded to Funding Approval	e72693f7-b56f-485f-bbac-ea21949c53f7
*/

select *
	from routing 
where routingid = 'e72693f7-b56f-485f-bbac-ea21949c53f7'
	and objectid = '1827777'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid = 'e72693f7-b56f-485f-bbac-ea21949c53f7'
	and objectid = '1827777'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('e72693f7-b56f-485f-bbac-ea21949c53f7'::uuid, 'PCAUTHR', '01fe0673-a038-43e8-b756-7b734e26c9b6', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a'::uuid, 'CWSP', 'FNSFS', '1827777', 40, 1, '01fe0673-a038-43e8-b756-7b734e26c9b6', '2022-04-18 15:47:36.647', '01fe0673-a038-43e8-b756-7b734e26c9b6', '2022-04-18 15:47:36.647', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '211030011843', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	
