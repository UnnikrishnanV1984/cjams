-- CDM-34086 - Auto Placement Validation won't validate
/*
-- Issue Description: 
   User cannot complete the placement validations beyond clients 21st BDay - 03/20/2021

-- Case ID: 3272793
-- Client ID: 1733410 (JAZMIN PIERSON) - 490f142c-f2ed-4354-81a4-92f9a3929d6f
-- 21st Bday - 2020-11-19 00:00:00.000
-- Placement ID: 337786 - 10/18/2019 To 03/25/2021 - 8701385b-82db-47df-8276-6b3eea2daefc
-- Private Organization: 5001321 (Challengers Independent Living, Inc.)	
-- CPA Office: 5074849 (Challengers ILP (West))
-- Program ID: 2164 - Challengers Independent Living	
-- Placement Structure: Independent Living Residential Program

-- No Independent Living Residential program is only applicable for clients between 16 years and 21 years of age.
-- Dec 2020, Jan 2021 and Feb 2021

-- Category/ Module: Placement (Case Management) 
-- Root cause: Youth remained in care beyond 21 years under Independent Living Residential Program. (Exception scenario)
-- Fix Provided: Datafix has been promoted to remove the pending Placement validations beyond client's 21 birthday.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the pending Placement Validations (CDM-34086)

-- Delete 
select validation_start_dt, delete_sw, * 
	from tb_placement_validation
where placement_id = 337786
	and placement_validation_id in (1953377, 1953378, 1953379)
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request # S20230250053673.',
	update_ts = now(),
	update_user_id = 'CDM-34086'
where placement_id = 337786
	and placement_validation_id in (1953377, 1953378, 1953379)
	and delete_sw = 'N' ;

