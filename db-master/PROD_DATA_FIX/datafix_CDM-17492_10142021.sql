-- CDM-17492 - Placement Validations
/*
-- Issue Description: 
   User request to remove pending placement validation for youths beyond age 21 
   
-- Category/ Module: Placement Validations (Case Management) 
-- Root cause: Exception scenarios
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case ID: 3216194
-- Client ID: 2586017 (FAITH HARMONY DESNOYER) - 7846293d-0fb2-49f9-afda-1fb7fd4f8a00
-- 21st Birthday 2021-07-06
-- Placement ID: 1556929 - 2020-08-03 To 2021-09-30 - d89befbe-cabc-42d9-992f-3a7b39d7fd38
-- Private Organization: 5011680 (Umbrella Therapeutic Services, Inc.)
-- CPA Office: 5066444 (Umbrella Therapeutic Services, Inc. ILP Baltimore)
-- Program: 1883 (Independant Living Prog.- Umbrella Therapeutic Sv) - 2006-07-01 To 2022-06-30
-- Placement Structure: Independent Living Residential Program
-- Delete placement_validation_id 1977595 & 1977596

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw, comment_tx 
from cjams.tb_placement_validation 
where placement_validation_id in ( 1977595, 1977596 ) 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request, Aged-out for this placement.',
	update_ts = now(),
	update_user_id = 'CDM-17492'
where placement_validation_id in ( 1977595, 1977596 ) 
	and delete_sw = 'N';

-- Case ID: 3281761
-- Client ID: 1642952 (TONY	MENDELL	GLASS) - b81d3923-a340-4229-ac5b-8bd1ee7e9f35
-- 21st Birthday 2021-04-09
-- Placement ID: 1561836 - 2021-03-01 To 2021-09-30 - ae575d19-5edd-4870-9e9a-718e568ffa54
-- Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)
-- RCC Facility: 5001412 (Board of Child Care Rolling Road)
-- Program: 50002323 (Rolling Road -Group Home) - 2020-07-01 To 2022-06-30
-- Placement Structure: Therapeutic Group Homes
-- Delete placement_validation_id 1977594

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw, comment_tx 
from cjams.tb_placement_validation 
where placement_validation_id = 1977594
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request, Aged-out for this placement.',
	update_ts = now(),
	update_user_id = 'CDM-17492'
where placement_validation_id = 1977594
	and delete_sw = 'N';