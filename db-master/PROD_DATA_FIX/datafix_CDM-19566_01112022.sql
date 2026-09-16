-- CDM-19566 - Placement Validation
/*
-- Issue Description: 
	Placement validation for this child cannot take placement
	until the child's placement is end-dated on or before the revocation date.
   
-- Case ID: 211030011741
-- Client ID: 200822885	(Ace'anthony Fussell) - cd3c645d-863d-454f-a13e-6de420b6edb4
-- Placement ID: 1568162 - 2021-10-21 To 2021-11-19 - f5f1270f-d0b2-4979-8df9-8f9d49772b40
-- Provider ID: 6002673	(Eric William Allard) - Local Department Home

-- Category/ Module: Placement validation (Case Management) 
-- Root cause: Provider's most recent Restricted Home Approval status is Revoked (2021-05-26)
--			   but there is prior approved one. Need to re-visit the Placement Validation logic. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Data fix to complete the Placement validations for Oct & Nov 2021
select placement_id, placement_entry_dt, placement_exit_dt,  validation_start_dt, validation_end_dt,
	validation_status_cd, update_ts, update_user_id 
from tb_placement_validation 
where placement_validation_id  in ( 1984346, 1981304 )
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-19566'
where placement_validation_id  in ( 1984346, 1981304 )
	and delete_sw = 'N' ;

