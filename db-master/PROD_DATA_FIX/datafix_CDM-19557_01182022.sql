-- CDM-19557 - Maltreator name
/*
-- Issue Description: 
	User request to change the maltreator Name from Kobe Unknown to Kobina Quainoo. 

-- CPS-IR ID: 2021081093963
-- Client ID: 200643934 (Kobe Unknown) - d56ad106-d760-4154-9ffc-9c7c3a286987

-- New information is:
-- KOBINA K QUAINOO
-- DOB:07/08/1975
-- CIS ID: 494050700
-- MDM-ID: MDT-127528579

-- Category/ Module: Maltreatment Allegation (CPS Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Demographic Info	
select cjamspid, personid, firstname, middlename, lastname, 
	gendertypekey, dob, ssnno, cisclientid, updatedby, updatedon
from person 
where cjamspid = 200643934
	and activeflag = 1 ;

update person
set	firstname = 'Kobina',
	middlename = 'K',
    lastname = 'Quainoo',
	dob = '1975-07-08 00:00:00',	
	ssnno = '129020180',
	cisclientid = '494050700',	
	updatedon = now(), 
	updatedby = 'CDM-19557'
where cjamspid = 200643934
	and activeflag = 1 ;
	
-- Update MDM ID (old ID MDT-137579402 - CIS 403065057)
select personidentifierid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon
	from personidentifier
where personid = 'd56ad106-d760-4154-9ffc-9c7c3a286987'
	and personidentifiertypekey = 'MDM_ID'
	and activeflag = 1 ;
	
update personidentifier
set personidentifiervalue = 'MDT-127528579',	
	updatedon = now(), 
	updatedby = 'CDM-19557'
where personid = 'd56ad106-d760-4154-9ffc-9c7c3a286987'
	and personidentifiertypekey = 'MDM_ID'
	and activeflag = 1 ;

-- Insert personidentifier for Social
INSERT INTO cjams.personidentifier
	(	personidentifierid, personid, personidentifiertypekey, personidentifiervalue, 
		updatedby, updatedon, insertedby, insertedon, activeflag, 
		effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), 'd56ad106-d760-4154-9ffc-9c7c3a286987', 'SSN', '129020180', 
		'CDM-19557', now(), 'CDM-19557', now(), 1, 
		now(), NULL, NULL, NULL, NULL, NULL
	);
	

-- To get the Person payload for MDM Update 	
-- SELECT json_agg(a) from sp_get_person_mdm('d56ad106-d760-4154-9ffc-9c7c3a286987') a;	