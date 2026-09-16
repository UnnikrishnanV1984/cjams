-- CDM-18859 - Validations
/*
-- Issue Description: 
   User request to remove pending placement validations from the Closed case
   Youth beyond age 21 exception scenario.
   
-- Case ID: 3120551
-- Client ID: 1705667 (QUINIJAH	WILKINS) - 5fc7f0c1-e88f-478f-88cc-a81edecf77d1
-- Placement ID: 1564120 - 2021-06-25 To 2021-06-25 - de074d24-9def-41e6-b4ed-eb662166d900
-- Private Organization: 5001294 (King Edwards' Inc.)
-- CPA Office: 5001424 (King Edwards' Inc. ILP)
-- Program: 1274 (Ind Liv Pgm King Edwards House, Inc.) - 2006-07-01 To 2022-06-30

-- Category/ Module: Placement Validations (Case Management) 
-- Root cause: Exception scenarios
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw, comment_tx 
from cjams.tb_placement_validation 
where placement_validation_id in ( 1974364, 1970775 ) 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request, Aged-out for this placement.',
	update_ts = now(),
	update_user_id = 'CDM-18859'
where placement_validation_id in ( 1974364, 1970775 ) 
	and delete_sw = 'N';
