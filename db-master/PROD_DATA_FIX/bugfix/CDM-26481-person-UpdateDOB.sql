-- CDM-26481- error - wrong DOB for maltreator
/*
   File Name: CDM-26481-person-UpdateDOB
-- Issue Description: 
    For the case 221020253846  - In the persons Others update the data of Birth to 1987-05-29 00:00:00 for cjamspid 200956677
    Customer Email ID:emily.harris1@maryland.gov
  
-- Resolution: Updated the dob Column in the person table for the case 221020253846 and cjamspid 200956677

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


update
	person
set
	dob = '1987-05-29 00:00:00',
	updatedon = now(),
	updatedby = 'CDM-26481'
where
	cjamspid = '200956677';