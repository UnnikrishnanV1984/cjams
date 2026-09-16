-- CDM-13733 - Void Placement
/*
-- Issue Description: 
	User request to remove the placement End date so that users can Void the placement
	and make prior placement active by removing the exit date 
   
-- Void
-- Placement ID: 1562713 - 2021-04-16 To 2021-05-06 - d3e98451-1bd8-4872-8269-d80fbad8979c
-- Provider ID: 5013766	(Jacqueline Holloman)

-- Remove End Date
-- Placement ID: 1561628 - 2021-03-18 To 2021-04-16 - 5a53874c-03ed-45dc-b208-a8cd6f77cabb
-- Private Organization: 5001618 (MENTOR Maryland, Inc.)
-- CPA Office: 5001625 (MENTOR Maryland - Baltimore CPA)
-- Program ID: 1545	(Medically Complex TFC- Mentor) - 2006-07-01 To 2021-06-30
    
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to Void the Closed placements.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Void
-- Placement ID: 1562713 - 2021-04-16 To 2021-05-06 - d3e98451-1bd8-4872-8269-d80fbad8979c
-- Provider ID: 5013766	(Jacqueline Holloman)

select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = 'd3e98451-1bd8-4872-8269-d80fbad8979c'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13733'
where placementid = 'd3e98451-1bd8-4872-8269-d80fbad8979c'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'd3e98451-1bd8-4872-8269-d80fbad8979c' 
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13733'
where placementid = 'd3e98451-1bd8-4872-8269-d80fbad8979c' 
	and ( exitdate is not null or exittime is not null ) ;
	
-- Remove End Date
-- Placement ID: 1561628 - 2021-03-18 To 2021-04-16 - 5a53874c-03ed-45dc-b208-a8cd6f77cabb

select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '5a53874c-03ed-45dc-b208-a8cd6f77cabb'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13733'
where placementid = '5a53874c-03ed-45dc-b208-a8cd6f77cabb'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '5a53874c-03ed-45dc-b208-a8cd6f77cabb' 
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13733'
where placementid = '5a53874c-03ed-45dc-b208-a8cd6f77cabb' 
	and ( exitdate is not null or exittime is not null ) ;
	
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1561628 
	and delete_sw  = 'N';
	

Update tb_placement_validation 
set placement_exit_dt = null,
	update_ts = now(),
	update_user_id = 'CDM-13733'
where placement_id = 1561628
	and delete_sw = 'N' ;	

-- Datafix to Insert May 2021 Placement Validation 
insert into cjams.tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1561628, '2021-03-18', NULL, NULL, 
		NULL, 'CDM-13733', 'CDM-13733', 'N', '2021-05-01', 
		'2021-05-31', now(), now(), NULL, NULL
	);


