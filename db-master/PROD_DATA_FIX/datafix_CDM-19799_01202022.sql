-- CDM-19799 - Cannot close case (Provider)
/*
-- Issue Description: 
   Provider Closure issue due to Denied Purchase Authorization with Pending routing record 

-- Case ID:3294581
-- Client ID: 4298644 (HOYT	WOLFE) - 12e04ce7-a125-4cba-a7de-59176e2c8d07
-- Auth ID: 1734024 - Date 2020-06-08 To 2020-06-08 - $400.00
-- Service Log ID: 1957810 - Transportation assistance (Paid) 
-- Garrett Provider ID: 5092292 (Melita L Friend) - Local Department Home

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Make Active
-- 0	62	Denied	1619241c-22b5-4b8c-809b-b16223264161	0	da23f52d-6348-413b-9e37-0de2ab823825	2020-06-09 09:50:22
select activeflag, routingstatustypeid, remarks, activeflag, updatedby, updatedon
	from routing 
where routingid  = '1619241c-22b5-4b8c-809b-b16223264161'
	and objectid = '1734024'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-19799',
	updatedon = now()
where routingid  = '1619241c-22b5-4b8c-809b-b16223264161'
	and objectid = '1734024'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
		
-- Delete 
-- 1	41	Forwarded to Payment Approval	76d94643-d79d-4d59-a3fc-eab927afa9f3
select *
	from routing 
where routingid  = '76d94643-d79d-4d59-a3fc-eab927afa9f3'
	and objectid = '1734024'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid  = '76d94643-d79d-4d59-a3fc-eab927afa9f3'
	and objectid = '1734024'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

/*
-- To Revert the data if needed

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('76d94643-d79d-4d59-a3fc-eab927afa9f3'::uuid, 'PCAUTHR', 'b65af552-0e15-483e-9f1b-d6ffdd2ebced', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFS', '1734024', 41, 1, 'b65af552-0e15-483e-9f1b-d6ffdd2ebced', '2020-06-09 09:50:22.478', 'b65af552-0e15-483e-9f1b-d6ffdd2ebced', '2020-06-09 09:50:22.478', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', '3294581', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/	
