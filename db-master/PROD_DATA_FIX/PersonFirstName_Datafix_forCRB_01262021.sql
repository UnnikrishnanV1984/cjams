-- CRB Outbound batch failure due to special character in Person First Name 
-- Datafix to update First name on the following person record (invalid character is ’ and will fix as ')
-- cjamspid = 200149014 - J’Abriel --> new value J'Abriel (400538273)

-- Before
select cjamspid, firstname, cisclientid, updatedon, updatedby
	from person 
where cjamspid = 200149014
	and activeflag = 1;

-- Update
Update person
	set firstname = 'J''Abriel',
		updatedon = now(),
		updatedby = 'DFX012621'	
where cjamspid = 200149014
	and activeflag = 1;


-- After
select cjamspid, firstname, cisclientid, updatedon, updatedby
	from person 
where cjamspid = 200149014
	and activeflag = 1;