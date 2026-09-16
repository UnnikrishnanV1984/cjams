-- CDM-11372 - Change the end date of placement
/*
-- Issue Description: 
   This request is to change the end date of the placement from 09/16/2020 to 11/01/2020. 
   
   Case ID: 3079925
   Client ID: 3300805 (IVY ANITA NICO DUNGEE) - 57c3b7ef-594d-41e1-b34e-c5343fa4523d
   Placement ID: 1558763 - 2018-09-20 to 2020-09-16  (New date 2020-11-01)
   Provider ID: 5090580	(Tyrone Tyler) 
    
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placements after exit.
		We have a User Story to fix this is our backlog.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement End date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '0bd3a8c2-f449-497a-ae86-3792565373b5'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2020-11-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-11372'
where placementid = '0bd3a8c2-f449-497a-ae86-3792565373b5'
	and activeflag = 1 ;

-- Placement Revision End date changes
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '0bd3a8c2-f449-497a-ae86-3792565373b5'
	and exitdate is not null ;


update cjams.placementrevision  
set exitdate = '2020-11-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-11372'
where placementid = '0bd3a8c2-f449-497a-ae86-3792565373b5'
	and exitdate is not null ;


-- Placement Validations 
-- Update Exit date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1558763
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_exit_dt = '2020-11-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-11372'
where placement_id = 1558763
	and delete_sw = 'N' ;

-- Update Sept & Oct 2020
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_validation_id  in ( 1939028, 1939027 )
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
	set validation_status_cd = '1750',
		update_ts = now(),
		update_user_id = 'CDM-11372'
where placement_validation_id  in ( 1939028, 1939027 )
	and delete_sw = 'N' ;


-- Removal End date changes
select removaldate, exitdate , returndate, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where intakeservreqchildremovalid = '6c9e06a8-1f0e-4c7b-9323-bf1dc582b610'
	and activeflag = 1 ;

update cjams.intakeservreqchildremoval
set exitdate = '2020-11-01 10:00:00',
	updatedby = 'CDM-11372',
	updatedon = now()
where intakeservreqchildremovalid = '6c9e06a8-1f0e-4c7b-9323-bf1dc582b610'
	and activeflag = 1 ;


-- OOH End date changes
select personid, programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid  ='14216da5-6a89-4085-ae12-ea4be84fba40'
	and activeflag = 1 ;

update cjams.personprogramarea
set enddate = '2020-11-01 00:00:00',
	updatedby = 'CDM-11372',
	updatedon = now()
where personprogramid  ='14216da5-6a89-4085-ae12-ea4be84fba40'
	and activeflag = 1 ;
	
-- Eligibility End date changes
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 165640
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
	set end_dt = '2020-11-01'::date,
		update_user_id = 'CDM-11372',
		update_ts = now()
where eligibility_id = 165640
	and delete_sw = 'N' ;
	
select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id = 165640
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
	set end_dt = '2020-11-01'::date,
		update_user_id = 'CDM-11372',
		update_ts = now()
where eligibility_id = 165640
	and delete_sw = 'N' ;
	