/*
-- Issue Description: 
   Hi- there are 5 old pending placement validations that need to be deleted. The Placement Validation ID's are:2075180196647419497191949718688528Thank you! 
-- Category/ Module: Placement (Case Management) 
-- Root cause: User request, user confirmed that to delete the Placement validation which are Migrated from CHESSIE. 
-- Fix Provided: Datafix has been promoted to remove the requested pending Placement validations.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'Record is deleted with CJAMS-67753',
	update_ts = now(),
	update_user_id = 'CJAMS-67753'
where placement_validation_id in ('2075180','1966474','1949719','1949718','688528') 
	and delete_sw  = 'N' ;