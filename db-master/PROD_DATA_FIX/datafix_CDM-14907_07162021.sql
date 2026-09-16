-- CDM-14907 - Deandre Rose
/*
-- Issue Description: 
   User request to update placement exit date & revert void the below placement
   
   User Wrongly VOIDed a placement instead of end date/exit placement on 05/10/2021.
   He was at Evesham location 01/26/2021 - 05/10/2021
   
   Need to revert VOID and updated this placement as a exit placement with date 5/10/2021.
   
-- Case ID: 3283870 - arabia.lewis@maryland.gov
-- Client ID: 4182258 (DEANDRE ROSE) - 2d5b932f-0f9c-4870-a80b-d6ee85e363fa
-- Placement ID: 1560453 -2021-01-26 To 2021-05-25 - Voided - f46fc78d-f270-4418-a820-b363bd9fbd1f
-- Private Organization: 5001391 (Jumoke, Inc.)
-- RCC Facility: 5001460 (Jumoke, Inc. Eveshem)
-- Program ID: 50002303	(Group Home/ Eversham) - 2021-07-01 To 2022-06-30


-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify or void the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Datafix to change the placement Exit date as 2021-05-10 (old value 2021-06-09)
-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon, 
	isvoided, voidapprovaldate, voidapprovalstatustypekey, voiddate, voidreasontypekey 
from placement 
where placementid = 'f46fc78d-f270-4418-a820-b363bd9fbd1f'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-05-10 00:00:00', 
	exitreasontypekey = NULL, 
	exittypekey = 'CIP', 
	isvoided = 0, 
	voidapprovaldate = now(), 
	voidapprovalstatustypekey = NULL, 
	voiddate = NULL, 
	voidreasontypekey = NULL, 
	updatedon = now(), 
	updatedby = 'CDM-14907'
where placementid = 'f46fc78d-f270-4418-a820-b363bd9fbd1f'
	and activeflag = 1 ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1560453 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-05-10'::date,
	update_ts = now(),
	update_user_id = 'CDM-14907'
where placement_id = 1560453
	and delete_sw = 'N' ;

select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_validation_id  = 1959057
	and delete_sw  = 'Y';

Update tb_placement_validation 
set delete_sw = 'N',
	placement_exit_dt = '2021-05-10'::date,
	update_ts = now(),
	update_user_id = 'CDM-14907'
where placement_validation_id  = 1959057
	and delete_sw  = 'Y';
