-- CDM-26555- error - removal created in the investigation
/*
   File Name: CDM-26555-intakeservreqchildremoval-RemoveHistoryforChild
-- Issue Description: 
    For the case 3187278  - Remove the record from removal history for the child khole brown
    Customer Email ID:indaw.galloway1@maryland.gov
  
-- Resolution: Updated the Active flag to zero for intakeservreqchildremoval and personprogramarea 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

--select personid,* from placement where intakeservreqchildremovalid = 'c24f5455-a53e-4a78-85c8-960c84285a61' - did not find the record
*/


update
	intakeservreqchildremoval
set
	activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-26555'
where
	intakeservreqchildremovalid = 'c24f5455-a53e-4a78-85c8-960c84285a61'
	and activeflag = 1;

update
	personprogramarea
set
	activeflag = 0,
	updatedby = 'CDM-26555',
	updatedon = now()
where
	personprogramid = '96c910ef-5460-48f4-9c8a-cf1ee10aa9eb';