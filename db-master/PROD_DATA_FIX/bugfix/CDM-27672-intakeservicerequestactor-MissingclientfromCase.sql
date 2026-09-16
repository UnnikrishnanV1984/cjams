-- CDM-27672 -Missing client from Case
/*
   File Name: CDM-27672-intakeservicerequestactor-MissingclientfromCase
Issue Description: 
    For the case 221030028990:The client Chirley Damaris Kellin Gutierrez Martinez (DOB: 2/9/98) is missing from the case.
    Customer Email ID:noa.davis@maryland.gov
  
-- Resolution: Updated the servicecaseid to 9c05b8e3-868c-4cc7-89b2-8648be1cdc98 in the intakeservicerequestactor table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	intakeservicerequestactor
set
	servicecaseid = '9c05b8e3-868c-4cc7-89b2-8648be1cdc98',
	updatedby = 'CDM-27672',
	updatedon = now()
where
	intakeservicerequestactorid = '39b5a273-40cc-44e0-9972-0014a0406ffb';