-- CDM-24683 - Former SENS Child will not save
/*
-- Issue Description: 
   Not able to add the person since substance class dropdown is blank.
   User request to add Substance class as 'Baby - Methadone'
  
-- Client ID: 4227400 (CODY CUMMINGS) - 5d6699dc-7690-46f7-94c5-ab748b03327e
-- BMJA	: Baby - Methadone 

-- Category/ Module: Case Management
-- Root cause: Known issue, we will fix this aloing with the upcoming User Story.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select personroleid, drugexposednewbornflag, drugexposedtypekey, otherdrugs, updatedby, updatedon
	from personrole 
where personid = '5d6699dc-7690-46f7-94c5-ab748b03327e'
	and activeflag = 1
	and drugexposednewbornflag = 1 
	and drugexposedtypekey is null ;

update personrole
set drugexposedtypekey = '["BMTD"]',
	updatedby = 'CDM-24683', 
	updatedon = now()
where personid = '5d6699dc-7690-46f7-94c5-ab748b03327e'
	and activeflag = 1
	and drugexposednewbornflag = 1 
	and drugexposedtypekey is null ;
