-- CDM-15315 - Bill put in once, came through twice
/*
-- Issue Description: 
   Purchase Authorization with duplicate routing records Issue 

-- Case ID: 3175162
-- Client ID: 2035941 (AMIR	O'BRIEN) - 93266ba8-31df-4ca7-a8d6-9fbc0ffb2352
-- Srevice Log ID: 2006514 - Financial Management (Paid) 
-- Auth ID: 1786214 - Payment # 3074628 Date 2021-08-20
-- Provider ID: 5029126	(Washington County Depart. of Social Services)
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- Delete 
-- 1	62	Denied	85777fd6-1a4d-40e5-987e-8ab4a3531ae1
-- 1	62	Denied	afc0064a-042f-450e-ab2b-83609e4cced8
-- 1	62	Denied	a14a1f6b-e84b-4981-8d36-407eafe4f806

select activeflag, routingstatustypeid, remarks,  *
	from routing 
where routingid
		in ( '85777fd6-1a4d-40e5-987e-8ab4a3531ae1',
			 'afc0064a-042f-450e-ab2b-83609e4cced8',
			 'a14a1f6b-e84b-4981-8d36-407eafe4f806'
		   )
	and objectid = '1786214'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid 
		in ( '85777fd6-1a4d-40e5-987e-8ab4a3531ae1',
			 'afc0064a-042f-450e-ab2b-83609e4cced8',
			 'a14a1f6b-e84b-4981-8d36-407eafe4f806'
		   )
	and objectid = '1786214'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

-- Update as Approved
-- 1	62	Denied	37ac5afa-1263-4f9f-a631-bcadf52c0ad3

select activeflag, routingstatustypeid, remarks, routeddescription, updatedby, updatedon
	from routing 
where routingid = '37ac5afa-1263-4f9f-a631-bcadf52c0ad3'
	and objectid = '1786214'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ; 

update routing
set routingstatustypeid = 43,
	remarks = 'Approved',
	routeddescription = 'Approved Purchase Authorization Forwarded to Payment Approval',
	updatedby = 'CDM-15315',
	updatedon = now()	
where routingid = '37ac5afa-1263-4f9f-a631-bcadf52c0ad3'
	and objectid = '1786214'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ; 

/*
For Back-up
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('85777fd6-1a4d-40e5-987e-8ab4a3531ae1'::uuid, 'PCAUTH', '4356aea9-455d-42a8-994f-67d90dd95291', '981a9650-770e-46aa-8686-00c8fc2ddbe8', 'f8c0dec9-4809-475b-a576-c2803d4b7598'::uuid, 'CWCW', 'CWSP', '1786214', 62, 1, '4356aea9-455d-42a8-994f-67d90dd95291', '2021-07-20 10:39:10.347', '4356aea9-455d-42a8-994f-67d90dd95291', '2021-07-20 10:39:10.347', true, 'Denied', NULL, 'Duplicate approvals dw 8/27/21', '3175162', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('afc0064a-042f-450e-ab2b-83609e4cced8'::uuid, 'PCAUTHR', '5584f32e-f6d8-4960-8e66-081aac2d35c8', '981a9650-770e-46aa-8686-00c8fc2ddbe8', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1786214', 62, 1, '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-07-20 16:01:26.206', '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-07-20 16:01:26.206', true, 'Denied', NULL, 'Duplicate approvals dw 8/27/21', '3175162', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('a14a1f6b-e84b-4981-8d36-407eafe4f806'::uuid, 'PCAUTHR', '5584f32e-f6d8-4960-8e66-081aac2d35c8', '981a9650-770e-46aa-8686-00c8fc2ddbe8', '5e5ec749-3791-4cc7-ad32-cf85b0c52d74'::uuid, 'CWSP', 'FNSFS', '1786214', 62, 1, '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-07-30 10:44:43.697', '5584f32e-f6d8-4960-8e66-081aac2d35c8', '2021-07-30 10:44:43.697', true, 'Denied', NULL, 'Duplicate approvals dw 8/27/21', '3175162', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
