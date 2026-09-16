-- CIDM-6139 - E&E has Rejected the CJAMS out bound Batch for INVALID TRANSACTION_DATE error
/*
-- Issue Description: 
   E&E has rejected the CJAMS outbound batch # 378 due to the invalid date issue.
   -- Case ID: 3222680
-- Client ID: 3506034 (NASIR D SUDLER) - b1e436f8-8015-447d-99de-e087eacd31a6
-- Placement ID: 1578337 - 0222-11-07 TO Current - 26a582b3-80e1-43ff-b68a-06465dd7cde0

-- Enrty Date: 0222-11-07 00:00:00 (updated as 2022-11-07 00:00:00)

-- Category/ Module: CJAMS & E&E Interface (Interfaces) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix the Placement Entry date  

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '26a582b3-80e1-43ff-b68a-06465dd7cde0'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2022-11-07 00:00:00', 
	updatedon = now(), 
	updatedby = 'CIDM-6139'
where placementid = '26a582b3-80e1-43ff-b68a-06465dd7cde0'
	and activeflag = 1 ;

select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '26a582b3-80e1-43ff-b68a-06465dd7cde0' 
	and entrydate is not null;

update cjams.placementrevision  
set entrydate = '2022-11-07 00:00:00', 
	updatedon = now(), 
	updatedby = 'CIDM-6139'
where placementid = '26a582b3-80e1-43ff-b68a-06465dd7cde0' 
	and entrydate is not null;

	
-- Placement Validation 
-- Update and soft-delete 
select placement_validation_id, placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1578337
order by validation_start_dt desc;

/*
Update cjams.tb_placement_validation 
set placement_entry_dt = '2022-11-07'::date,
	update_ts = now(),
	update_user_id = 'CIDM-6139'
where placement_id = 1578337 ;
*/

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-6139'
where placement_id = 1578337
	and delete_sw = 'N' ;

select placement_validation_id, placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1578337
	and delete_sw = 'N'
order by validation_start_dt desc;
