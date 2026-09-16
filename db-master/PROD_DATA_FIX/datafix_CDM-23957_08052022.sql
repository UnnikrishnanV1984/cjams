-- CDM-23957 - Remove end date
/*
-- Issue Description: 
   User reuest to re-open the Child Removal / (06/15/2022 end date) 

-- Case ID: 3308002 
-- Client ID: 4495272 - (BRIANNA GROSS) - 1109cf99-bd0e-435a-ab12-3dcb104b068d
-- Removal ID: 251076 - 1c4437cb-8ed1-4970-89b2-df341c9c6442
-- Eligibility ID: 10001207
-- OOH: 2020-10-14 - 2022-06-15 - c4fdb7a6-c838-4600-b736-19a35893d893
 
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
where removalid = 251076
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-23957',
	updatedon = now()
where removalid = 251076
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'c4fdb7a6-c838-4600-b736-19a35893d893'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-23957',
	updatedon = now()
where personprogramid = 'c4fdb7a6-c838-4600-b736-19a35893d893'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id ,*
	from cjams.tb_client_eligibility
where removal_id =  251076
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-23957',
	update_ts = now()
where removal_id =  251076
	and delete_sw = 'N' ;