-- CDM-23488- Placement/payment issue
/*
   File Name: CDM-23488-intakeservreqchildremoval-ReopenTheRemovalEnd
-- Issue Description: 
    For the case 221030015595  - the Child La'Riyah Rivers was removed but returned home, Now reopen the removal end date so that foster care can enter placement, approve and validate for payment 
    Customer Email ID:jenny.sibila@maryland.gov
  
-- Resolution: Updated the updatedby Column in the personprogramarea table for the case 221030019621

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/	

--2022-05-19 15:30:00.000
 update
	intakeservreqchildremoval
set
	exitdate = null,
	updatedby = 'CDM-23488',
	updatedon = now()
where
	intakeservreqchildremovalid = 'c66712fc-e918-4b39-bdbd-a16fe25077ed';

update
	tb_client_eligibility
set
	end_dt = null,
	update_user_id = 'CDM-23488',
	update_ts = now()
where
	removal_id = '253869';

update
	personprogramarea
set
	enddate = null,
	updatedby = 'CDM-23488',
	updatedon = now()
where
	personprogramid = '6bb00f3a-485e-469d-aa3c-14e2f9f839a7';