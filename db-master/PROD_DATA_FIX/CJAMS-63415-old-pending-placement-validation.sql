/*
-- Issue Description: 
   User request to delete the old outstanding placement validations.
    Case ID: 3143226
    Client ID: 1531447 (IKEA LEBREW)
    Provider ID: 5001376 (Challengers Teen Parent)
    Placement Validation ID: 631855
-- Category/ Module: Placement (Case Management) 
-- Root cause: User request, user confirmed that to delete the Placement validation which are Migrated from CHESSIE. 
-- Fix Provided: Datafix has been promoted to remove the requested pending Placement validations.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request, Placement validation which are Migrated from CHESSIE.',
	update_ts = now(),
	update_user_id = 'CJAMS-63415'
where placement_validation_id = '631855'
	and delete_sw  = 'N' ;