/*
-- Issue Description: 
	CDM-30004-ctitical-case-defect
	 Category/ Module: 
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

update intakeservicerequest 
set intakeservicerequestclassid = 'b74ded78-12dc-4e6d-94db-7662d6eaf093',updatedby = 'CDM-30004', updatedon = now()
where intakeserviceid = '15052245-1bb3-46ab-9f2e-a446eda0e0ec';