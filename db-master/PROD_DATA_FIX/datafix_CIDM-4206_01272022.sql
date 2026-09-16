-- CIDM-4206 - FAILED: CJAMS Interface Batch job
/*
-- Issue Description: 
   Datafix to Remove the GAP Suspension with Start Date as NULL
   
-- Case ID: 3074919
-- Client ID: 2234235 (TIYONA D	MCDOWELL) - 2041cb19-ad4e-4b44-b00e-a9cb0e9a190f
-- GAP ID: 1005587 - 2020-12-21 To 2028-08-23 - f91cc89f-6a3e-4464-b858-37e0613a10c1
-- Provider ID: 5013879	(Regina Harris) - Baltimore County

-- Category/ Module: GAP (Case Management) 
-- Root cause: Date Issue (GAP Suspension Start Date as NULL) 
--			   Veera is looking int the core issue, has to be with the latest GAP story changes	 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- routing
-- Delete - 21c2f6d1-1aaf-4ff0-9a87-f22e076a48fc & 52a9c743-f545-4185-b1a5-f26030c71503
-- Make active f86aa528-ceb1-4e4b-9f8d-158ba13c1deb
select objectid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where routingid  
	in (	'21c2f6d1-1aaf-4ff0-9a87-f22e076a48fc', 
			'52a9c743-f545-4185-b1a5-f26030c71503' 
		) 
	and eventcode  = 'GASR'
	and servicerequestnumber  = 3074919 ;

delete from routing 
where routingid  
	in (	'21c2f6d1-1aaf-4ff0-9a87-f22e076a48fc', 
			'52a9c743-f545-4185-b1a5-f26030c71503' 
		) 
	and eventcode  = 'GASR'
	and servicerequestnumber  = 3074919 ;

select objectid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where routingid = 'f86aa528-ceb1-4e4b-9f8d-158ba13c1deb'
	and eventcode  = 'GASR'
	and servicerequestnumber  = 3074919 ;

update routing
set activeflag = 1,
	updatedon = now(), 
	updatedby = 'CIDM-4206'	
where routingid = 'f86aa528-ceb1-4e4b-9f8d-158ba13c1deb'
	and eventcode  = 'GASR'
	and servicerequestnumber  = 3074919 ;

-- gapsuspensionrevision
-- Make Active 420ce79b-b28c-44ed-b818-28376b4d33cb
select gapsuspensionrevisionid, startdate, enddate, activeflag, updatedby, updatedon 
	from cjams.gapsuspensionrevision  
where gapsuspensionrevisionid = '420ce79b-b28c-44ed-b818-28376b4d33cb' ;

update cjams.gapsuspensionrevision  
set activeflag = 1,
	updatedon = now(), 
	updatedby = 'CIDM-4206'
where gapsuspensionrevisionid = '420ce79b-b28c-44ed-b818-28376b4d33cb' ;

-- gapsuspension
-- Delete 4c28cc74-6fb5-40c0-adff-fb138f271246 
-- Make Active 75818329-6074-4056-b4ed-872ae00bfd9b
select gapid, gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
    from cjams.gapsuspension 
where gapsuspensionid = '4c28cc74-6fb5-40c0-adff-fb138f271246' ;

delete from cjams.gapsuspension  
where gapsuspensionid = '4c28cc74-6fb5-40c0-adff-fb138f271246' ;
	
select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
    from cjams.gapsuspension 
where gapsuspensionid = '75818329-6074-4056-b4ed-872ae00bfd9b'	
	and activeflag  = 1 ;

update cjams.gapsuspension  
set activeflag = 1,
	updatedon = now(), 
	updatedby = 'CIDM-4206'
where gapsuspensionid = '75818329-6074-4056-b4ed-872ae00bfd9b'	
	and activeflag  = 1 ;	
			
/*
-- To revert if needed
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('4c28cc74-6fb5-40c0-adff-fb138f271246'::uuid, 'f91cc89f-6a3e-4464-b858-37e0613a10c1'::uuid, 'COHP', NULL, NULL, 'System generated suspension', 0, 'Suspended due to active removal (system generated)', 1, '2022-01-01 00:00:00.000', '6e1b68eb-feb2-4077-b536-e2e4d40abea2', '2022-01-26 17:02:03.486', '6e1b68eb-feb2-4077-b536-e2e4d40abea2', '2022-01-26 17:02:03.486', NULL, NULL, 1002224, '3047', NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('21c2f6d1-1aaf-4ff0-9a87-f22e076a48fc'::uuid, 'GASR', '69372c02-ea74-4ef9-a67d-c5bbe53277b2', '4103969d-6c19-4065-8d86-fa7706680634', 'f7c2b0f5-87ae-442a-b7d6-018d5c7cde99'::uuid, 'CWCW', 'CWSP', '4c28cc74-6fb5-40c0-adff-fb138f271246', 16, 1, '4103969d-6c19-4065-8d86-fa7706680634', '2022-01-26 17:02:03.486', '4103969d-6c19-4065-8d86-fa7706680634', '2022-01-26 17:02:03.486', true, 'GAP Suspension Approved', NULL, 'GAP Suspension Approved', '3074919', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('52a9c743-f545-4185-b1a5-f26030c71503'::uuid, 'GASR', '4103969d-6c19-4065-8d86-fa7706680634', '69372c02-ea74-4ef9-a67d-c5bbe53277b2', 'f7c2b0f5-87ae-442a-b7d6-018d5c7cde99'::uuid, 'CWSP', 'CWCW', '75818329-6074-4056-b4ed-872ae00bfd9b', 16, 0, '4103969d-6c19-4065-8d86-fa7706680634', '2022-01-26 17:02:03.486', '4103969d-6c19-4065-8d86-fa7706680634', '2022-01-26 17:02:03.486', true, '', NULL, 'Guardianship Suspension Submitted for review', '3074919', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/