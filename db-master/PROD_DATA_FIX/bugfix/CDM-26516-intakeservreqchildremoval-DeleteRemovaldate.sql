--CDM-26516- Removal End Date needs to be deleted 
/*
   File Name: CDM-26516-intakeservreqchildremoval-DeleteRemovaldate
-- Issue Description: 
    For the case 3063821  - for one of the Child Marisol Abigail Garc need to remove the Removal Date
    Customer Email ID:sarah.shrewsbury@maryland.gov
  
-- Resolution: Updated the exitdate Column in the intakeservreqchildremoval and personprogramarea table for the case 3063821 and cjamspid 3294671

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/



-- 2022-10-04 09:00:00
 update
	intakeservreqchildremoval
set
	exitdate = null,
	updatedby = 'CDM-26516',
	updatedon = now
where
	intakeservreqchildremovalid = '8c96de0e-ab18-47bf-b7a0-a98be25a8b79';

update
	personprogramarea
set
	enddate = null,
	updatedby = 'CDM-26516',
	updatedon = now
where
	personprogramid = 'd6c00c27-f707-430e-9c2b-c07515bafe98';

update
	tb_client_eligibility
set
	end_dt = null,
	update_user_id = 'CDM-26516',
	update_ts = now()
where
	removal_id = '200099';