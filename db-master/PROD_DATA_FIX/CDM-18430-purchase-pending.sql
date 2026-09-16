-- CDM-18430 - Payment stays pending even after approval
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Case number: 3215035
-- Auth ID: 1802118 
   
-- Category/ Module: Purchase Authorization Pending (Finance Management) 
-- Root cause: Data issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select *
	from routing 
where routingid  in
	(	
      'e58c6c6c-b3da-4535-a315-3e771673a9ec'
	)
	and objectid = '1802118'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid  in
	(	
          'e58c6c6c-b3da-4535-a315-3e771673a9ec'
	)
	and objectid = '1802118'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('e58c6c6c-b3da-4535-a315-3e771673a9ec'::uuid, 'PCAUTH', '7f7a58e2-4847-4642-801a-f0b2a7c37cfa', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '13021883-e81b-49f1-8556-4e048236e271'::uuid, 'CWCW', 'CWSP', '1802118', 39, 1, '7f7a58e2-4847-4642-801a-f0b2a7c37cfa', '2021-11-02 10:56:39.006', 'CDM-18430', '2021-11-02 10:56:39.006', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3215035', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


