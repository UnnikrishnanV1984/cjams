-- CDM-25192 - CANNOT UPDATE PERSON CARD
/*
-- Issue Description: 
   CAN NOT UPDATE PERSON CARD - AS SUBSTANCE CLASS WILL NOT SELECT TO BE UPDATED PREVIOUS SEN CASE. is blank.
   User request to add Substance class as Baby-Methadone

-- Client ID: 4462013 (JOSEPH FRAZIER) - 0cdf1704-b6ba-400f-af83-e92622bd5c86
-- Substance Class: 
-- BMTD - Baby - Methadone

-- Category/ Module: Case Management
-- Root cause: Known issue, we will fix this aloing with the upcoming User Story.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select personroleid, drugexposednewbornflag, drugexposedtypekey, otherdrugs, updatedby, updatedon
	from personrole 
where personid = '0cdf1704-b6ba-400f-af83-e92622bd5c86'
	and activeflag = 1
	and drugexposednewbornflag = 1 
	and drugexposedtypekey is null ;

update personrole
set drugexposedtypekey = '["BMTD"]',
	updatedby = 'CDM-25192', 
	updatedon = now()
where personid = '0cdf1704-b6ba-400f-af83-e92622bd5c86'
	and activeflag = 1
	and drugexposednewbornflag = 1 
	and drugexposedtypekey is null ;
