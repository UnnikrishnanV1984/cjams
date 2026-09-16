-- CDM-17672 Subsidy payment
/*
-- Issue Description: 
   User request to update the child's Adoption Agreement End date 
   with the child's 21st Birthday, Need to Update the End date as 10/14/2022
   
-- Case ID: 3086372
-- Client ID: 1486195 (TYREESE JOEL	SAVAGE) - 1e6c98e9-8eb7-470f-b623-834a9e8434b4
-- Adoption ID: 7163 - 2006-04-06 To 2021-10-14 - 30e4466b-4c85-4ce0-a0b1-98bcce23980f
-- Provider ID: 5008139 (Joann Savage)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Application is currently not allowing the user to extend the Agreement.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Update Adoption Agreement End date as 10/14/2022 (Old value 2021-10-14)
select alternateid, startdate, enddate, updatedby, updatedon
	from adoptioncase 
where adoptioncaseid = '30e4466b-4c85-4ce0-a0b1-98bcce23980f'
	and activeflag = 1;

update adoptioncase
set enddate = '2022-10-14 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-17672'
where adoptioncaseid = '30e4466b-4c85-4ce0-a0b1-98bcce23980f'
	and activeflag = 1;

select providerid, startdate, enddate, updatedby, updatedon  
	from adoptioncaseagreement 
where adoptioncaseid = '30e4466b-4c85-4ce0-a0b1-98bcce23980f'
	and activeflag = 1;

update adoptioncaseagreement
set enddate = '2022-10-14 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-17672'
where adoptioncaseid = '30e4466b-4c85-4ce0-a0b1-98bcce23980f'
	and activeflag = 1;

