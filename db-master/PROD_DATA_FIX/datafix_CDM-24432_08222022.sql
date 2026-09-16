-- CDM-24432 - Validation
/*
-- Issue Description: 
   User reuest to re-open the Child Removal / OOH   

-- Case ID: 3264522
-- Client ID: 3738959 (DOUGLAS ALLEN KINGSLEY) - ff722104-5b57-48fb-8fd4-9e3806c8fe8c

-- Removal ID: 252067 - 2021-05-19 To 2022-07-22 - b8f9fc8f-b2db-4573-9c7f-9784d9a6dd1d
-- Eligibility ID: 10002423
-- OOH: 2021-05-19 To 2022-07-22 - 96fda2f2-b14d-45e6-bde8-861de6f7427c
 
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
where removalid = 252067
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-24432',
	updatedon = now()
where removalid = 252067
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '96fda2f2-b14d-45e6-bde8-861de6f7427c'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-24432',
	updatedon = now()
where personprogramid = '96fda2f2-b14d-45e6-bde8-861de6f7427c'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  252067
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-24432',
	update_ts = now()
where removal_id =  252067
	and delete_sw = 'N' ;
	
/*
Eligibility Period is Active in this case

select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id =  10002423
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set end_dt = Null,
	update_user_id = 'CDM-24432',
	update_ts = now()
where eligibility_id =  10002423
	and delete_sw = 'N' ;
*/
