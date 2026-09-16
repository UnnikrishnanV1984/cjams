-- CIDM-4797 - Ref: CDM-23021 - Placement Approval Issue
/*
-- Issue Description: 
   One Garrett County Placement approval is failing 
	
-- Case ID: 3229725
-- Client ID: 200918270 (Scarlett Davis) - 20aa34b1-29a9-45d1-92ee-dac2e441f167
-- Placement ID: 1572489 - 2022-06-05 To Current - c384c27e-afcc-4884-99ed-ffafbc6090ae
-- Provider ID: 5095954 (Amy Joy Friend) - 	Local Department Home
	
-- Category/ Module: Placement (Case Management) 
-- Root cause: User setup issue, wrong roletypekey in teammember table
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Garrett County User: Theresa Kleppinger (theresa.kleppinger@maryland.gov)
-- ef3032b3-2f5a-4b48-8b27-c33cf654abf6	
-- Update user CW role as 'CWSP'
-- Current incorrect role is 'CWDIR1KAPR'

-- Update roletypekey = CWSP (Old Values: CWDIR1KAPR)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = '9685228b-f9a4-4e9e-9805-8dcd7a4b9473'
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'CWSP',
	updatedon = now(),
	updatedby = 'CIDM-4797'
where teammemberid = '9685228b-f9a4-4e9e-9805-8dcd7a4b9473'
	and activeflag  = 1 ;	
	
-- Revert partial Placement approvals 
-- delete placementrevision
select *
	from placementrevision  
where placementrevisionid = '47fc8180-20f5-438f-8751-74d6e8533662' ;

delete from placementrevision 
where placementrevisionid = '47fc8180-20f5-438f-8751-74d6e8533662' ; 

-- Update approvaldate = null and activeflag = 1
select entrydate, exitdate, approvaldate, updatedby, updatedon, activeflag 
	from placementrevision  
where placementrevisionid = '0eaa1ab0-189e-4439-93f4-b4dc775ad6cf' ;

update placementrevision
set approvaldate = null,
	activeflag = 1,
	updatedon = now(),
	updatedby = 'CIDM-4797'
where placementrevisionid = '0eaa1ab0-189e-4439-93f4-b4dc775ad6cf' ;	
	
-- Delete all routing
select * 
	from routing 
where objectid = 'c384c27e-afcc-4884-99ed-ffafbc6090ae'
	and eventcode = 'PLTR' ;

delete from routing 
where objectid = 'c384c27e-afcc-4884-99ed-ffafbc6090ae'
	and eventcode = 'PLTR' ;

/*
-- To Revert

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('47fc8180-20f5-438f-8751-74d6e8533662', 'c384c27e-afcc-4884-99ed-ffafbc6090ae', '2022-06-10 00:00:00.000', '2022-06-05 00:00:00.000', '14:30', NULL, NULL, NULL, NULL, '', '3045', NULL, '1', '2022-06-10 11:33:06.558', 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', '2022-06-10 11:33:06.558', 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', 1, 1157776, NULL, NULL, NULL, NULL, NULL, 'Ticket completed due to not being able to place child in the system. Ticket number:S20220158041441', 0, NULL, 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', '2022-06-10 11:33:06.558', NULL, NULL, NULL, NULL, NULL, NULL, 'Review');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0ccea29f-32ee-4ee6-9a75-639701a9c516', 'PLTR', 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', '17a1b74f-0ef5-4705-ad1a-0af6928fbfc1', '745ae733-3929-438f-adb9-6cbd40157bc1', 'CWDIR1KAPR', 'CWSP', 'c384c27e-afcc-4884-99ed-ffafbc6090ae', 15, 0, 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', '2022-06-08 17:49:03.421', 'da23f52d-6348-413b-9e37-0de2ab823825', '2022-06-08 17:55:48.122', true, '', NULL, 'Provider placement submitted for review', '3229725', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('81b1c1ea-f8a6-470a-a4ce-9bdc80dfef12', 'PLTR', 'da23f52d-6348-413b-9e37-0de2ab823825', NULL, NULL, 'CWSP', 'IVESV', 'c384c27e-afcc-4884-99ed-ffafbc6090ae', 16, 1, 'da23f52d-6348-413b-9e37-0de2ab823825', '2022-06-08 17:55:48.122', 'da23f52d-6348-413b-9e37-0de2ab823825', '2022-06-08 17:55:48.122', false, NULL, NULL, NULL, '3229725', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('649b2a03-7fff-40f8-8505-4f4979e5ad57', 'PLTR', 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', '17a1b74f-0ef5-4705-ad1a-0af6928fbfc1', '745ae733-3929-438f-adb9-6cbd40157bc1', 'CWDIR1KAPR', 'CWSP', 'c384c27e-afcc-4884-99ed-ffafbc6090ae', 15, 0, 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', '2022-06-10 11:33:05.561', 'da23f52d-6348-413b-9e37-0de2ab823825', '2022-06-10 11:34:37.422', true, '', NULL, 'Placement Exit Submitted for review', '3229725', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('e0a38e89-6d32-47a7-a6c4-20da2f5e1cb5', 'PLTR', 'da23f52d-6348-413b-9e37-0de2ab823825', NULL, NULL, 'CWSP', 'IVESV', 'c384c27e-afcc-4884-99ed-ffafbc6090ae', 16, 1, 'da23f52d-6348-413b-9e37-0de2ab823825', '2022-06-10 11:34:37.422', 'da23f52d-6348-413b-9e37-0de2ab823825', '2022-06-10 11:34:37.422', false, NULL, NULL, NULL, '3229725', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
