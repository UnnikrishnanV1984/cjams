-- CDM-13981 - Incorrect Placement Date
/*
-- Issue Description: 
   User request is to change the placement Exit date as 05/12/2021 (old value 04/12/2021)
   
-- Case ID: 3114700 - chiquita.polk@maryland.gov
-- Client ID: 3427132 (KEON RILEY) - ac29ad99-9f07-4c5c-bf4e-b3959baf622d
-- Placement ID: 317889 - 03/21/2017 To 04/12/2021 - e98b5660-6504-4241-b85a-026225c22f0a
-- Provider ID: 5014978	(Emma Gaines) - Local Department Home
-- New Exit Date 2021-05-12 (Old Date: 2021-04-12)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
	We have a User Story to fix this in our backlog.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = 'e98b5660-6504-4241-b85a-026225c22f0a'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-05-12 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13981'
where placementid = 'e98b5660-6504-4241-b85a-026225c22f0a'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'e98b5660-6504-4241-b85a-026225c22f0a' 
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-05-12 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13981'
where placementid = 'e98b5660-6504-4241-b85a-026225c22f0a' 
	and exitdate is not null ;


-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 317889 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-05-12'::date,
	update_ts = now(),
	update_user_id = 'CDM-13981'
where placement_id = 317889
	and delete_sw = 'N' ;
	
-- Add May 2021
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 317889, '2017-03-21', '2021-05-12', NULL, 
		NULL, 'CDM-13981', 'CDM-13981', 'N', '2021-05-01', 
		'2021-05-31', now(), now(), NULL, NULL
	);


-- Removal 
select removalid, removaldate, exitdate, returndate, returntime, returntransts, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where removalid = 183902
	and activeflag = 1
	and exitdate is not null ;


update cjams.intakeservreqchildremoval 
set exitdate = '2021-05-12 09:00:00',
	updatedby = 'CDM-13981',
	updatedon = now()
where removalid = 183902
	and activeflag = 1
	and exitdate is not null ;
	
-- OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '6fa8d7fa-7309-4159-8c01-f8bc3a4b97eb'
	and activeflag = 1 ;

update cjams.personprogramarea 
	set enddate = '2021-05-12 00:00:00', 
		updatedby = 'CDM-13981',
		updatedon = now()
where personprogramid = '6fa8d7fa-7309-4159-8c01-f8bc3a4b97eb'
	and activeflag = 1 ;
	
-- IV-E Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 158803
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = '2021-05-12',
	update_user_id = 'CDM-13981',
	update_ts = now()
where eligibility_id = 158803
	and delete_sw = 'N' ;

