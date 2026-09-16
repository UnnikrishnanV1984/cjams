-- CDM-34530 - Closing validations
/*
-- Issue Description: 
   User request to delete pending placement validations starting Sept 2020 until Feb 2021

-- Case ID: 3284473
-- Client ID: 4172307 (JOSHUA JOHNSON) - 5138c219-7154-44b1-81b5-7fc695c0c4b2
-- Placement ID: 1561444 - 08/25/2020 To 10/07/2022 - d073905e-aee7-415f-a499-298683f06b96
-- Provider ID: 6002061	(Heidi Anne Quinto) 
-- placement validations - 6 months starting Sept 2020 until Feb 2021

-- Category/ Module: Placement (Case Management) 
-- Root cause: User has confirmed that they have paid this provider starting Sept 2020 until Feb 2021 out of the system. (Exception scenario)
-- Fix Provided: Datafix has been promoted to remove the requested pending Placement validations.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the pending Placement Validations (CDM-34530)
-- Delete 
select validation_start_dt, delete_sw, * 
	from tb_placement_validation
where placement_id = 1561444
	and placement_validation_id in (1953256, 1953257, 1953258, 1953259, 1953260, 1953261)
	and validation_status_cd is null
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request # S20230268054068.',
	update_ts = now(),
	update_user_id = 'CDM-34530'
where placement_id = 1561444
	and placement_validation_id in (1953256, 1953257, 1953258, 1953259, 1953260, 1953261)
	and validation_status_cd is null
	and delete_sw = 'N' ;

