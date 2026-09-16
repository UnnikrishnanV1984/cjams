-- CDM-5605 - CJAMS Record to CRB
-- CRB Outbound batch failure due to special character in Person First Name 
-- Datafix to update First name on the following person records (invalid character is ’ and will fix as ')
-- cjamspid = 200021665 - J’KAMRYN --> new value J'KAMRYN (400635013)

-- Before
select cjamspid, firstname, cisclientid, updatedon, updatedby
	from person 
where cjamspid = 200021665
	and activeflag = 1;

-- Update
Update person
	set firstname = 'J''KAMRYN',
		updatedon = current_timestamp,
		updatedby = 'CDM-5605'
where cjamspid = 200021665
	and activeflag = 1;

-- After
select cjamspid, firstname, cisclientid, updatedon, updatedby
	from person 
where cjamspid = 200021665
	and activeflag = 1;
