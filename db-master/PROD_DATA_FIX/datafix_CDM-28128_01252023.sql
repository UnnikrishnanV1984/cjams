-- CDM-28128 - Old Validations
/*
-- Issue Description: 
   User request to remove the old placement validation (pre CJAMS)
   There is nothing we can do with these Wanda Nolt

-- Placement Validation IDs: 249061
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: Old Pending placement validation (pre CJAMS migrated Data) - Exception scenario
-- Fix Provided: Datafix has been promoted to remove the requested old placement validations.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from cjams.tb_placement_validation 
where placement_validation_id 
		in (249061)
	and delete_sw  = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request. Old Pending placement validation (pre CJAMS migrated Data)',
	update_ts = now(),
	update_user_id = 'CDM-20793'
where placement_validation_id 
		in (249061)
	and delete_sw = 'N' ;
