/*
-- Issue Description: 
   Please do a data fix to unassociate the Child's PID from the 241030268677 case and associate this child's PID with intake I241012058019 which is connected with case 241030269176
-- Category/ Module: Case Management
-- Root cause:Child mapped to Incorrect SEN source as intake and need data fix to correct it.
-- Fix Provided: Datafix has been promoted to update the SEN source as Intake # I241012058019 for the child cjams PID #202795684. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update SEN source as Intake (CDM-37264)
select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	substanceexposednewborntimetamp, substanceclasses, othersubstances, updatedby, updatedon 
from person
where cjamspid = 202795684
	and activeflag = 1;

update person
set substanceexposednewbornsourcetypekey = '2954',
	substanceexposednewbornsourceid = 'I241012058019',
	updatedby = 'CDM-37264', 
	updatedon = now()
where cjamspid = 202795684
	and activeflag = 1;