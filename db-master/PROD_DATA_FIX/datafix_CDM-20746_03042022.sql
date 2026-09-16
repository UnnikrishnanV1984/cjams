-- CDM-20746 - Overpayment
/*
-- Issue Description: 
   User request to change the placement Entry Date from 09/23/2021 to 12/12/2019
   
-- Case ID: 3301824
-- Client ID: 4415401 (DALLAS CORDER) - 859757ed-1542-48a7-ad49-157939c11cea
-- Placement ID: 339292	- 09/23/2021 To 02/16/2022 - 6f582706-428d-4ff8-9015-02aaed71d987
-- Provider ID: 5087346	(Sherrie B Pearson) 
-- CJAMS Finance batch has created the Account Receivables of $18,983.16
-- the placement entry date was chnaged from 12/12/2019 to 09/23/2021

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
-- 2021-09-23 00:00:00 (current)
-- 2019-12-12 00:00:00 (new)

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '6f582706-428d-4ff8-9015-02aaed71d987'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2019-12-12 00:00:00', 
	-- starttime = '10:00',
	updatedon = now(), 
	updatedby = 'CDM-20746'
where placementid = '6f582706-428d-4ff8-9015-02aaed71d987'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '6f582706-428d-4ff8-9015-02aaed71d987' 
	and entrydate::date = '2021-09-23' ;

update cjams.placementrevision  
set entrydate = '2019-12-12 00:00:00', 
	-- entrytime = '10:00',
	updatedon = now(), 
	updatedby = 'CDM-20746'
where placementid = '6f582706-428d-4ff8-9015-02aaed71d987' 
	and entrydate::date = '2021-09-23' ;

-- Placement Validation 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_validation_id 
	in (	1971992, 1968430, 1965077, 1961600, 1958094, 1954720, 1951361, 
			1947953, 1944648, 1941253, 1937587, 1934012, 1930397, 1926783,
			1923284, 945417, 943005, 939850, 936511, 933351, 933350
	   ) 
	and delete_sw = 'Y' ;		
	
Update cjams.tb_placement_validation  	
set delete_sw = 'N',
	update_ts = now(),
	update_user_id = 'CDM-20746'
where placement_validation_id 
	in (	1971992, 1968430, 1965077, 1961600, 1958094, 1954720, 1951361, 
			1947953, 1944648, 1941253, 1937587, 1934012, 1930397, 1926783,
			1923284, 945417, 943005, 939850, 936511, 933351, 933350
	   ) 
	and delete_sw = 'Y' ;		
	
-- Update Entry date & Exit Date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 339292 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2019-12-12'::date,
	placement_exit_dt = '2022-02-16'::date,
	update_ts = now(),
	update_user_id = 'CDM-20746'
where placement_id = 339292 
	and delete_sw = 'N';

