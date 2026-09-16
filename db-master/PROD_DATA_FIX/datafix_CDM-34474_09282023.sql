-- CDM-34474 - Rejected Placement Occupying Bed
/*
-- Issue Description: 
   User request to end date the Child Placement as of 9/23/2022 11-59 AM
   Client is having 2 active Placements (one with placement revision in rejected status)

-- Case ID: 3281229
-- Client ID: 4133488 (LEYAH RIVERA) - 676a19f8-117a-4237-b86c-798414b3ffd9
-- Placement ID: 1561979 - 2021-03-01 To current - b4276540-b48d-4916-b2d3-046be6cbf1b3
-- Private Organization: 5001682 (Center for Social Change, Inc)
-- Providre ID: 5086224	(Center for Social Change Lucerne Rd DDA) - RCC Facility
-- Program ID: 50002330	(DD-Children's Program/Lucerne Rd)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data issue, Client is having 2 active Placements (one with placement revision in rejected status)
-- Fix Provided: Datafix has been promoted to exit the Child Placement and update the provider vacancy.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Exit 
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = 'b4276540-b48d-4916-b2d3-046be6cbf1b3'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2022-09-23 00:00:00', 
	endtime = '11:59',
	exitreasontypekey = 'CIPNHC', -- Child Issue: Needs have changed
	exittypekey = 'CIP', --	Change in Placement
	updatedon = now(), 
	updatedby = 'CDM-34474'
where placementid = 'b4276540-b48d-4916-b2d3-046be6cbf1b3'
	and activeflag = 1 ;
	
	
select approvalstatustypkey, status, approveddate, approvaldate, entrydate, entrytime, exitdate, exittime, 
	exitreasontypkey, exittypekey, activeflag, updatedby, updatedon	
from placementrevision 
where placementid  = 'b4276540-b48d-4916-b2d3-046be6cbf1b3'
	and placementrevisionid = 'dc649919-a5c8-4fc5-961a-ac56341b32ba'
	--and activeflag = 0
	; 

update placementrevision
set entrydate = '2021-03-01 00:00:00.000',
	entrytime = '10:00',
	exitdate = '2022-09-23 00:00:00',
	exittime = '11:59',
	exitreasontypkey = 'CIPNHC', -- Child Issue: Needs have changed
	exittypekey = 'CIP', --	Change in Placement
	-- activeflag = 0,
	status =  'Approved',
	approvedby = 'c237f718-5ab0-491d-8e01-f243c90493b4', -- imecka.jones@maryland.gov
	approveddate = now(),
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-34474'	
where placementid  = 'b4276540-b48d-4916-b2d3-046be6cbf1b3'
	and placementrevisionid = 'dc649919-a5c8-4fc5-961a-ac56341b32ba'
	--and activeflag = 0
	; 

select approvalstatustypkey, status, approveddate, approvaldate, entrydate, entrytime, exitdate, exittime, 
	exitreasontypkey, exittypekey, activeflag, updatedby, updatedon	
from placementrevision 
where placementid  = 'b4276540-b48d-4916-b2d3-046be6cbf1b3'
	and placementrevisionid = '9b432ff2-a917-441d-96ea-84ce9a302517'
	and activeflag = 1
	; 

update placementrevision
set entrydate = '2021-03-01 00:00:00.000',
	entrytime = '10:00',
	exitdate = '2022-09-23 00:00:00',
	exittime = '11:59',
	exitreasontypkey = 'CIPNHC', -- Child Issue: Needs have changed
	exittypekey = 'CIP', --	Change in Placement
	-- activeflag = 1,
	approvalstatustypkey = '3047', -- Approved
	status =  'Approved',
	approvedby = 'c237f718-5ab0-491d-8e01-f243c90493b4', -- imecka.jones@maryland.gov
	approveddate = now(),
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-34474'	
where placementid  = 'b4276540-b48d-4916-b2d3-046be6cbf1b3'
	and placementrevisionid = '9b432ff2-a917-441d-96ea-84ce9a302517'
	and activeflag = 1
	; 

-- Update routing
-- Delete Rejected 
select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from cjams.routing
where routingid = 'fb3abc14-0fd5-4448-acb2-37be5aad0c8f' 
	and activeflag = 1 ;

update cjams.routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-34474'	
where routingid = 'fb3abc14-0fd5-4448-acb2-37be5aad0c8f' 
	and activeflag = 1 ;

-- Add 	Approved
-- Sup: Imecka Jones
-- Wrk: Juliana Davis
Delete from cjams.routing where insertedby = 'CDM-34474' ;

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', 'c237f718-5ab0-491d-8e01-f243c90493b4', '5de4ddee-e525-414a-a2bc-0b7b431a6d71', 
		'03c8b237-00c0-4df5-b223-15b08240a510', 'CWSP', 'CWCW', 'b4276540-b48d-4916-b2d3-046be6cbf1b3', 16, 1, 
		'CDM-34474', now(), 'CDM-34474', now(), true, 
		'', NULL, 'Child Placement Approved', '3281229', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

-- for IV-E
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', 'c237f718-5ab0-491d-8e01-f243c90493b4', NULL, 
		NULL, 'CWSP', 'IVESV', 'b4276540-b48d-4916-b2d3-046be6cbf1b3', 16, 1, 
		'CDM-34474', now(), 'CDM-34474', now(), false, 
		'', NULL, 'Child Placement Approved', '3281229', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

	
-- No CPA Homes

-- Delete Placement validation
select placement_validation_id, placement_entry_dt, placement_exit_dt, 
	validation_start_dt, validation_end_dt, delete_sw, update_ts, update_user_id
from tb_placement_validation 
where placement_id  = 1561979
	and delete_sw = 'N' ;

update tb_placement_validation 
set placement_exit_dt = '2022-09-23'::date,
	update_ts = now(),
	update_user_id = 'CDM-34474'	
where placement_id  = 1561979
	and delete_sw = 'N' ;

select placement_validation_id, placement_entry_dt, placement_exit_dt, 
	validation_start_dt, validation_end_dt, delete_sw, update_ts, update_user_id
from tb_placement_validation 
where placement_id  = 1561979
	and delete_sw = 'N'
	and validation_start_dt::date >= '2022-10-01'::date
order by validation_start_dt desc ;

update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id ='CDM-34474'	
where placement_id  = 1561979
	and delete_sw = 'N'
	and validation_start_dt::date >= '2022-10-01'::date ;

-- Update vacancy
select cp.program_id, 
	cp.program_nm, 
	cp.contract_beds_no, 
	(select count(*) 
		from placement pl
	 where pl.contractprogramid = cp.program_id
		and pl.activeflag = 1
		and pl.startdatetime is not null
		and pl.enddatetime is null
		and coalesce(pl.isvoided, 0) <> 1	
		and (
				( select count(*)
					from routing ro
				  where ro.objectid = pl.placementid::character varying
					and ro.eventcode = 'PLTR'
					and ro.routingstatustypeid = 16
					and ro.activeflag = 1
				) > 0	
				or 
				( select count(*)
					from routing ro
				  where ro.objectid = pl.placementid::character varying
					and ro.eventcode = 'PLTR'
					and ro.routingstatustypeid = 15
					and ro.activeflag = 1
				) > 0	
			)
	) as active_placements,
	cp.vacancy_no
from prov.tb_contract_program cp
where cp.program_id = 50002330 
	and cp.delete_sw = 'N' ;
	
update prov.tb_contract_program cp
set vacancy_no = ( cp.contract_beds_no
					- 
					(select count(*) 
						from placement pl
					 where pl.contractprogramid = cp.program_id
						and pl.activeflag = 1
						and pl.startdatetime is not null
						and pl.enddatetime is null
						and coalesce(pl.isvoided, 0) <> 1	
						and (
								( select count(*)
									from routing ro
								  where ro.objectid = pl.placementid::character varying
									and ro.eventcode = 'PLTR'
									and ro.routingstatustypeid = 16
									and ro.activeflag = 1
								) > 0	
								or 
								( select count(*)
									from routing ro
								  where ro.objectid = pl.placementid::character varying
									and ro.eventcode = 'PLTR'
									and ro.routingstatustypeid = 15
									and ro.activeflag = 1
								) > 0	
							)
					)
				),	
	update_user_id = 'CDM-34474',
	update_ts = now()	
where program_id = 50002330 
	and delete_sw = 'N' ;
	
