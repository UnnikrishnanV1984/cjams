-- CDM-23976 - Correct the placement date
/*
-- Issue Description: 
   User request to change the placement Dates

-- Case ID: 3289655
-- Client ID: 4253855 (DENIM WILKINS) - 2a38d9f2-13ea-4a16-ae2a-8f49e3829478

-- Provider ID: 6003027 (Tamara Scott) - Local Department Home
-- Placement ID: 1571736 - 2021-10-22 To 2022-05-04 - 4a4b32c8-8bf1-46f3-adba-cd8f64610c9b
-- Update Start date as 05/04/2022 & fix placement validations 

-- Private Organization: 5001618 (MENTOR Maryland, Inc.)	
-- CPA Office: 5001625 (MENTOR Maryland - Baltimore CPA)
-- Placement ID: 329130 - 2018-08-06 To 2021-10-22 - aba679a4-e9d4-459c-a4fd-fd5a59515bab	
-- Program: 1545 (Medically Complex TFC- Mentor)
-- Update End date as 05/04/2022 & fix placement validations 

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement ID: 1571736 - 2021-10-22 To 2022-05-04 - 4a4b32c8-8bf1-46f3-adba-cd8f64610c9b
-- update Placement Start date as 2022-05-04
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '4a4b32c8-8bf1-46f3-adba-cd8f64610c9b'
	and activeflag = 1 ;

update cjams.placement  
set startdatetime = '2022-05-04 00:00:00', 
	-- starttime = '09:15',
	updatedon = now(), 
	updatedby = 'CDM-23976'
where placementid = '4a4b32c8-8bf1-46f3-adba-cd8f64610c9b'
	and activeflag = 1 ;

-- Placement Revision Exit date & time changes
select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '4a4b32c8-8bf1-46f3-adba-cd8f64610c9b' ;

update cjams.placementrevision  
set entrydate = '2022-05-04 00:00:00',
	-- entrytime = '09:15',
	updatedon = now(), 
	updatedby = 'CDM-23976'
where placementid = '4a4b32c8-8bf1-46f3-adba-cd8f64610c9b'  ;

-- Placement Validation 
select placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id  = 1571736
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2022-05-04'::date,
	-- placement_exit_dt = '2022-05-04'::date,
	update_ts = now(),
	update_user_id = 'CDM-23976'
where placement_id = 1571736 
	and placement_validation_id = 2004842
	and delete_sw = 'N';
	
select placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id  = 1571736
	and placement_validation_id <> 2004842
	and delete_sw = 'N' ;	

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-23976'
where placement_id = 1571736 
	and placement_validation_id <> 2004842
	and delete_sw = 'N' ;	

-- Placement ID: 329130 - 2018-08-06 To 2021-10-22 - aba679a4-e9d4-459c-a4fd-fd5a59515bab	
-- Update End date as 2022-05-04

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = 'aba679a4-e9d4-459c-a4fd-fd5a59515bab'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2022-05-04 00:00:00', 
	-- endtime = '09:00',
	updatedon = now(), 
	updatedby = 'CDM-23976'
where placementid = 'aba679a4-e9d4-459c-a4fd-fd5a59515bab'
	and activeflag = 1 ;

-- Placement Revision Exit date & time changes
select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'aba679a4-e9d4-459c-a4fd-fd5a59515bab' 
	and exitdate is not null;

update cjams.placementrevision  
set exitdate = '2022-05-04 00:00:00',
	-- exittime = '09:00',
	updatedon = now(), 
	updatedby = 'CDM-23976'
where placementid = 'aba679a4-e9d4-459c-a4fd-fd5a59515bab' 
	and exitdate is not null;


select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = '036a6dfd-0df2-481e-b070-cffe9019d08e'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2022-05-04 00:00:00',
	exittm = '2022-05-04 09:00:00',
	-- exittypecd = NULL,
	-- exitreasoncd = NULL,
	updatets = now(),
	updateuserid = 'CDM-23976'
where placementcpahomeid = '036a6dfd-0df2-481e-b070-cffe9019d08e'
	and activeflag = 1 ;
	
-- Placement Validation 
select placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id  = 329130
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set -- placement_entry_dt = '2018-08-06'::date,
	placement_exit_dt = '2022-05-04'::date,
	update_ts = now(),
	update_user_id = 'CDM-23976'
where placement_id = 329130 
	and delete_sw = 'N';