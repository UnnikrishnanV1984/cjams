/*
-- Issue Description: CDM-37070 - Screening Error
   When this case was screened in, the box "historic substance exposed newborn" was checked and this was done in error. 
   This check in this box needs to be removed from this case.
   User Requested to remove the flag of PID # 202793961.
-- Client ID: 202793961 (Amillio Smith) - a537bd07-74cb-4dee-b45e-dbaf7244eb99
-- Category/ Module: Case Management
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to remove the SEN flag of Client # 202793961
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	   substanceexposednewborntimetamp, substanceclasses, othersubstances, senstatusflag, updatedby, updatedon 
from   person
where  cjamspid = 202793961 and activeflag = 1;

update person
set    substanceexposednewbornflag = NULL,  -- 1
       substanceexposednewbornsourcetypekey = NULL,  -- '2954'
       substanceexposednewbornsourceid = NULL,  -- 'I241012055056'
       substanceexposednewborntimetamp = NULL,  -- '2024-01-26 19:37:49'
       substanceclasses = NULL,  -- '["BMJA"]'
       senstatusflag = NULL,  -- 0
       updatedby = 'CDM-37070', 
       updatedon = now()
where  cjamspid = 202793961 and activeflag = 1;
