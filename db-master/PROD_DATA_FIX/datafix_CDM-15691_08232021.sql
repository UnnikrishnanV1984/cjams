-- CDM-15691 - Old Placement Validations
/*
-- Issue Description: 
   Three pending placement validations from 2015 and 2017 period.
   
-- Placement Validation ID: 828043
-- Placement ID: 322345 - 10/27/2017 To 10/27/2017 
-- Case ID: 3281936
-- Client ID: 4058182 (BABY BOY KRAUSE) - 331ea54a-b78d-4dc1-a9e2-2539753b31bb
-- Provider ID: 5073109	(Laura Grach) 

-- Placement Validation ID: 704972
-- Placement ID: 302130 - 04/21/2015 To 04/21/2015 
-- Case ID: 3253536
-- Client ID: 2490446 (KAROLINE	LEANN ROSE BENTON) - 845df8b4-44f2-4f85-9bce-1d72af023a5a
-- Provider ID: 5032745	(Vickie Noe)

-- Placement Validation ID: 704970
-- Placement ID: 302128 - 04/21/2015 To	04/21/2015
-- Case ID: 3253535
-- Client ID: 1260955 (KIMBERLY	D ROSS) - 9a336acd-bd75-4caa-8f23-9fe231b9d1bf
-- Provider ID: 5032745	(Vickie Noe) 

-- Category/ Module: Placement (Case Management) 
-- Root cause: Exception scenario
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the pending Placement Validations
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from cjams.tb_placement_validation 
where placement_validation_id  in (828043, 704972, 704970)
	and delete_sw  = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as the Placement Entry and Exit dates are the same. (Payment is not applicable).',
	update_ts = now(),
	update_user_id = 'CDM-15691'
where placement_validation_id  in (828043, 704972, 704970)
	and delete_sw  = 'N' ;

