-- CDM-19124 - Person is not on Nina's caseload
/*
-- Issue Description: 
   User request to remove pending placement validations from the Closed case
   Youth beyond age 21 exception scenario.
   
-- Case ID: 3266238 - 937cae88-48c9-422d-b780-561a7a57a28c
-- Client ID: 1671382 (VICTORIA	ASIKAGBON) - c447ec08-3279-4875-8599-47b48cfeed1b
-- 21st Bday - 08/10/2021
-- Placement ID: 329890 - 2018-08-09 To 2021-09-29 - ea063416-12a4-4d12-8780-f00726610c49
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5089880 (Pressley Ridge)
-- Program: 15363 (Independence Plus) - 2007-04-16 To 2022-06-30	
-- Placement Structure: Independent Living Residential Program


-- Category/ Module: Placement Validations (Case Management) 
-- Root cause: Exception scenarios
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw, comment_tx 
from cjams.tb_placement_validation 
where placement_validation_id = 1977597
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request, Aged-out for this placement.',
	update_ts = now(),
	update_user_id = 'CDM-19124'
where placement_validation_id = 1977597
	and delete_sw = 'N';
