/*
-- Issue Description: 
	CDM-29837-head 0f household
	 Category/ Module: 
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

update intakeservicerequestactor set servicecaseid='87974f2e-e9f9-402b-bf6f-9dd1f9d67b8d',
updatedby = 'CDM-29837', updatedon = now()
where
personid='79106bbb-c51a-4731-852d-a3c31dc2afe2' and intakeservicerequestactorid='fd8ab14f-2d5b-42e7-bb4a-cba660f20d21';