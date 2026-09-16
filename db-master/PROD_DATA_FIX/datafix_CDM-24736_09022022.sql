-- CDM-24736 - Remove End date
/*
-- Issue Description: 
   User reuest to re-open the Child Removal / OOH   

-- Case ID: 3244485
-- Client ID: 4195537 (MELANIA M MORGERETH) - e6225368-97f4-4d57-91a2-808bcd2a0899
-- Removal ID: 189287 - 2018-02-15 To 2022-06-29 - 3d087046-0da5-4b54-a9a8-dc77c1a1949f
-- Eligibility ID: 163148
-- OOH: 2018-02-15 To 2022-06-29 - 98283a81-7f6a-41e1-9c02-db6c19f0a62c
 
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
where removalid = 189287
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-24736',
	updatedon = now()
where removalid = 189287
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '98283a81-7f6a-41e1-9c02-db6c19f0a62c'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-24736',
	updatedon = now()
where personprogramid = '98283a81-7f6a-41e1-9c02-db6c19f0a62c'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  189287
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-24736',
	update_ts = now()
where removal_id =  189287
	and delete_sw = 'N' ;
	
-- Eligibility Period is Active in this case
select start_dt, end_dt, update_ts, update_user_id
	from cjams.tb_eligibility_period
where eligibility_id =  163148
	and eligibility_period_id = 920159
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set end_dt = Null,
	update_user_id = 'CDM-24736',
	update_ts = now()
where eligibility_id =  163148
	and eligibility_period_id = 920159
	and delete_sw = 'N' ;
