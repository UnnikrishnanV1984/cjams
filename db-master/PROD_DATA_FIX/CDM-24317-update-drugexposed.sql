-- CDM-24317 - 
/*
-- Issue Description: 
  
   User request to add Substance class as Baby-Methadone and Baby -Heroine

-- Client ID: 3779854(Seth Manger) - 0cdf1704-b6ba-400f-af83-e92622bd5c86
-- Substance Class: 
-- BMTD - Baby - Methadone and BHOI -Baby-Herione
-
-- Category/ Module: Case Management
-- Root cause: 
-- Pull request#: 6528
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

	update personrole
set drugexposedtypekey = '["BMTD","BHOI"]',
	updatedby = 'CDM-24317', 
	updatedon = now()
where personid = '9c76e2e6-a9e0-4e1b-a829-fe28c5f3ff39'
	and activeflag = 1
	and drugexposednewbornflag = 1 
	and drugexposedtypekey is null ;