/*
-- Issue Description: CDM-37655 - SENs person
   please remove the SEN flag for Tavon Shelton Stewart Jr(CJAMS ID: 201235336) 
   and Talia Mary Rose Stewart (CJAMS ID - 201235335)
-- Category/ Module: Case Management
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to remove the SEN flag of Client # 201235336 and #201235335 
*/


select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	   substanceexposednewborntimetamp, substanceclasses, othersubstances, senstatusflag, updatedby, updatedon 
from   person
where  cjamspid = 201235336 and activeflag = 1;

update person
set    substanceexposednewbornflag = NULL,  -- 1
       substanceexposednewbornsourcetypekey = NULL,  -- '2952'
       substanceexposednewbornsourceid = NULL,  -- 'I231010603103'
       substanceexposednewborntimetamp = NULL,  -- '2023-05-13 19:27:32'
       substanceclasses = NULL,  -- '["BMJA","OPIA"]'
       senstatusflag = NULL,  -- 0
       updatedby = 'CDM-37655', 
       updatedon = now()
where  cjamspid = 201235336 and activeflag = 1;


select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	   substanceexposednewborntimetamp, substanceclasses, othersubstances, senstatusflag, updatedby, updatedon 
from   person
where  cjamspid = 201235335 and activeflag = 1;

update person
set    substanceexposednewbornflag = NULL,  -- 0
       senstatusflag = NULL,  -- 1
       updatedby = 'CDM-37655', 
       updatedon = now()
where  cjamspid = 201235335 and activeflag = 1;
