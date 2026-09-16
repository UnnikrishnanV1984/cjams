-- CDM-31072 - Validations
/*
-- Issue Description: 
   Client aged out on May 23, 2020, but he did not leave care until September 30, 2021 due to COVID.   
   User request to delete the outstanding placement validations.

-- Case ID: 3113322
-- Client ID: 1653413 (CASEY SHARP) - 574c3a61-09ec-4c2b-b061-dd8745f13300
-- Placement ID: 324941 - 2018-02-21 To 2021-09-30 - 50eed5e0-b0bf-43b8-9992-3b75afb4a6a2
-- Private Organization: 5000744 (The Children's Guild, Inc.)
-- CPA Office: 5001641 (Children's Guild TFC)
-- Prgram ID: 1711 (Children's Guild TFC)

-- Category/ Module: Placement (Case Management) 
-- Root cause: Exception scenario due to the pandemic. 
-- Fix Provided: Datafix has been promoted to remove the requested pending Placement validations.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the pending Placement Validations
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from cjams.tb_placement_validation 
where placement_validation_id  in ( 1981324, 1981323, 1981322, 1981321 )
	and delete_sw  = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request, Client was aged-out but did not leave care due to pandemic.',
	update_ts = now(),
	update_user_id = 'CDM-31072'
where placement_validation_id  in ( 1981324, 1981323, 1981322, 1981321 )
	and delete_sw  = 'N' ;
