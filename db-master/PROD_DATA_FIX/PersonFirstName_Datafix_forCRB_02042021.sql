-- CRB Outbound batch failure due to special character in Person First Name 
-- Datafix to update First name on the following person record (invalid character is ’ and will fix as ')
-- cjamspid = 200308070 - U'Niqua’ --> new value U'Niqua' (479060477)

-- Before
select cjamspid, firstname, cisclientid, updatedon, updatedby
	from person 
where cjamspid = 200308070
	and activeflag = 1;

-- Update
Update person
	set firstname = 'U''Niqua''',
		updatedon = now(),
		updatedby = 'DFX020421'	
where cjamspid = 200308070
	and activeflag = 1;

-- After
select cjamspid, firstname, cisclientid, updatedon, updatedby
	from person 
where cjamspid = 200308070
	and activeflag = 1;
	