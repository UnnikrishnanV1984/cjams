-- CIDM-5055 - CSES has rejected the CJAMS outbound batch # 1823 
/*
-- Issue Description: 
   CSES has rejected the CJAMS outbound batch # 1823 due to the invalid date issue.
   This client is having Placement entry date as '0222-06-22 00:00:00'
   
-- Cis Client ID: 476062841
-- Client ID: 200912540 (Skylar Kay) - 94d1e650-4344-47e7-a6b7-e03cc582f872
-- Provider ID: 5093721 (Giovanna Maria Bellas) - Local Department Home
-- Placement ID: 1572981 - 803cac34-406b-46ab-87ed-fef0cffc6bed
-- Enrty Date: 0222-06-22 00:00:00 (updated as 2022-06-22 00:00:00)

-- Category/ Module: CJAMS & CSES Interface (Interfaces) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix the Placement Entry date  
-- 0222-06-22 00:00:00 (current)
-- 2022-06-22 00:00:00 (new)

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '803cac34-406b-46ab-87ed-fef0cffc6bed'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2022-06-22 00:00:00', 
	updatedon = now(), 
	updatedby = 'CIDM-5055'
where placementid = '803cac34-406b-46ab-87ed-fef0cffc6bed'
	and activeflag = 1 ;


select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '803cac34-406b-46ab-87ed-fef0cffc6bed' 
	and entrydate is not null;

update cjams.placementrevision  
set entrydate = '2022-06-22 00:00:00', 
	updatedon = now(), 
	updatedby = 'CIDM-5055'
where placementid = '803cac34-406b-46ab-87ed-fef0cffc6bed' 
	and entrydate is not null;

	
-- Placement Validation 
-- Update and soft-delete 
select placement_validation_id, placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1572981
order by validation_start_dt desc;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2022-06-22'::date,
	update_ts = now(),
	update_user_id = 'CIDM-5055'
where placement_id = 1572981 ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-5055'
where placement_id = 1572981
	and placement_validation_id <> 2008676
	and delete_sw = 'N' ;

select placement_validation_id, placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1572981
	and delete_sw = 'N'
order by validation_start_dt desc;

