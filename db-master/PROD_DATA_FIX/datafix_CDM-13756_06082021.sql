-- CDM-13756 - Placement validations
/*
-- Issue Description: 
   User request to remove the 3 outstanding placement validations 
   May, June & July 2012 Services 
   
   Case ID: 3155439 - 88382cc1-fc66-47be-a43c-3399445db1d1
   Client ID: 2978131 (XIJALA P	VENEY) - e96de091-d948-456b-9510-bcc01ef4b24f
   Placement ID: 271856  2012-05-01 to 2012-07-12 - 9a67cd31-ef5c-4db4-92fa-c11c52d22535
   Private Organization : 5001581 (KidsPeace National Centers of North America, Inc.)
   CPA Office: 5001585 (KidsPeace CPA - Columbia)
   Contract Program ID: 10104 (420	Xijala Veney non-tfc sibling) - 2005-11-06 to 2012-06-18 
  
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Exception scenario
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from cjams.tb_placement_validation 
where placement_validation_id in (1927974, 1927975, 1927976)
	and delete_sw  = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request; The Department is aware, and the youth placement has been paid.',
	update_ts = now(),
	update_user_id = 'CDM-13756'
where placement_validation_id in (1927974, 1927975, 1927976)
	and delete_sw = 'N' ;
