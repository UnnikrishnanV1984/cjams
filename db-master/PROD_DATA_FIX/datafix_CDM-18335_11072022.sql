-- CDM-18335 - Validations
/*
-- Issue Description: 
   User request to remove the old placement validation
   Reason:  It was an error and the client's Medical Assistance ended up paying 
   for his placement so we do not have to validate. 
   Can this be removed?

-- Case ID: 3253118
-- Client ID: 2195925 (ELIJAH J FROMMELT) - d06f02d2-356b-43bc-9088-9d3a88c034b9
-- Placement ID: 338483 - 2019-11-12 To 2020-07-09 - 4ffd7b47-677d-4453-a8a6-42aa42be9ce9
-- Private Organization: 5018842 (Harbor Point Behavioral Heath Center, Inc  (The Pines))
-- Residential Treatment Center: 5019126 (Harbor Point BHC)   
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: Exception scenario
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from cjams.tb_placement_validation 
where placement_validation_id = 1926508
	and delete_sw  = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request; It was an error and the client''s Medical Assistance ended up paying for his placement.',
	update_ts = now(),
	update_user_id = 'CDM-18335'
where placement_validation_id  = 1926508
	and delete_sw = 'N' ;

