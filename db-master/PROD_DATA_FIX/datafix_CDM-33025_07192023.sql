-- CDM-33025 - No Alleged Maltreator or Investigation Findings in closed case
/*
-- Issue Description: 
	

-- CPS-IR - 221020220056 - b636e7bc-0e6d-4cc6-bef8-3a750fbdfdf0
-- Client ID: 200369797 (TANARSH L KIMBLE) - 2a426a9d-638f-4d49-899c-fdeaff29b4b7
-- 8b046402-5ea1-4610-a853-0d861e89d3e4	AM	   - isprimary = true  - Inactive  - last updated on 2022-10-07 10:15:55	
-- 0523a545-ca26-4a44-a295-6f7ddc9fba97	PARENT - isprimary = true  - Active

-- Category/ Module: Person (Investigation Management)
-- Root cause: Data Issue - intakeservicerequestactor table - Alleged Maltreator role is a soft deleted record.
-- Fix Provided: Datafix has been promoted make the Alleged Maltreator perosn role as active record.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Make Active and update isprimary = false
-- 8b046402-5ea1-4610-a853-0d861e89d3e4	AM	   - isprimary = true  - Inactive  - last updated on 2022-10-07 10:15:55	
-- 0523a545-ca26-4a44-a295-6f7ddc9fba97	PARENT - isprimary = true  - Active
select intakeservicerequestactorid, intakeservicerequestpersontypekey, isprimary, 
	intakenumber, intakeserviceid, servicecaseid, activeflag, updatedby, updatedon
from intakeservicerequestactor
where intakeservicerequestactorid = '8b046402-5ea1-4610-a853-0d861e89d3e4'
	and activeflag = 0;

update intakeservicerequestactor
set activeflag = 1,
	isprimary = false,
	updatedby = 'CDM-33025',
	updatedon = now()
where intakeservicerequestactorid = '8b046402-5ea1-4610-a853-0d861e89d3e4'
	and activeflag = 0;