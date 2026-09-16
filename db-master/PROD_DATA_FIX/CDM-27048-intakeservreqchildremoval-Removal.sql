-- CDM-27048 -Removal
/*
   File Name: CDM-27048-intakeservreqchildremoval-Removal
-- Issue Description: 
    For the Case 3257755 In the Child Removal tab for Trentt Removal for Trentt was deleted in error and Unable to edit  
    Customer Email ID:monicia.young@maryland.gov
  
-- Resolution: Updated the exitdate, enddate to null in the intakeservreqchildremoval, tb_client_eligibility, personprogramarea  table for the  Case 3257755

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

-- 2022-11-16 09:00:00
 update
	intakeservreqchildremoval
set
	exitdate = null,
	updatedby = 'CDM-27048',
	updatedon = now()
where
	intakeservreqchildremovalid = '7970f0b9-fcf8-47a2-8fff-86367adc4f60';
	
	
-- 2022-11-16 09:00:00
 update
	tb_client_eligibility
set
	end_dt = null,
	update_user_id = 'CDM-27048',
	update_ts = now()
where
	removal_id = '253302';
	
-- 2022-11-16 09:00:00
 update
	personprogramarea
set
	enddate = null,
	updatedby = 'CDM-27048',
	updatedon = now()
where
	personprogramid = '32cea18d-c791-4ac2-90a7-4b6e7b340787';