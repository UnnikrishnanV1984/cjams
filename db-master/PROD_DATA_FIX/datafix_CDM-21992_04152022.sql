-- CDM-21992 - Payment issue adoption
/*
-- Issue Description: 
   The 18th birthday was extended & approved and the subsidy rate renewed, 
	but payment didnt show up on the provider side. 
   
-- Adoption Case ID: 3177084
-- Client ID: 2725936 (ANTWON GRAZIANO WRIGHT) - 7563003a-1627-418b-86b9-56f9dfa97ff5
-- Adoption ID: 21906 - 2009-08-19 To 2022-03-02 - 4d66e623-e4f0-49fd-a4e0-acd34cb87f19
-- Provider ID: 5011766	(Kear Wright)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Update was missed in CDM-21670
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Adoption Agreement End date as 2025-03-02 00:00:00 (Old value 2022-03-02 00:00:00)
select alternateid, startdate, enddate, updatedby, updatedon
	from adoptioncase 
where adoptioncaseid = '4d66e623-e4f0-49fd-a4e0-acd34cb87f19'
	and activeflag = 1;

update adoptioncase
set enddate = '2025-03-02 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-21992'
where adoptioncaseid = '4d66e623-e4f0-49fd-a4e0-acd34cb87f19'
	and activeflag = 1;

select providerid, startdate, enddate, updatedby, updatedon  
	from adoptioncaseagreement 
where adoptioncaseid = '4d66e623-e4f0-49fd-a4e0-acd34cb87f19'
	and activeflag = 1;

update adoptioncaseagreement
set enddate = '2025-03-02 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-21992'
where adoptioncaseid = '4d66e623-e4f0-49fd-a4e0-acd34cb87f19'
	and activeflag = 1;

-- To Trigger Under/Over 
select startdate, enddate, updatedby, updatedon 
	from adoptioncaseagreementrate
where adoptionagreementrateid  = 'aa6442c1-18f1-4b1c-a1b4-b9409c66ce2d'
	and adoptionagreementid  = 'afeb4e9d-9822-4a52-8a0b-37a9dee727b2'
	and activeflag = 1 ;
	
update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-21992'
where adoptionagreementrateid  = 'aa6442c1-18f1-4b1c-a1b4-b9409c66ce2d'
	and adoptionagreementid  = 'afeb4e9d-9822-4a52-8a0b-37a9dee727b2'
	and activeflag = 1 ;
	