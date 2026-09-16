-- CDM-25445 - Missing Service Log
/*
-- Issue Description: 
   Purchase Authorization with duplicate routing records 

-- Case ID: 3275202
-- Client ID: 4076206 (JAYONTAY JAMIE LEE JOHNSON) - 2e7ada70-e2cd-4a95-b0be-07eb013a4852
-- Private Organization: 5001284 (Nexus Woodbourne Family Healing, Inc.)
-- Authorization ID: 1828379 - $4634.03 - Educational-High School (Paid) 

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	44	Forwarded to Funding Approval			239307b9-8479-4a62-b756-62a127b3e095	PCAUTHR
-- 0	42	Forwarded to Program Manager Approval	53417288-325a-40da-84bc-6ba649a2141c	PCAUTHR
select *
	from routing 
where routingid in ( '239307b9-8479-4a62-b756-62a127b3e095', '53417288-325a-40da-84bc-6ba649a2141c')
	and objectid = '1828379'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and (select count(*) 
			from tb_payment_header 
	 	 where authorization_id  = 1828379
	 		and delete_sw = 'N'
 		) = 0
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid in ( '239307b9-8479-4a62-b756-62a127b3e095', '53417288-325a-40da-84bc-6ba649a2141c')
	and objectid = '1828379'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and (select count(*) 
			from tb_payment_header 
	 	 where authorization_id  = 1828379
	 		and delete_sw = 'N'
 		) = 0
	-- and activeflag = 1 
	;

-- Make Active 
-- 0	41	Forwarded to Payment Approval	26dd56d4-232e-4775-a61b-9e941ade52fd	PCAUTH
select *
	from routing 
where routingid = '26dd56d4-232e-4775-a61b-9e941ade52fd'
	and objectid = '1828379'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and (select count(*) 
			from tb_payment_header 
	 	 where authorization_id  = 1828379
	 		and delete_sw = 'N'
 		) = 0
	and activeflag = 0
	;

update routing
set activeflag = 1,
	updatedby = 'CDM-25445',
	updatedon = now()
where routingid = '26dd56d4-232e-4775-a61b-9e941ade52fd'
	and objectid = '1828379'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and (select count(*) 
			from tb_payment_header 
	 	 where authorization_id  = 1828379
	 		and delete_sw = 'N'
 		) = 0
	and activeflag = 0
	;
	
/*
-- To Revert the data if needed

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('53417288-325a-40da-84bc-6ba649a2141c'::uuid, 'PCAUTHR', '92e7ff56-753f-438d-af02-025074c4906c', '2e0c5cab-7b62-41ea-b505-11142d2fb04b', 'fe365861-95e5-4fc3-9ca8-428168159af9'::uuid, 'CWSP', 'LDSSPM', '1828379', 42, 0, '92e7ff56-753f-438d-af02-025074c4906c', '2022-06-03 17:22:35.108', '92e7ff56-753f-438d-af02-025074c4906c', '2022-09-15 16:55:10.306', true, 'Forwarded to Program Manager Approval', NULL, 'Purchase Authorization Forwarded to Program Manager Approval', '3275202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('239307b9-8479-4a62-b756-62a127b3e095'::uuid, 'PCAUTHR', '2e0c5cab-7b62-41ea-b505-11142d2fb04b', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a'::uuid, 'CWSP', 'FNSFS', '1828379', 44, 1, '2e0c5cab-7b62-41ea-b505-11142d2fb04b', '2022-09-15 16:55:10.306', '2e0c5cab-7b62-41ea-b505-11142d2fb04b', '2022-09-15 16:55:10.306', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3275202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/	
