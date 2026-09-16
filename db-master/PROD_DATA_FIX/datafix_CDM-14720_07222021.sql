-- CDM-14720 - Incorrect Placement Date
/*
-- Issue Description: 
   This request is to change the placement entry date as 06/03/2021 (Current date 06/04/2021). 
   
-- Case ID: 211030008530
-- Client ID: 200673400	(Rickey	Jeffrey	Myles) - 8640d24b-e31b-4915-b2e2-1701a6fb0c4b
-- Placement ID: 1563685 - 2021-06-04 To 2021-06-07 - ec935fb7-82f1-4baa-aacc-c68791d41dc3
-- Private Organization: 5001262 (Good Children in the Making, Inc.)
-- CPA Office: 5001645(Good Children in the Making - Family Services TFC)
-- Program: 1765 (Good Children in the Making Family Services TF) - 2006-11-13 To 2022-06-30 

-- Removal ID: 252166 - Start Date: 2021-06-03 To Current
	
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
where placementid = 'ec935fb7-82f1-4baa-aacc-c68791d41dc3'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2021-06-03 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14720'
where placementid = 'ec935fb7-82f1-4baa-aacc-c68791d41dc3'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'ec935fb7-82f1-4baa-aacc-c68791d41dc3' ;

update cjams.placementrevision  
set entrydate = '2021-06-03 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14720'
where placementid = 'ec935fb7-82f1-4baa-aacc-c68791d41dc3' ;

-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1563685 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2021-06-03'::date,
	update_ts = now(),
	update_user_id = 'CDM-14720'
where placement_id = 1563685 
	and delete_sw = 'N';
	
