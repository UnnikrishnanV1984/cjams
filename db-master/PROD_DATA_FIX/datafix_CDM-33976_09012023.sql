-- CDM-33976 - Removing SEN Flag from a person card
/*
-- Issue Description: 
   User Request to remove the SEN flag of PID # 201483313 
   As a result of this ticket completion this case will be removed from the SEN Milestone.

-- Client ID: 201483313 (Baby Boy DeFeo) - 92fccca8-efdb-4427-9f98-e028c4797707
-- Intake # 231010843182 

-- Category/ Module: Case Management
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to remove the SEN flag of Client # 201483313
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the requested SEN flag (CDM-33976)
select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	substanceexposednewborntimetamp, substanceclasses, othersubstances, senstatusflag, updatedby, updatedon 
from person
where cjamspid = 201483313
	and activeflag = 1;

update person
set substanceexposednewbornflag = NULL,  -- 1
	substanceexposednewbornsourcetypekey = NULL, -- '2954'
	substanceexposednewbornsourceid = NULL, -- 'I231010843182'
	substanceexposednewborntimetamp = NULL, -- '2023-07-25 21:54:52'
	substanceclasses = NULL, -- '["BMJA","OPIA"]'
--	othersubstances = NULL, -- NULL
	senstatusflag = NULL, -- 0
	updatedby = 'CDM-33976', 
	updatedon = now()
where cjamspid = 201483313
	and activeflag = 1;
