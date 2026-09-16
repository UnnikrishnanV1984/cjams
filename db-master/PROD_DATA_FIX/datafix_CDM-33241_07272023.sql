-- CDM-33241 - Removal of Child
/*
-- Issue Description: 
   User reuest to re-open Child Removal / OOH   

-- Case ID: 3278713
-- Client ID: 1580958 (KHADIJA A SPENCE) - b98faa92-9164-419c-b5c8-fc07082ccad1
-- Removal ID: 185818 - 2017-07-03 To 2023-06-08 - 3591e117-5b09-44f0-9513-bbed05a4e8f7
-- OOH - 2017-07-03 To 2023-06-08 - 44480b89-536f-485b-a383-66c0bfce768b

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to re-open the Child Removal / OOH   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Child Removal, OOH & IV-E (CDM-33241)
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 185818
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set exitdate = Null, -- 2023-06-08 08:45:00	
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL, -- EMANIND
	updatedby = 'CDM-33241',
	updatedon = now()
where removalid = 185818
	and activeflag = 1;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '44480b89-536f-485b-a383-66c0bfce768b'
	and activeflag = 1;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-33241',
	updatedon = now()
where personprogramid = '44480b89-536f-485b-a383-66c0bfce768b'
	and activeflag = 1;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 185818
	and delete_sw = 'N';

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-33241',
	update_ts = now()
where removal_id = 185818
	and delete_sw = 'N'
	and end_dt is not null ;

