-- CDM-11963 - Placement validation issue
/*
-- Issue Description: 
   User request to remove the placement validation for client #3901094 - Sept 2020 Srevice period. 
   Reason: This provider has already gotten paid for all of september.
   
   Case ID: 3278560
   Client ID: 3901094 (KHALAIA	BROWN) - 0fa74c28-f930-4284-a2ff-34037c1a0394
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: Exception scenario
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from cjams.tb_placement_validation 
where placement_validation_id = 1949524
	and delete_sw  = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request; the Provider is already paid for the month of Sept 2020.',
	update_ts = now(),
	update_user_id = 'CDM-11963'
where placement_validation_id  = 1949524
	and delete_sw = 'N' ;

