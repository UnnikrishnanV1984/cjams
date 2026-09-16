/*
 Issue Description: CDM-40380
-- Category/ Module: Dashboard 
-- Root cause: Updating the substanceexposednewbornsourceid with the corresponding intakeid.
-- Fix Provided: Datafix has been promoted to update the substanceexposednewbornsourceid
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


-- select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
-- 	substanceexposednewborntimetamp, substanceclasses, othersubstances, updatedby, updatedon 
-- from person
-- where cjamspid =  203634448
-- 	and activeflag = 1;


update person
set substanceexposednewbornsourcetypekey = '2954',
	substanceexposednewbornsourceid = 'I241012824942',
	updatedby = 'CDM-40380', 
	updatedon = now()
where cjamspid = 203634448
	and activeflag = 1;