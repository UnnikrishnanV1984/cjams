-- CDM-15797 - Payment Issue
/*
-- Issue Description: 
   User request to change the placement Exit date as 04/01/2021  (old value 04/14/2021)

-- Case ID: 3300620
-- CLient ID: 200010966	(Addison Fowler) -4582ff4b-163f-4b9b-95ff-f5809586c04e
-- Placement ID: 1561103 - 2020-10-14 To 2021-04-14 - cef467b5-ee1b-40bc-8ff0-d9d92221ed69
-- Private Organization: 5000543 (Associated Catholic Charities Inc.)
-- RCC Facility: 5000545 (Associated Catholic Charities St Vincents Child Care Center)
-- Program: 1249 (Diagnostic-St. Vincent Child Care Center) - 2006-07-01 To 2021-03-31
-- Exit date change  2021-04-14 --> 2021-04-01

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = 'cef467b5-ee1b-40bc-8ff0-d9d92221ed69'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-04-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15797'
where placementid = 'cef467b5-ee1b-40bc-8ff0-d9d92221ed69'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'cef467b5-ee1b-40bc-8ff0-d9d92221ed69' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-04-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15797'
where placementid = 'cef467b5-ee1b-40bc-8ff0-d9d92221ed69'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1561103 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-04-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-15797'
where placement_id = 1561103
	and delete_sw = 'N' ;

-- Delete
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1561103 
	and placement_validation_id = 1959228
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-15797'
where placement_id = 1561103 
	and placement_validation_id = 1959228
	and delete_sw  = 'N';

