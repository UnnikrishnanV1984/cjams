-- CDM-20667 - Validation/removal
/*
-- Issue Description: 
   CJAMS is not allowing the user to complete the Placement Validations. 
   "Placement validation for this child cannot take place until 
    the child's placement is end-dated on or before the revocation date."

-- Category/ Module: Placement Validations (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Data fix to complete the Placement Validations 
select placement_id, placement_entry_dt, placement_exit_dt,  validation_start_dt, validation_end_dt,
	validation_status_cd, update_ts, update_user_id 
from tb_placement_validation 
where placement_id = 1569113
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-20667'
where placement_id = 1569113
	and delete_sw = 'N' ;
