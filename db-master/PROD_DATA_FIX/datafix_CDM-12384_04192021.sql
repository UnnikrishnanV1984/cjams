-- CDM-12384 - placement date needed
/*
-- Issue Description: 
   This request is to change the placement entry date from 01/18/2018 to 01/17/2018. 
   
	Case ID: 3237646
	Client ID: 4041221 (GAVIN LEE GROSS) - 15507c12-536d-4e03-bc05-cfb23ded293c
	Placement ID: 1560522 - 2018-01-18 to 2021-01-08 - 8d959036-00be-4bae-b145-1cb605b5f49d
	Provider ID: 5040688 (Karen Larimer)
	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '8d959036-00be-4bae-b145-1cb605b5f49d'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2018-01-17 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12384'
where placementid = '8d959036-00be-4bae-b145-1cb605b5f49d'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '8d959036-00be-4bae-b145-1cb605b5f49d' ;

update cjams.placementrevision  
set entrydate = '2018-01-17 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12384'
where placementid = '8d959036-00be-4bae-b145-1cb605b5f49d' ;

-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1560522 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2018-01-17'::date,
	update_ts = now(),
	update_user_id = 'CDM-12384'
where placement_id = 1560522 
	and delete_sw = 'N';
	
-- Update Jan 2018
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_validation_id = 1949467
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
	set validation_status_cd = '1750',
		update_ts = now(),
		update_user_id = 'CDM-12384'
where placement_validation_id = 1949467
	and delete_sw = 'N';

