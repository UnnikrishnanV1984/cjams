-- CDM-16308 - unable to validate placement
/*
-- Issue Description: 
   User unable to validate placement 
   it has been stated that there is nothing wrong with the license dates.

   Datafix to end date the placement as of 06/01/2021
   Exception scenario: CPA Office site 5091998 is not a part of Program # 15364 

-- Case ID: 3297334
-- Client ID: 1483083 (KELLY WOOZLEY) - c7003c50-f20e-493e-9951-a24fa120a004
-- Placement ID: 1562936 - 2021-04-06 To Current - 3306bc20-5ae8-4757-a2a4-b2be362af0f7
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5091998 (Pressley Ridge - Second Generations ILP Greenbelt)
-- Modified name (Pressley Ridge)
-- Program: 15364 (Second Generations TMP-IL) - 2007-04-16 To 2022-06-30
   
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placements after exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Exit 
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = '3306bc20-5ae8-4757-a2a4-b2be362af0f7'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-06-01 00:00:00', 
	endtime = '10:00',
	exitreasontypekey = NULL,
	exittypekey = 'CIPS',
	updatedon = now(), 
	updatedby = 'CDM-16308'
where placementid = '3306bc20-5ae8-4757-a2a4-b2be362af0f7'
	and activeflag = 1 ;

INSERT INTO cjams.placementrevision
(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
	exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
	approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
	updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
	voidremarks, enddate, endtime, exittypekey, remarks, 
	isvoided, voiddate, requestedby, requesteddate, approvedby, 
	approveddate, etl_userid, etl_load_date, ischangepreadoptive, status
)
VALUES
(	gen_random_uuid(), '3306bc20-5ae8-4757-a2a4-b2be362af0f7', current_date, '2021-04-06 00:00:00', '08:00', 
	'2021-06-01 00:00:00', '10:00', NULL, NULL, '', 
	'3047', current_date, NULL, now(), 'CDM-16308', 
	now(), 'CDM-16308', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'CIPS', 'correcting placement', 
	0, now(), 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', now(), 'c442053f-fe02-42f9-b05c-3054c3738f24', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = '3306bc20-5ae8-4757-a2a4-b2be362af0f7'
	and placementrevisionid = '4189ed5a-76db-40c1-9f38-a318a58d822f' 
	and activeflag = 1;

update placementrevision
set activeflag = 0,
	status =  'Approved',
	approvedby = 'c442053f-fe02-42f9-b05c-3054c3738f24',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-16308'	
where placementid  = '3306bc20-5ae8-4757-a2a4-b2be362af0f7'
	and placementrevisionid = '4189ed5a-76db-40c1-9f38-a318a58d822f' 
	and activeflag = 1;

-- Update routing
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', 'c442053f-fe02-42f9-b05c-3054c3738f24', 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', 
		'1c28acd6-9ef9-4b46-9ab3-a3dfc386bacd', 'CWSP', 'CWCW', '3306bc20-5ae8-4757-a2a4-b2be362af0f7', 16, 1, 
		'CDM-16308', now(), 'CDM-16308', now(), true, 
		'', NULL, 'Child Placement Approved', '3297334', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = '3306bc20-5ae8-4757-a2a4-b2be362af0f7'
	and routingid = '00894bbb-cf86-4e2e-91ce-6834e977c87b'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-16308'	
where objectid = '3306bc20-5ae8-4757-a2a4-b2be362af0f7'
	and routingid = '00894bbb-cf86-4e2e-91ce-6834e977c87b'
	and activeflag = 1 ;

-- No CPA Homes

-- Delete Placement Validations
select placement_validation_id, validation_start_dt, validation_end_dt, 
		delete_sw, update_ts, update_user_id 
	from tb_placement_validation
where placement_id  = 1562936
	and ( placement_validation_id  in (1976594, 1973212, 1969765, 1966559)
			or  validation_status_cd is null
		 )	
	and delete_sw  = 'N' ;

update tb_placement_validation
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16308'
where placement_id  = 1562936
	and ( placement_validation_id  in (1976594, 1973212, 1969765, 1966559)
			or  validation_status_cd is null
		 )	
	and delete_sw  = 'N' ;
