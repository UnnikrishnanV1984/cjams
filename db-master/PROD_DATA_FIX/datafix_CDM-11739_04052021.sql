-- CDM-11739 - Payment Issue -CDR-3130 created for PROD
/*
-- Issue Description: 
   This request is to change the placement entry date from 07/01/2020 to 7/22/2020. 
   
	Case ID: 3306724
	Client ID: 1692928 (KAHJ	VENEY-HILTON) - e3df864b-4376-4c22-a71e-696c129233ff
	Placement ID: 340931 - 2020-07-01 to 2021-02-02 - 0943fed6-16bd-47e6-88fd-0c3ccd586c23
	Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)	
	RCC Facility : 5000650 (Board of Child Care Main Campus Gaither Rd)	

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placements after exit.
		We have a User Story to fix this is our backlog.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
/*select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '0943fed6-16bd-47e6-88fd-0c3ccd586c23'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2020-07-22 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-11739'
where placementid = '0943fed6-16bd-47e6-88fd-0c3ccd586c23'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '0943fed6-16bd-47e6-88fd-0c3ccd586c23' ;

update cjams.placementrevision  
set entrydate = '2020-07-22 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-11739'
where placementid = '0943fed6-16bd-47e6-88fd-0c3ccd586c23' ;


-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 340931
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2020-07-22'::date,
	update_ts = now(),
	update_user_id = 'CDM-11739'
where placement_id = 340931
	and delete_sw = 'N' ;

-- Update July 2020
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_validation_id = 1927461
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
	set validation_status_cd = '1750',
		update_ts = now(),
		update_user_id = 'CDM-11739'
where placement_validation_id = 1927461
	and delete_sw = 'N';
*/

	