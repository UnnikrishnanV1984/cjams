-- CDM-18811 - Placement correction
/*
-- Issue Description: 
   User request to change the placement dates
   
-- Case ID: 3306724
-- Client ID: 1692928 (KAHJ VENEY-HILTON) - e3df864b-4376-4c22-a71e-696c129233ff
-- Placements
-- Private Organization: 5000882 ( Pressley Ridge, Inc.	)
-- 1567124	2021-08-31 To Current - b4a61569-677d-4cb2-a756-1875cf156959
-- CPA Office: 5089879 (Independence Plus/Second Gen Towson)	
-- 1560827	2021-02-02 To 2021-08-31 - 53b6a6a8-20ae-45bc-9ae4-2d64646c0aba
-- CPA Office: 5089880 (Pressley Ridge)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- 1560827	2021-02-02 To 2021-08-31 - 53b6a6a8-20ae-45bc-9ae4-2d64646c0aba
-- CPA Office: 5089880 (Pressley Ridge)
-- Placement Exit date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = '53b6a6a8-20ae-45bc-9ae4-2d64646c0aba'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-18811'
where placementid = '53b6a6a8-20ae-45bc-9ae4-2d64646c0aba'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '53b6a6a8-20ae-45bc-9ae4-2d64646c0aba' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-09-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-18811'
where placementid = '53b6a6a8-20ae-45bc-9ae4-2d64646c0aba'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1560827 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-09-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-18811'
where placement_id = 1560827
	and delete_sw = 'N' ;


-- 1567124	2021-08-31 To Current - b4a61569-677d-4cb2-a756-1875cf156959
-- CPA Office: 5089879 (Independence Plus/Second Gen Towson)	
-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = 'b4a61569-677d-4cb2-a756-1875cf156959'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2021-09-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-18811'
where placementid = 'b4a61569-677d-4cb2-a756-1875cf156959'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'b4a61569-677d-4cb2-a756-1875cf156959' ;

update cjams.placementrevision  
set entrydate = '2021-09-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-18811'
where placementid = 'b4a61569-677d-4cb2-a756-1875cf156959' ;

-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1567124 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2021-09-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-18811'
where placement_id = 1567124 
	and delete_sw = 'N';
	
-- Delete
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1567124 
	and placement_validation_id = 1984423
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-18811'
where placement_id = 1567124 
	and placement_validation_id = 1984423
	and delete_sw  = 'N';
