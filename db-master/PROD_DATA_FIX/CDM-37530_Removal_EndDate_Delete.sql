-- CDM-37530 - Remove end date
/*
-- Category/ Module: Child Removal 
-- Root cause: User Error
-- Case# 211030011899
-- Fix Provided: Datafix has been done as requested by user to remove the Child End Date 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservreqchildremoval 
	set exitdate = null,
		returntransts= null,
		removalexitreason = null,
		updatedby ='CDM-37530',
		updatedon =now() 
	where intakeservreqchildremovalid ='588c9534-dde9-4881-9384-aac84b680a1a';
	
update personprogramarea
	set enddate = null,
		updatedby ='CDM-37530',
		updatedon =now()
	where personprogramid='8933ddeb-d52f-436a-bae2-b9dc3b2a5822';

update tb_client_eligibility
	set end_dt = null,
		update_user_id = 'CDM-37530',
		update_ts = now()
	where removal_id = '253029';

