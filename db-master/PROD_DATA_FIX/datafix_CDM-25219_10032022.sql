-- CDM-25219 - Adoption (S20220263044147)
/*
-- Issue Description: 
   User reuest to re-open the Child Removal / OOH   

-- Case ID: 3205946
-- Client ID: 3787988 (KAI'RON JADEN SANDERS) - 4f5ea99e-7e3b-424e-b7f1-d96a0f68d5e3
-- Removal ID: 188964 - 2018-01-26 To 2022-08-17 - b18882b1-bb99-45f3-9754-3c7671f994bc
-- Eligibility ID: 162908
-- OOH: 2018-01-26 to 2022-08-17 - 471d69f8-ec2a-4def-befc-bc5941d4ce21
 
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
where removalid = 188964
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-25219',
	updatedon = now()
where removalid = 188964
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '471d69f8-ec2a-4def-befc-bc5941d4ce21'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-25219',
	updatedon = now()
where personprogramid = '471d69f8-ec2a-4def-befc-bc5941d4ce21'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  188964
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-25219',
	update_ts = now()
where removal_id =  188964
	and delete_sw = 'N' ;
	
-- Eligibility Period is Active in this case
