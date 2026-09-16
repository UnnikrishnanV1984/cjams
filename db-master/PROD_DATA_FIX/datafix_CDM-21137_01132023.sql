-- CDM-21137 - Placement Validation Error
/*
-- Issue Description: 
   User request to end date the Child Placement as of December 31, 2020 (12/31/2020)
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21

-- Case ID: 3227522
-- Client ID: 3535647 (RICO SINGLETON) - 74f3abbc-5df8-442f-8683-60ad0159c52a
-- Placement ID: 1559330 - 2020-10-07 To Open - 561fa7f3-6eec-4eb3-a4a6-f10b6ba8c97a
-- Private Organization: 5044481 (Carerite T.F.C., Inc.)
-- CPA Office: 6000405 (CareRite T.F.C., Inc. Greenbelt)
-- Program ID: 16127 (Independant Living-CareRite)
-- Placement Structure: Independent Living Residential Program

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Exception scenario: Youth is 21 and was allowed to remain in care beyond 21 due to the pandemic situation
-- Fix Provided: Datafix has been promoted to exit the Child Placement as of 12/31/2020
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Exit 
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = '561fa7f3-6eec-4eb3-a4a6-f10b6ba8c97a'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-12-31 00:00:00', 
	endtime = '11:59',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-21137'
where placementid = '561fa7f3-6eec-4eb3-a4a6-f10b6ba8c97a'
	and activeflag = 1 ;
	
-- wrk: b3503705-5dab-4f41-b564-15e933c7b902	jeannette.mcneil@maryland.gov
-- Sup: ce7fdbdd-2bdd-4e81-a440-8963a8279f71	vijaya.persaud@maryland.gov
-- Team: 95c02657-cd0c-436a-b09c-d47ab0da4006
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
(	gen_random_uuid(), '561fa7f3-6eec-4eb3-a4a6-f10b6ba8c97a', current_date, '2020-10-07 00:00:00', '15:00', 
	'2020-12-31 00:00:00', '11:59', NULL, NULL, '', 
	'3047', current_date, NULL, now(), 'CDM-21137', 
	now(), 'CDM-21137', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'PLCC', 'moving to fup apartment', 
	0, now(), 'ce7fdbdd-2bdd-4e81-a440-8963a8279f71', now(), 'b3503705-5dab-4f41-b564-15e933c7b902', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, entrydate, entrytime, exitdate, exittime, 
	exitreasontypkey, exittypekey, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = '561fa7f3-6eec-4eb3-a4a6-f10b6ba8c97a'
	and placementrevisionid = 'b5f1c033-b750-48c1-a8a6-1f6675852cad'
	and activeflag = 1;


update placementrevision
set entrydate = '2020-10-07 00:00:00',
	exitdate = '2020-12-31 00:00:00',
	exittime = '11:59',
	exitreasontypkey = NULL,
	exittypekey = 'CIPS',
	activeflag = 0,
	status =  'Approved',
	approvedby = 'ce7fdbdd-2bdd-4e81-a440-8963a8279f71',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-21137'	
where placementid  = '561fa7f3-6eec-4eb3-a4a6-f10b6ba8c97a'
	and placementrevisionid = 'b5f1c033-b750-48c1-a8a6-1f6675852cad' 
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
	(	gen_random_uuid(), 'PLTR', 'b3503705-5dab-4f41-b564-15e933c7b902', 'ce7fdbdd-2bdd-4e81-a440-8963a8279f71', 
		'95c02657-cd0c-436a-b09c-d47ab0da4006', 'CWSP', 'CWCW', '561fa7f3-6eec-4eb3-a4a6-f10b6ba8c97a', 16, 1, 
		'CDM-21137', now(), 'CDM-21137', now(), true, 
		'', NULL, 'Child Placement Approved', '3227522', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = '561fa7f3-6eec-4eb3-a4a6-f10b6ba8c97a'
	and routingid = 'c4ca9c7d-b26d-454e-a552-b129bc2ff383'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-21137'		
where objectid = '561fa7f3-6eec-4eb3-a4a6-f10b6ba8c97a'
	and routingid = 'c4ca9c7d-b26d-454e-a552-b129bc2ff383'
	and activeflag = 1 ;
	
-- No CPA Homes

-- Delete Placement validation
select placement_validation_id, placement_entry_dt, placement_exit_dt, 
	validation_start_dt, validation_end_dt, delete_sw, update_ts, update_user_id
from tb_placement_validation 
where placement_id  = 1559330
	and delete_sw = 'N' ;

update tb_placement_validation 
set placement_exit_dt = '2020-12-31'::date,
	update_ts = now(),
	update_user_id ='CDM-21137'	
where placement_id  = 1559330
	and delete_sw = 'N' ;

select placement_validation_id, placement_entry_dt, placement_exit_dt, 
	validation_start_dt, validation_end_dt, delete_sw, update_ts, update_user_id
from tb_placement_validation 
where placement_id  = 1559330
	and delete_sw = 'N'
	and validation_start_dt::date >= '2020-12-01'::date
order by validation_start_dt desc ;

update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id ='CDM-21137'	
where placement_id  = 1559330
	and delete_sw = 'N'
	and validation_start_dt::date >= '2020-12-01'::date ;
