-- CDM-23194 - Child Removal
/*
-- Issue Description: 
   User reuest to re-open the Child Removal / OOH   

-- Case ID: 3275507 - fd0a3ed9-3f1c-4e41-be7c-5c8183286551
-- Client ID: 3800975 (TERRANCE REAVES) - 3e816b52-c728-4975-95cd-ad9421f72009

-- Removal ID: 190481 - 2018-04-10 To 2021-03-04 - cafe1a48-c532-4cd8-afd4-b595f3949f94
-- Eligibility ID: 164120
-- OOH: 2018-04-10 To 2021-03-04 - 9d7e242b-cade-4e45-b823-43ec1a2a36fb
 
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
where removalid = 190481
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-23194',
	updatedon = now()
where removalid = 190481
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '9d7e242b-cade-4e45-b823-43ec1a2a36fb'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-23194',
	updatedon = now()
where personprogramid = '9d7e242b-cade-4e45-b823-43ec1a2a36fb'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  190481
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-23194',
	update_ts = now()
where removal_id =  190481
	and delete_sw = 'N' ;
