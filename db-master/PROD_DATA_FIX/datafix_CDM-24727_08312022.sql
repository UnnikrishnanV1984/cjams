-- CDM-24727 - Can't Add Person to Case
/*
-- Issue Description: 
   I cannot add Gracie Mumma (CJAMS ID 3743642) to my case.
   Not able to add the person since substance class dropdown is blank.
   User request to add Substance class as 'Baby - Methadone'
  
-- Case ID: 221020238584
-- Client ID: 3743642 (GRACIE MUMMA) - 757be3f7-24ed-4fb8-bd96-4403421ef185
	Substance Class:
	BAS		Baby - Amphetamines
	BENZO	Benzodiazepine's
	BMJA	Baby - Marijuana
	BMTD	Baby - Methadone

-- Category/ Module: Case Management
-- Root cause: Known issue, we will fix this aloing with the upcoming User Story.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select personroleid, drugexposednewbornflag, drugexposedtypekey, otherdrugs, updatedby, updatedon
	from personrole 
where personid = '757be3f7-24ed-4fb8-bd96-4403421ef185'
	and activeflag = 1
	and drugexposednewbornflag = 1 
	and drugexposedtypekey is null ;

update personrole
set drugexposedtypekey = '["BAS","BENZO","BMJA","BMTD"]',
	updatedby = 'CDM-24727', 
	updatedon = now()
where personid = '757be3f7-24ed-4fb8-bd96-4403421ef185'
	and activeflag = 1
	and drugexposednewbornflag = 1 
	and drugexposedtypekey is null ;
