-- CDM-14209 - Incorrect placement end date
/*
-- Issue Description: 
   User request is to change the placement Entry & Exit dates as 
   11/30/2020 and 12/01/2020 (old values 11/28/2020 To 01/30/2020)
   
-- Case ID: 202100705243
-- Client ID: 4129897 (TYLIHN I GAINEY) - ae86d2ec-f175-4137-b35b-511d2b5b2f1f 
-- Placement ID: 1560079 - 2020-11-28 To 2020-01-30 - ceb6571e-8c09-404b-a3fb-0245565f43bd
-- Provider ID: 5086052	(Cora Melvin) -	Local Department Home
-- New Entry Date 11/30/2020 and Exit Date to 12/01/2020

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = 'ceb6571e-8c09-404b-a3fb-0245565f43bd'
	and activeflag  = 1 ;

update placement  
set startdatetime = '2020-11-30 00:00:00',
	enddatetime = '2020-12-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14209'
where placementid = 'ceb6571e-8c09-404b-a3fb-0245565f43bd'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'ceb6571e-8c09-404b-a3fb-0245565f43bd' ;

update placementrevision  
set entrytime = '2020-11-30 00:00:00',
	exitdate = '2020-12-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14209'
where placementid = 'ceb6571e-8c09-404b-a3fb-0245565f43bd' ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1560079 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_entry_dt = '2020-11-30'::date,
	placement_exit_dt = '2020-12-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-14209'
where placement_id = 1560079
	and delete_sw = 'N' ;
	
-- Delete December 2020 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_validation_id = 1946201 
	and delete_sw  = 'N';
 
update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-14209'
where placement_validation_id = 1946201 
	and delete_sw  = 'N';
	
-- Removal 
select removalid, removaldate, exitdate, returndate, returntime, returntransts, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where removalid = 251403
	and activeflag = 1
	and exitdate is not null ;

update cjams.intakeservreqchildremoval 
set exitdate = '2020-12-01 20:28:16',
	updatedby = 'CDM-14209',
	updatedon = now()
where removalid = 251403
	and activeflag = 1
	and exitdate is not null ;
	
-- IV-E Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 10001590
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = '2020-12-01',
	update_user_id = 'CDM-14209',
	update_ts = now()
where eligibility_id = 10001590
	and delete_sw = 'N' ;

