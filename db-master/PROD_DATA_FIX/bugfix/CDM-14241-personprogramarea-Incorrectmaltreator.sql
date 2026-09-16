-- CDM-14241 - Incorrect maltreator
/*
   File Name: CDM-14241-personprogramarea-Incorrectmaltreator
-- Issue Description: 
    For the case CW2924594  - Martez Ricardo Green is identified as the maltreator instead of Martaz Travon Green.
    Customer Email ID:nicole.meekins1@maryland.gov

-- Resolution: Need to add the Martaz Travon Green to Person Tab and remove  Martez Ricardo Green as Maltreator and assign
Martaz Travon Green as Maltreator 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


-- 1751787    113a7838-ddb6-4e59-a18f-931fa21d5a9e    1        MARTAZ    GREEN    TRAVON
-- 4169123    90588a2d-9a75-4a99-a8a4-7e4fe95bc04d    1        Martez    Green    Ricardo

-- update actor
update
	actor
set
	personid = '113a7838-ddb6-4e59-a18f-931fa21d5a9e',
    updatedby = 'CDM-14241', 
    updatedon = now()
where
	intakeserviceid = 'b2b53129-0091-444b-936c-edec7549de44'
	and personid = '90588a2d-9a75-4a99-a8a4-7e4fe95bc04d';

-- update intakeservicerequestactor
update
	intakeservicerequestactor
set
	personid = '113a7838-ddb6-4e59-a18f-931fa21d5a9e',
    updatedby = 'CDM-14241', 
    updatedon = now()
where
	actorid = '49fbc0fe-87da-4844-8f82-0b87c4c8442d'
	and personid = '90588a2d-9a75-4a99-a8a4-7e4fe95bc04d';

-- update personprogramarea
update
	personprogramarea
set
	personid = '113a7838-ddb6-4e59-a18f-931fa21d5a9e',
    updatedby = 'CDM-14241', 
    updatedon = now()
where
	personid = '90588a2d-9a75-4a99-a8a4-7e4fe95bc04d'
	and entityid = 'CW2924594'