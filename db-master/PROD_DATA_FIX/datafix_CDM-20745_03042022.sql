-- CDM-20745 - Overpayment
/*
-- Issue Description: 
   User request to change the placement Entry Date from 05/18/2021 to 12/06/2019
   
-- Case ID: 3126196
-- Client ID: 4282057 (MITHRAS Apollo VEGA) - 7a148b3-e647-4dda-a385-1a8518347cd7
-- Provider ID: 5093828	(Tamara Dt O'laughlin) 
-- Placement ID: 338503	- 05/18/2021 To 02/16/2022 - 10452bf4-661d-4f2e-bd70-d0f7354bd540
-- CJAMS Finance batch has created the Account Receivables of $15,425.64 
-- the placement entry date was changed from 12/06/2019 to 05/18/2021

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
-- 2021-05-18 00:00:00 (current)
-- 2019-12-06 00:00:00 (new)

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '10452bf4-661d-4f2e-bd70-d0f7354bd540'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2019-12-06 00:00:00', 
	-- starttime = '10:00',
	updatedon = now(), 
	updatedby = 'CDM-20745'
where placementid = '10452bf4-661d-4f2e-bd70-d0f7354bd540'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '10452bf4-661d-4f2e-bd70-d0f7354bd540' 
	and entrydate::date = '2021-05-18' ;

update cjams.placementrevision  
set entrydate = '2019-12-06 00:00:00', 
	-- entrytime = '10:00',
	updatedon = now(), 
	updatedby = 'CDM-20745'
where placementid = '10452bf4-661d-4f2e-bd70-d0f7354bd540' 
	and entrydate::date = '2021-05-18' ;

-- Placement Validation 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_validation_id 
	in (	1957977, 1954597, 1951211, 1947796, 1944473,
			1941067, 1937384, 1933788, 1930152, 1926513,
			1923062, 945206, 942696, 939454, 936032, 932776, 929579
	   ) 
	and delete_sw = 'Y' ;		
	
Update cjams.tb_placement_validation  	
set delete_sw = 'N',
	update_ts = now(),
	update_user_id = 'CDM-20745'
where placement_validation_id 
	in (	1957977, 1954597, 1951211, 1947796, 1944473,
			1941067, 1937384, 1933788, 1930152, 1926513,
			1923062, 945206, 942696, 939454, 936032, 932776, 929579
	   ) 
	and delete_sw = 'Y' ;		
	
-- Update Entry date & Exit Date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 338503 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2019-12-06'::date,
	placement_exit_dt = '2022-02-16'::date,
	update_ts = now(),
	update_user_id = 'CDM-20745'
where placement_id = 338503 
	and delete_sw = 'N';
