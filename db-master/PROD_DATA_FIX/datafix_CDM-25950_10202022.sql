-- CDM-25950 - Payment Issue
/*
-- Issue Description: 
   User reuest to re-open the Child Removal / OOH   

-- Case ID: 3194021 
-- Client ID: 200150042 (Hope Ella'Sandra Chewning-Reachard) - acebd5c6-f8e7-4df0-8b6c-c1d3d5a8a2be
-- Removal ID: 251463 - 2021-01-15 To 2022-10-13 - 5c9f292d-d71f-44ce-b96d-8e14d16d08b7
-- Eligibility ID: 10001657
-- OOH: OOH	2021-01-15 To 2022-10-13 - 345f0842-022e-4d4d-8c54-f96db2cefac1
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Removal, OOH & IV-E
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 251463
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-25950',
	updatedon = now()
where removalid = 251463
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '345f0842-022e-4d4d-8c54-f96db2cefac1'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-25950',
	updatedon = now()
where personprogramid = '345f0842-022e-4d4d-8c54-f96db2cefac1'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  251463
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-25950',
	update_ts = now()
where removal_id =  251463
	and delete_sw = 'N' ;
