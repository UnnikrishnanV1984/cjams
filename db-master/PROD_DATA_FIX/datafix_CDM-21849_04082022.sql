-- CDM-21849 -  Case # 3275461 Client: SHIELA SANTIAGO Placement Exit date needs to be updated
/*
-- Issue Description: 
   User request to change the placement Exit Date 
   Need to update the Exit date from 12/16/2021 08:00 AM to 12/15/2021 08:30 AM
   
-- Case ID: 3275461
-- Client ID: 4068714 (SHIELA SANTIAGO PEPLINSKI) - 2a2c089a-f4f5-422f-bb63-739ccfb429cb
-- Placement ID: 1567031 - 2021-09-01 To 2021-12-16 - 186e4372-b969-43eb-8f84-dae6774108d3
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5089879 (Independence Plus/Second Gen Towson)
-- Program ID: 15363 (Independence Plus)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: TBD
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Placement Exit date & Time changes
-- 2021-12-16 00:00:00	Entry Time 08:00 (current)
-- 2021-12-15 00:00:00	Entry Time 08:30 (new)

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '186e4372-b969-43eb-8f84-dae6774108d3'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2021-12-15 00:00:00', 
	endtime = '08:30',
	updatedon = now(), 
	updatedby = 'CDM-21849'
where placementid = '186e4372-b969-43eb-8f84-dae6774108d3'
	and activeflag = 1 ;

-- Placement Revision Exit date & time changes
select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '186e4372-b969-43eb-8f84-dae6774108d3' 
	and exitdate is not null;

update cjams.placementrevision  
set exitdate = '2021-12-15 00:00:00',
	exittime = '08:30',
	updatedon = now(), 
	updatedby = 'CDM-21849'
where placementid = '186e4372-b969-43eb-8f84-dae6774108d3' 
	and exitdate is not null;


-- Placement Validation 
select placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id  = 1567031
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set -- placement_entry_dt = '2021-09-01'::date,
	placement_exit_dt = '2021-12-15'::date,
	update_ts = now(),
	update_user_id = 'CDM-21849'
where placement_id = 1567031 
	and delete_sw = 'N';
