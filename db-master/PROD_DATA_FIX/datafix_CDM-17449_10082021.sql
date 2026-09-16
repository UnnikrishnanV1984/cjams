-- CDM-17449 - Placement Validation
/*
-- Issue Description: 
   User request to remove pending placement validation 
   
   Exception scenario FC Client turned 21 on 07/10/2021 
   System is not allowing the user to complete the validation for Aug 2021
   as the Structure  is "Independent Living" applicable for clients between 16 years and 21 years of age.
      
-- Case id: 3212217
-- Client ID: 3360612 (MARIYAH INELL PLATER) - a9f4b3d6-e0de-4d6f-a974-53327b5259e0
-- Placement ID: 338669 - 2019-12-30 To 2021-09-20 - 7bc31dcf-8e56-4929-a28b-674b81236d28
-- Private Organization: 5001321 (Challengers Independent Living, Inc.)
-- CPA Office: 5074849 - Challengers ILP (West)
-- Program: 2164 (Challengers Independent Living) - 2007-01-17 To 2022-06-30
-- Placement Validation ID: 1974380 for August 2021	
	
-- Category/ Module: Placement Validations (Case Management) 
-- Root cause: User request for Exception scenario.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw, comment_tx 
from cjams.tb_placement_validation 
where placement_validation_id = 1974380
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request, Aged-out for this placement.',
	update_ts = now(),
	update_user_id = 'CDM-17449'
where placement_validation_id = 1974380
	and delete_sw = 'N';
