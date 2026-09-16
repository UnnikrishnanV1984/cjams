

-- CDM-24391 - Remove end date
/*
-- Issue Description: 
   User reuest to re-open the Child Removal / OOH  (12/23/2021 end date) 

-- Case ID: 211030008831 - 4576b416-3a68-4b3e-85ba-3a16e803c9db
-- Removal ID: 252224 - 2021-11-27 To 2021-12-23 - 7cc24b91-9695-4a1a-8a04-a052463eb81f
-- Eligibility ID: 10004090
-- OOH: 2021-11-27 To 2021-12-23 - fd2341cb-acf6-4aa0-ac00-d254ba58d804
 
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
where removalid = 252224
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-24391',
	updatedon = now()
where removalid = 252224
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '193c5572-383a-451e-a27c-8eef27a75080'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-24391',
	updatedon = now()
where personprogramid = '193c5572-383a-451e-a27c-8eef27a75080'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  252224
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-24391',
	update_ts = now()
where removal_id =  252224
	and delete_sw = 'N' ;

