-- CDM-32735 - Incorrect Removal Date Affecting Payment
/*
-- Issue Description: 
   User reuest to change the Placement Start Date/Time and End Date/Time  

-- Case ID: 3255512
-- Client ID: 4299414 (SYMPHONY BROWN) - fbc79c87-b7a3-43ec-a90d-9f54f7da86ba
-- Provider ID: 5080867	(Ann Cox)
-- Placement ID: 1679718 - 2023-06-01 To 2023-06-06 - 934dcc34-6afd-44f0-86b8-ef2f9700877d
-- Start Date/Time - 2023-05-01 00:00:00	09:10
-- End Date/Time: 2023-05-23 00:00:00	18:00

-- Child Removal ID: 195287	- 2019-03-29 00:00:00 To 2023-06-06 09:30:00 - 3e8e60bd-2e86-47da-9f56-f38c4bbd6926
-- OOH - 2019-03-29 00:00:00 To 2023-06-06 00:00:00 - 0e3a9645-c0e2-42c1-8568-6990cf4be167

-- Category/ Module: Child Placement (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to change the Placement Start Date/Time and End Date/Time  as requested by the user.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to the Placement Start Date/Time and End Date/Time (CDM-32735) 
-- Placement ID: 1679718 - 2023-06-01 To 2023-06-06 - 934dcc34-6afd-44f0-86b8-ef2f9700877d
-- Start Date/Time - 2023-05-01 00:00:00	09:10
-- End Date/Time: 2023-05-23 00:00:00	18:00

select alternateid, startdatetime, starttime, enddatetime, endtime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '934dcc34-6afd-44f0-86b8-ef2f9700877d'
	and activeflag = 1 ;

update cjams.placement  
set startdatetime = '2023-05-01 00:00:00',
	starttime = '09:10',
	enddatetime = '2023-05-23 00:00:00', 
	endtime = '18:00', 
	updatedon = now(), 
	updatedby = 'CDM-32735'
where placementid = '934dcc34-6afd-44f0-86b8-ef2f9700877d'
	and activeflag  = 1 ;

-- Placement Revision
select entrydate, entrytime, exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '934dcc34-6afd-44f0-86b8-ef2f9700877d' 
	;
	
update cjams.placementrevision  
set entrydate =  '2023-05-01 00:00:00',
	entrytime = '09:10',
	exitdate = '2023-05-23 00:00:00',  
	exittime = '18:00',  
	updatedon = now(), 
	updatedby = 'CDM-32735'
where placementid = '934dcc34-6afd-44f0-86b8-ef2f9700877d'
	and exitdate is not null ;

update cjams.placementrevision  
set entrydate =  '2023-05-01 00:00:00',
	entrytime = '09:10',
	updatedon = now(), 
	updatedby = 'CDM-32735'
where placementid = '934dcc34-6afd-44f0-86b8-ef2f9700877d'
	and exitdate is null ;
	
-- Placement Validation	Updates ot Trigger Under/Over
select validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id
	from tb_placement_validation
where placement_validation_id = 2069772
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_start_dt = '2023-05-01',
	validation_end_dt = '2023-05-31',
	validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-32735'
where placement_validation_id = 2069772
	and delete_sw = 'N' ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 195287
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = '2023-05-23 18:00:00',
	updatedby = 'CDM-32735',
	updatedon = now()
where removalid = 195287
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '0e3a9645-c0e2-42c1-8568-6990cf4be167'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = '2023-05-23 00:00:00', 
	updatedby = 'CDM-32735',
	updatedon = now()
where personprogramid = '0e3a9645-c0e2-42c1-8568-6990cf4be167'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  195287
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = '2023-05-23',
	update_user_id = 'CDM-32735',
	update_ts = now()
where removal_id =  195287
	and delete_sw = 'N' ;
