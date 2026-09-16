-- CDM-20522-Wrong person in case
/*
   File Name: CDM-20522-intakeservicerequestactor-WrongPerson
-- Issue Description: 
   For the case number221030013783:The person Peterson Louis Jr. (CJAMS # 200860276) does not belong in this case. The correct person is Kenderson Louis (Dob: 10/16/2017)
   Customer Email ID: ebony.murray1@maryland.gov

-- Resolution: Updated the activeflag to zero in intakeservicerequestactor and actor table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


update
	intakeservicerequestactor
set
	activeflag = 0,
	updatedby = 'CDM-20522',
	updatedon = now()
where
	intakeservicerequestactorid = '0f4a1f4b-aa84-48aa-86bb-5a58e78b4348';

update
	actor
set
	activeflag = 0,
	updatedby = 'CDM-20522',
	updatedon = now()
where
	actorid = '195b7911-9e55-411e-ba98-eabaa6d89b02';

update
	personrole
set
	activeflag = 0,
	updatedby = 'CDM-20522',
	updatedon = now()
where
	personid = '27f8718b-9111-4cdc-b67d-b522f5506c3f'
	and servicecaseid = '97789094-ec6e-435a-9333-61efd85b9978';