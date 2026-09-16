-- CDM-24560 - Person card updates
/*
-- Issue Description: 
   Not able to add the person since substance class dropdown is blank.
   User request to add Substance class as 'Baby - Marijuana'
  
-- Case ID: 3211097 - c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef
-- Client ID: 4354969 (KAYORA M	UNKLE) - 1d9ef329-8b51-4f2e-a25e-2a98a635cab2
-- BMJA	: Baby - Marijuana - ["BMJA"]

-- Category/ Module: Case Management
-- Root cause: Known issue, we will fix this aloing with the upcoming User Story.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select personroleid, drugexposedtypekey, otherdrugs, updatedby, updatedon
	from personrole 
where personid = '1d9ef329-8b51-4f2e-a25e-2a98a635cab2'
	and activeflag = 1
	and drugexposednewbornflag = 1 
	and drugexposedtypekey is null ;

update personrole
set drugexposedtypekey = '["BMJA"]',
	updatedby = 'CDM-17681', 
	updatedon = now()
where personid = '1d9ef329-8b51-4f2e-a25e-2a98a635cab2'
	and activeflag = 1
	and drugexposednewbornflag = 1 
	and drugexposedtypekey is null ;
