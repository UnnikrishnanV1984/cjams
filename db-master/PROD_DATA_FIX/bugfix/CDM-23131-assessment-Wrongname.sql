-- CDM-23131-Wrong name on case
/*
   File Name: CDM-23131-assessment-Wrongname
-- Issue Description: 
   For the case number 221030015306, In the assessment tab, for CANS-F worker completing the assessment should be Elizabeth Orff, instead of Elizabeth Sapperstein
    Customer Email ID: elizabeth.orff@maryland.gov

-- Resolution: Updated the updatedby to  7e1eca67-344b-454e-9e62-cd013e8d4adb in the assessment table.

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


--49016bc1-bccd-458b-850c-ac74ec983f36
 update
	assessment
set
	updatedby = '7e1eca67-344b-454e-9e62-cd013e8d4adb',
	updatedon = now()
where
	assessmentid = '9f80dd49-db92-457c-b0b2-4f0f21376864';