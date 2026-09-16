/*
-- Issue Description: CDM-36245 - SEN
   PGCDSS incorrectly selected the child as an SEN. Hospital confirmed the urine tox was negative. 
   We need this to be unchecked but cannot uncheck the SEN box.
   We cannot override the referral as it is a service case. 
   We need the SEN box unchecked to stop the case from being tracked as an SEN
   User Request to remove the SEN flag of PID # 202578215.
-- Client ID: 202578215 (BABY WASHINGTON) - 8f74e31d-27f5-44e0-b03b-38dd53b5a4a6
-- Category/ Module: Case Management
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to remove the SEN flag of Client # 202578215
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	   substanceexposednewborntimetamp, substanceclasses, othersubstances, senstatusflag, updatedby, updatedon 
from   person
where  cjamspid = 202578215 and activeflag = 1;

update person
set    substanceexposednewbornflag = NULL,  -- 1
	   substanceexposednewbornsourcetypekey = NULL,  -- '2954'
	   substanceexposednewbornsourceid = NULL,  -- 'I241011860789'
	   substanceexposednewborntimetamp = NULL,  -- '2024-01-03 01:48:24'
	   substanceclasses = NULL,  -- '["BTNR"]'
	   senstatusflag = NULL,  -- 0
	   updatedby = 'CDM-36245', 
	   updatedon = now()
where  cjamspid = 202578215 and activeflag = 1;
