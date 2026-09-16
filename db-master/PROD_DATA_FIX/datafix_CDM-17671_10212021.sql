-- CDM-17671 - Adoption Subsidy
/*
-- Issue Description: 
   User request to update the child's Adoption Agreement End date 
   with the child's 21st Birthday, Need to Update the End date as 7/22/2024
   
-- Case ID: 3085430
-- Client ID: 1390991 (TAMARA HURWITZ) - 9998ba16-f75c-43a6-8ae6-ae67943acdca
-- Adoption ID: 6221 - 2005-10-06 To 2021-07-22 - 366f6747-60fe-4fdd-8e1b-6f8997d3b280
-- Provider ID: 5007626	(Robyn Hurwitz)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Application is currently not allowing the user to extend the Agreement.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Update Adoption Agreement End date as 07/22/2024 (Old value 2021-07-22)
select alternateid, startdate, enddate, updatedby, updatedon
	from adoptioncase 
where adoptioncaseid = '366f6747-60fe-4fdd-8e1b-6f8997d3b280'
	and activeflag = 1;

update adoptioncase
set enddate = '2024-07-22 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-17671'
where adoptioncaseid = '366f6747-60fe-4fdd-8e1b-6f8997d3b280'
	and activeflag = 1;

select providerid, startdate, enddate, updatedby, updatedon  
	from adoptioncaseagreement 
where adoptioncaseid = '366f6747-60fe-4fdd-8e1b-6f8997d3b280'
	and activeflag = 1;

update adoptioncaseagreement
set enddate = '2024-07-22 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-17671'
where adoptioncaseid = '366f6747-60fe-4fdd-8e1b-6f8997d3b280'
	and activeflag = 1;
