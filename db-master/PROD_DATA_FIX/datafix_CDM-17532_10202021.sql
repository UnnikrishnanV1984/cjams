-- CDM-17532 - Cant Save Subsidy Agreement
/*
-- Issue Description: 
   User request to update the child's Adoption Agreement End date 
   with the child's 21st Birthday (10/13/2024).
   
-- Case ID: 3054424
-- Client ID: 1318629 (CHRISTIANNA R BARTLETT) - 438b5e17-f17a-4dc7-8a22-7ed4cca7a9e2
-- Adoption ID: 4877 - 2005-08-01 To 2021-10-13 - 69006501-b69c-486f-bfce-71bcc440ff6c
-- Provider ID: 5005375	(Candy Bartlett)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Application is currently not allowing the user to extend the Agreement.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Update Adoption Agreement End date as 10/13/2024 (Old value 2021-10-13)
select alternateid, startdate, enddate, updatedby, updatedon
	from adoptioncase 
where adoptioncaseid = '69006501-b69c-486f-bfce-71bcc440ff6c'
	and activeflag = 1;

update adoptioncase
set enddate = '2024-10-13 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-17532'
where adoptioncaseid = '69006501-b69c-486f-bfce-71bcc440ff6c'
	and activeflag = 1;

select providerid, startdate, enddate, updatedby, updatedon  
	from adoptioncaseagreement 
where adoptioncaseid = '69006501-b69c-486f-bfce-71bcc440ff6c'
	and activeflag = 1;

update adoptioncaseagreement
set enddate = '2024-10-13 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-17532'
where adoptioncaseid = '69006501-b69c-486f-bfce-71bcc440ff6c'
	and activeflag = 1;
