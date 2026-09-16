-- CDM-14201 - Placement end date issue
/*
-- Issue Description: 
   User request to end date the placement as of 05/10/2021
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21
   
-- Case ID: 3270272
-- Client ID: 2093796 (JEREMY TYLER KOGAN) - b5efb94b-1e12-49f1-a681-881dd654b8ec
-- Placement ID: 338406 - 2019-12-12 TO Current - 8788c0f2-da2c-4026-9ca1-0b40d25418f4
-- Private Organization: 5001352 (The National Center for Children and Families, Inc.)
-- CPA Office: 5001597 (National Center for Children and Families - Futurebound IL program)
-- Program ID: 736 (Futurebound IL) - 2006-02-01 To 2022-06-30


-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placements after exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = '8788c0f2-da2c-4026-9ca1-0b40d25418f4'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-05-10 00:00:00', 
	endtime = '12:00',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-14201'
where placementid = '8788c0f2-da2c-4026-9ca1-0b40d25418f4'
	and activeflag = 1 ;

-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 338406 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-05-10'::date,
	update_ts = now(),
	update_user_id = 'CDM-14201'
where placement_id = 338406
	and delete_sw = 'N' ;
	
