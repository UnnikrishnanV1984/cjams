-- CDM-27360 - Removal/Placement Error
/*
-- Issue Description: 
   User reuest to re-open the Child Removal / OOH   

-- Case ID: 202104305983
-- Client ID: 200317498 (Kamari	Devone Toms) - 01aae6d8-f34c-4cfa-be47-2e06d8158886
-- Removal ID: 252447 - 2021-07-27 To 2022-11-18 - 01186b5e-c4f6-403b-b202-be88e116f091
-- OOH: 2021-07-27 To 2022-11-18 - a87ec29e-7deb-469f-8908-32d0091a345c
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been provided to re-open the Child Removal / OOH   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Removal, OOH & IV-E
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 252447
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-27360',
	updatedon = now()
where removalid = 252447
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'a87ec29e-7deb-469f-8908-32d0091a345c'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-27360',
	updatedon = now()
where personprogramid = 'a87ec29e-7deb-469f-8908-32d0091a345c'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 252447
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-27360',
	update_ts = now()
where removal_id = 252447
	and delete_sw = 'N' ;

