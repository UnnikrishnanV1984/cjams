-- CDM-27500 - SEN Case not on the milestone
/*
-- Issue Description: 
   User Request do a data fix to update SEN source as Intake # I221010331147 for the below client

-- Case ID: 3272602
-- Client id: 200974695 (Kai Hensley) - 1315ed64-c628-456d-a87b-6107ef90a5b1
-- Intake # I221010331147

-- Category/ Module: Case Management
-- Root cause: This person was a Quick Add Person card in the Intake, which was confirmed under the associated Service Case. And currently in this scenario CJAMS is capturing the Service case as SEN source.
-- On the Qlik reporting side, current code is looking for SEN persons with the source as Intakes only.
-- Fix Provided: Datafix has been prmoted to update the SEN source as Intake # I221010331147.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update SEN source as Intake (CDM-27500)
select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	substanceexposednewborntimetamp, substanceclasses, othersubstances, updatedby, updatedon 
from person
where cjamspid = 200974695
	and activeflag = 1;

update person
set substanceexposednewbornsourcetypekey = '2954',
	substanceexposednewbornsourceid = 'I221010331147',
	updatedby = 'CDM-27500', 
	updatedon = now()
where cjamspid = 200974695
	and activeflag = 1;
