-- CDM-23782 - Payment Issue
/*
-- Issue Description: 
   User error, Datafix request to re-open the Child Removal / OOH
      
-- Case ID: 3128721
-- Client ID: 1794324 (JAZMINE AMANI RICHARDSON) - ed7a830a-a9b5-4310-a627-528e811282f5
-- Removal ID: 186862 - 2017-08-30 To 2022-05-25 - 9d0890e6-abaf-4062-9dd3-f8f2baaf07a9
-- Eligibility ID: 161248
-- OOH: 2017-08-30 To 2022-05-25 - ef62e756-607f-41a2-a54a-79e458d9012f
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open Removal, OOH & IV-E
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 186862
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-23782',
	updatedon = now()
where removalid = 186862
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'ef62e756-607f-41a2-a54a-79e458d9012f'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-23782',
	updatedon = now()
where personprogramid = 'ef62e756-607f-41a2-a54a-79e458d9012f'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  186862
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-23782',
	update_ts = now()
where removal_id =  186862
	and delete_sw = 'N' ;
