-- CDM-12563 - change in placement structure
/*
-- Issue Description: 
   This request is to change the placement entry date & exit dates of 2 clients. 
   
	Case ID: 3259144 - tyann.mckay@maryland.gov
	Client ID: 4264493 (KANE STERN) - f59f9297-20ce-4487-9050-db5eb0ab2dd5
	Placements
	1562549	67325caf-5c06-4960-8c04-db7aa804f9ab		2021-04-01 to Current	
	1560921	8f0686df-be37-4428-b669-f218834c5ff3		2021-02-19 to 2021-04-01 

	Client ID: 4264492 (ABEL	STERN) - a1e7f272-1557-4b2e-b63a-e103694b92c3
	Placements
	1562550	04b776ff-bf28-4e8d-8a49-ddd049567185		2021-04-01 to Current	
	1560922	fb563076-78c2-4f7f-b479-7085ed6003ea		2021-02-19 to 2021-04-01 
	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Entry date changes - 04/01/2021 to 03/05/2021
-- Client ID: 4264493 (KANE STERN) - f59f9297-20ce-4487-9050-db5eb0ab2dd5
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '67325caf-5c06-4960-8c04-db7aa804f9ab'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2021-03-05 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12563'
where placementid = '67325caf-5c06-4960-8c04-db7aa804f9ab'
	and activeflag = 1 ;

select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from cjams.placementrevision  
where placementid = '67325caf-5c06-4960-8c04-db7aa804f9ab' ;

update cjams.placementrevision  
set entrydate = '2021-03-05 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12563'
where placementid = '67325caf-5c06-4960-8c04-db7aa804f9ab' ;

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '8f0686df-be37-4428-b669-f218834c5ff3'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2021-03-05 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12563'
where placementid = '8f0686df-be37-4428-b669-f218834c5ff3'
	and activeflag = 1 ;

select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '8f0686df-be37-4428-b669-f218834c5ff3'
and exitdate is not null ;

update cjams.placementrevision  
set exitdate = '2021-03-05 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12563'
where placementid = '8f0686df-be37-4428-b669-f218834c5ff3' 
and exitdate is not null ;


-- Client ID: 4264492 (ABEL	STERN) - a1e7f272-1557-4b2e-b63a-e103694b92c3
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '04b776ff-bf28-4e8d-8a49-ddd049567185'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2021-03-05 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12563'
where placementid = '04b776ff-bf28-4e8d-8a49-ddd049567185'
	and activeflag = 1 ;

select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from cjams.placementrevision  
where placementid = '04b776ff-bf28-4e8d-8a49-ddd049567185' ;

update cjams.placementrevision  
set entrydate = '2021-03-05 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12563'
where placementid = '04b776ff-bf28-4e8d-8a49-ddd049567185' ;

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = 'fb563076-78c2-4f7f-b479-7085ed6003ea'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2021-03-05 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12563'
where placementid = 'fb563076-78c2-4f7f-b479-7085ed6003ea'
	and activeflag = 1 ;

select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'fb563076-78c2-4f7f-b479-7085ed6003ea'
and exitdate is not null ;

update cjams.placementrevision  
set exitdate = '2021-03-05 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12563'
where placementid = 'fb563076-78c2-4f7f-b479-7085ed6003ea' 
and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id IN ( 1560922, 1560921)  ;

Update cjams.tb_placement_validation 
set placement_exit_dt = '2021-03-05'::date,
	update_ts = now(),
	update_user_id = 'CDM-12563'
where placement_id IN ( 1560922, 1560921) ;

insert into cjams.tb_placement_validation
(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
	comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, 
	create_ts, update_ts, etl_userid, etl_load_date
)
values
(	nextval('sq_placement_validation'::regclass), 1562550, '2021-03-05', NULL, '1750', 
	NULL, 'CDM-12563', 'CDM-12563', 'N', '2021-03-01', '2021-03-31', 
	now(), now(), NULL, NULL
);

insert into cjams.tb_placement_validation
(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
	comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, 
	create_ts, update_ts, etl_userid, etl_load_date
)
values
(	nextval('sq_placement_validation'::regclass), 1562549, '2021-03-05', NULL, '1750', 
	NULL, 'CDM-12563', 'CDM-12563', 'N', '2021-03-01', '2021-03-31', 
	now(), now(), NULL, NULL
);

