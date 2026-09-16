-- CDM-33478 - Validation
/*
-- Issue Description: 
   User cannot complete the placement validations beyond clients 21st BDay - 03/20/2021

-- Case ID: 3114662
-- Client ID: 1495011 (CAPREE L JONES) - a753c5d1-bea9-45de-88dc-03b0fd1612cd
-- Placement ID: 323926 - 2018-01-12 2021-09-30 - bc115245-478b-4eb1-9354-fc93765f59d0
-- Private Organization: 5001294 (King Edwards' Inc.)
-- CPA Office: 5001424 (King Edwards' Inc. ILP)
-- Program ID: 1274	(Ind Liv Pgm King Edwards House, Inc.) 
-- Placement Structure: Independent Living Residential Program   

-- Category/ Module: Placement (Case Management) 
-- Root cause: Youth remained in care beyond 21 due to extended foster care. 
-- Exception scenario: Youth is 21 and was allowed to remain in care beyond 21 due to Pandemic.
-- Fix Provided: Datafix has been promoted to remove the pending Placement validations beyond client's 21 birthday.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the pending Placement Validations (CDM-33478)

-- Delete 
select validation_start_dt, delete_sw, * 
	from tb_placement_validation
where placement_id = 323926
	and placement_validation_id in ( 2015708, 2015709, 2015710, 2015711, 2015712 ,2015713)
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request # S20230216053017.',
	update_ts = now(),
	update_user_id = 'CDM-33478'
where placement_id = 323926
	and placement_validation_id in ( 2015708, 2015709, 2015710, 2015711, 2015712 ,2015713)
	and delete_sw = 'N' ;

