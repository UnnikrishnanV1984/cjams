-- CDM-27286 - Adoption case
/*
-- Issue Description: 
   User Request do a data fix to select the below substance classes for CJAMS Persons

-- Client ID: 200985144 (DYLAN L Carr) - e08ed639-7319-4808-b2ca-6b094ed4511d
-- No MDM ID and CIS Client ID
-- Substances Class: *marijuan*a -- BMJA	Baby - Marijuana

-- Client ID: 200985152	(MICHAEL Pollard) - c5e37e9d-6234-4cd0-af0c-e5a0bb190b07
-- CIS Client ID: 552064337
-- BCOC	Baby - Cocaine
-- OPIA	Opiates
-- BOTH	Baby - Other 
-- othersubstances: fentanyl

-- Client ID: 200985131	(TALYIAH NICOLE	Cvengros) - 62bd82bd-7fe7-447f-b69b-6d4ef7f22aa8
-- CIS Client ID: 525065223
-- Substance Class: methadone - BMTD	Baby - Methadone

-- Category/ Module: Case Management
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select cjamspid, firstname, lastname, substanceexposednewbornflag, 
	substanceclasses, othersubstances, updatedby, updatedon
from person
where cjamspid = 200985144
	and activeflag = 1;

update person
set substanceclasses = '["BMJA"]',
	updatedby = 'CDM-27286', 
	updatedon = now()
where cjamspid = 200985144
	and activeflag = 1;
	
select cjamspid, firstname, lastname, substanceexposednewbornflag, 
	substanceclasses, othersubstances, updatedby, updatedon
from person
where cjamspid = 200985152
	and activeflag = 1;

update person
set substanceclasses = '["BCOC","BOTH","OPIA"]',
	othersubstances = 'Fentanyl',
	updatedby = 'CDM-27286', 
	updatedon = now()
where cjamspid = 200985152
	and activeflag = 1;
	
select cjamspid, firstname, lastname, substanceexposednewbornflag, 
	substanceclasses, othersubstances, updatedby, updatedon
from person
where cjamspid = 200985131
	and activeflag = 1;

update person
set substanceclasses = '["BMTD"]',
	updatedby = 'CDM-27286', 
	updatedon = now()
where cjamspid = 200985131
	and activeflag = 1;
	
	