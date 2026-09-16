-- CDM-20640 - Payment issue
/*
-- Issue Description: 
   User request to change the placement Exit Date from 8/31/2021 to 9/1/2021

-- Case ID: 3117682
-- Client ID: 1684490 (XARIEN A LYDAY) - f8dff2c8-c021-4398-bce1-1c111bde7bbd
-- Placement ID: 1561089 - 2021-02-16 To 2021-08-31 - de514a8e-6ea6-4439-8a45-418a7d2f6b9d
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5089880 (Pressley Ridge)	
-- Program: 15363 (Independence Plus) - 2007-04-16 To 2022-06-30

-- End date for Pressley Ridge should be Change to 9/1/2021 7:59 AM

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- Placement Exit date changes
-- 2021-08-31 00:00:00	09:00 (current)
-- 2021-09-01 00:00:00	07:59 (new)

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = 'de514a8e-6ea6-4439-8a45-418a7d2f6b9d'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2021-09-01 00:00:00', 
	endtime = '07:59',
	updatedon = now(), 
	updatedby = 'CDM-20640'
where placementid = 'de514a8e-6ea6-4439-8a45-418a7d2f6b9d'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby , updatedon
	from cjams.placementrevision  
where placementid = 'de514a8e-6ea6-4439-8a45-418a7d2f6b9d' 
	and exitdate is not null;

update cjams.placementrevision  
set exitdate = '2021-09-01 00:00:00', 
	exittime = '07:59',
	updatedon = now(), 
	updatedby = 'CDM-20640'
where placementid = 'de514a8e-6ea6-4439-8a45-418a7d2f6b9d' 
	and exitdate is not null;

-- Placement Validation 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1561089 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2021-09-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-20640'
where placement_id = 1561089 
	and delete_sw = 'N';
