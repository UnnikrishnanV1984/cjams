-- CDM-15937 - Clients not receiving a CIS ID#
/*
-- Issue Description: 
   3 MDM registered Person records with NO CIS Client IDs

-- Client ID: 4365600 (ERIC James LAMOREAUX) - aa2defd0-860f-4e0c-968d-e27aea2d3250
-- CIS: 415011412 - MDT-123601147

-- Client ID: 4365601 (EVAN J LAMOREAUX) - daba7bea-a2b1-4e68-a141-a305820ef1ac
-- CIS: 400584852 - MDT-128768228

-- Client ID: 4365602 (LIAM E LAMOREAUX) - de8037bd-20aa-44a7-8cde-bc713e34fc6e
-- CIS: 400664010 - MDT-128843370

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: CJAMS - MDM interface issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update CIS Client IDs
-- Client ID: 4365600 (ERIC James LAMOREAUX) - aa2defd0-860f-4e0c-968d-e27aea2d3250
-- CIS: 415011412 - MDT-123601147
select cjamspid, personid, firstname, middlename, lastname, 
	gendertypekey, dob, ssnno, cisclientid, updatedby, updatedon
from person 
where cjamspid = 4365600
	and activeflag = 1 ;

update person
set	cisclientid = '415011412',	
	updatedon = now(), 
	updatedby = 'CDM-15937'
where cjamspid = 4365600
	and activeflag = 1 ;
	
-- Client ID: 4365601 (EVAN J LAMOREAUX) - daba7bea-a2b1-4e68-a141-a305820ef1ac
-- CIS: 400584852 - MDT-128768228
select cjamspid, personid, firstname, middlename, lastname, 
	gendertypekey, dob, ssnno, cisclientid, updatedby, updatedon
from person 
where cjamspid = 4365601
	and activeflag = 1 ;

update person
set	cisclientid = '400584852',	
	updatedon = now(), 
	updatedby = 'CDM-15937'
where cjamspid = 4365601
	and activeflag = 1 ;
	
-- Client ID: 4365602 (LIAM E LAMOREAUX) - de8037bd-20aa-44a7-8cde-bc713e34fc6e
-- CIS: 400664010 - MDT-128843370
select cjamspid, personid, firstname, middlename, lastname, 
	gendertypekey, dob, ssnno, cisclientid, updatedby, updatedon
from person 
where cjamspid = 4365602
	and activeflag = 1 ;

update person
set	cisclientid = '400664010',	
	updatedon = now(), 
	updatedby = 'CDM-15937'
where cjamspid = 4365602
	and activeflag = 1 ;
