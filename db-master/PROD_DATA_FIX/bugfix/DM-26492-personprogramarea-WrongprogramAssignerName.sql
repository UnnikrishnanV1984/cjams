-- CDM-26492- error - Program Assigner Name Wrong
/*
   File Name: CDM-26492-personprogramarea-WrongprogramAssignerName
-- Issue Description: 
    For the case 221030018995  - For client ID 200974708 Program Assigners name should be Ronda Lewis instead of Nichole Falkowski.
    Customer Email ID:ronda.lewis@maryland.gov
  
-- Resolution: Updated the updatedby for personprogramarea

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

--select personid,* from placement where intakeservreqchildremovalid = 'c24f5455-a53e-4a78-85c8-960c84285a61' - did not find the record
*/

-- a35e6061-f2a7-4d1b-a707-fe301cf28d0d    CDM-26492
 update
	personprogramarea
set
	updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67',
	updatedon = now()
where
	personprogramid = 'd31cc215-e3b4-4df3-ab61-489347f223d5';