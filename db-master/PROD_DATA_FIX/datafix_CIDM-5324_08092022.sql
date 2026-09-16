-- CIDM-5324 - E&E has Rejected the CJAMS out bound Batch for INVALID TRANSACTION_DATE error
/*
-- Issue Description: 
   E&E has rejected the CJAMS outbound batch # 303 due to the invalid date issue.
   This client is having Placement entry date as '0222-07-20 00:00:00'
   
-- Cis Client ID: 460038606
-- Client ID: 2495774 (DYLAN SAMUEL	EDWARDS) - 924b56f7-c23b-4531-ad5d-2b76f7fe5719
-- Provider ID: 6002933	(KEVIN WESLIE WRIGHT) - Local Department Home
-- Placement ID: 1573877 - 9e0f82c4-5088-4fd1-8e96-2feaa0ae1abc
-- Enrty Date: 0222-07-20 00:00:00 (updated as 2022-07-20 00:00:00)

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
where placementid = '9e0f82c4-5088-4fd1-8e96-2feaa0ae1abc'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2022-07-20 00:00:00', 
	updatedon = now(), 
	updatedby = 'CIDM-5324'
where placementid = '9e0f82c4-5088-4fd1-8e96-2feaa0ae1abc'
	and activeflag = 1 ;


select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '9e0f82c4-5088-4fd1-8e96-2feaa0ae1abc' 
	and entrydate is not null;

update cjams.placementrevision  
set entrydate = '2022-07-20 00:00:00', 
	updatedon = now(), 
	updatedby = 'CIDM-5324'
where placementid = '9e0f82c4-5088-4fd1-8e96-2feaa0ae1abc' 
	and entrydate is not null;

	
-- Placement Validation 
-- Update and soft-delete 
select placement_validation_id, placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1573877
order by validation_start_dt desc;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2022-07-20'::date,
	update_ts = now(),
	update_user_id = 'CIDM-5324'
where placement_id = 1573877 ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-5324'
where placement_id = 1573877
	and placement_validation_id <> 2012378
	and delete_sw = 'N' ;

select placement_validation_id, placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1573877
	and delete_sw = 'N'
order by validation_start_dt desc;

