-- CDM-32092 - Remove placement validation
/*
-- Issue Description: 
   User request to delete the one outstanding placement validations.

-- Case ID: 3293542
-- Client ID: 1978323 (KAMANI RACHEL JORDAN) - bfb37274-081e-48ed-9c13-02f35d8d6300
-- Placement ID: 1600525 - 01/11/2023 To 01/31/2023 - 626fbf4c-b22e-49d7-95f8-a494cf10b689
-- Private Organization: 5001294 (King Edwards' Inc.)
-- CPA Office: 5001424 (King Edwards' Inc. ILP)
-- Placement Validation ID: 2045071 - Feb 2023

-- Category/ Module: Placement (Case Management) 
-- Root cause: Placement was retroactively exited, but one out of placement date range placement validation record was not deleted by the system (Partial transaction). 
-- Fix Provided: Datafix has been promoted to remove the requested pending Placement validations.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the pending Placement Validations (CDM-32092)
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from cjams.tb_placement_validation 
where placement_validation_id = 2045071
	and delete_sw  = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request.',
	update_ts = now(),
	update_user_id = 'CDM-32092'
where placement_validation_id = 2045071
	and delete_sw  = 'N' ;
