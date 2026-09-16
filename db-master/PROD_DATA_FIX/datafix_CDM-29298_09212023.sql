-- CDM-29298 - SENs Milestone
/*
-- Issue Description: 
   User Request to remove the SEN flag of PID # 201021510 
   As a result of this ticket completion this case will be removed from the SEN Milestone.

-- Client ID: 201021510	(Nyrae Collins) - baf38a43-5dc6-4daa-bd7e-587a7d3a5b1a
-- Intake # I231010376154 

-- Category/ Module: Case Management
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to remove the SEN flag of Client # 201021510
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the requested SEN flag (CDM-29298)
select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	substanceexposednewborntimetamp, substanceclasses, othersubstances, senstatusflag, updatedby, updatedon 
from person
where cjamspid = 201021510
	and activeflag = 1;

update person
set substanceexposednewbornflag = NULL,  -- 1
	substanceexposednewbornsourcetypekey = NULL, -- '2954'
	substanceexposednewbornsourceid = NULL, -- 'I231010376154'
	substanceexposednewborntimetamp = NULL, -- '2023-01-23 17:15:15.044'
	substanceclasses = NULL, -- '["BMJA"]'
--	othersubstances = NULL, -- NULL
	senstatusflag = NULL, -- 0
	updatedby = 'CDM-29298', 
	updatedon = now()
where cjamspid = 201021510
	and activeflag = 1;
	

