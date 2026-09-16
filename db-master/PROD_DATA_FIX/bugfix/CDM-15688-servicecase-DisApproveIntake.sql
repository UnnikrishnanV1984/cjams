-- CDM-15688 -Cannot approve intake
/*
   File Name: CDM-15688-servicecase-CannotApproveIntake
-- Issue Description: 
    For the Intake number I211010178089  - 
	1) Service Case displayed as a blank.
	2) Add Assignment to the case worker (Kathryn McAllister) in this new service case with start date (08/08/2021)
	3) Update the contact into this case with below information; - FAIL
	4) New Service case Start Date should be 07/29/2021. - FAIL
    Customer Email ID:mattier.meehan@maryland.gov
  
-- Resolution: Updated the startdate in the servicecase and caseassignment for the Intake number I211010178089

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

-- 2022-02-19 03:47:37.134
UPDATE
	servicecase
SET
	startdate = '2021-07-29 16:50:00.000',
	updatedon = now(),
	updatedby = 'CDM-15688'
WHERE
	servicecaseid = 'aef380d3-b2ae-4da2-a745-d4dfe43586f9';

-- 2021-07-29 16:50:00.000
 UPDATE
	caseassignment
SET	
	startdate = '2021-08-08 16:50:00.000',
	updatedon = now(),
	updatedby = 'CDM-15688'
WHERE
	caseassignmentid = '888d83cd-f6e8-42bd-b55a-c1c5a962f813';

-- 2022-02-19 03:47:37, 2022-02-19 03:47:37
 update
	servicecasedisposition
set
	statusdate = '2021-07-29 16:50:00.000',
	effectivedate = '2021-07-29 16:50:00.000',
	updatedon = now(),
	updatedby = 'CDM-15688'
where
	servicecaseid = 'aef380d3-b2ae-4da2-a745-d4dfe43586f9';