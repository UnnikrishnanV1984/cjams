/*
   Issue Description: CDM-31853
   Category/ Module  : delete person
   Root cause: user wants to delete duplicate client
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

--changing path and file name it was attched to CIDM-31853-it was wrong

-- And this persons not added in any contact notes and assessments any where 

-- Delete Program Assignment(s)
select programkey, objectid, objecttypekey, activeflag, updatedby, updatedon 
	from personprogramarea
where personid in('38a5cdfb-2afd-459f-a953-2750f56c62d1','e0ae966e-f85e-446b-8dac-9d83807c6eac')
	and objectid = '0557a7aa-448b-4a3e-993f-569c537b4651' 
	and activeflag = 1;
	
update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-31853',
	updatedon = now()
where personid in('38a5cdfb-2afd-459f-a953-2750f56c62d1','e0ae966e-f85e-446b-8dac-9d83807c6eac')
	and objectid = '0557a7aa-448b-4a3e-993f-569c537b4651' 
	and activeflag = 1;



  -- Delete Intakeservicerequestactor
select servicecaseid,intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid in('38a5cdfb-2afd-459f-a953-2750f56c62d1','e0ae966e-f85e-446b-8dac-9d83807c6eac')
	and activeflag = 1;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-31853',
	updatedon = now()
where personid in('38a5cdfb-2afd-459f-a953-2750f56c62d1','e0ae966e-f85e-446b-8dac-9d83807c6eac')
	and activeflag = 1 ;




  -- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid in('38a5cdfb-2afd-459f-a953-2750f56c62d1','e0ae966e-f85e-446b-8dac-9d83807c6eac')
and activeflag = 1;

update personrole
set activeflag = 0,
	updatedby = 'CDM-31853',
	updatedon = now()
where personid in('38a5cdfb-2afd-459f-a953-2750f56c62d1','e0ae966e-f85e-446b-8dac-9d83807c6eac')
	and activeflag = 1;


-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
where personid in('38a5cdfb-2afd-459f-a953-2750f56c62d1','e0ae966e-f85e-446b-8dac-9d83807c6eac')
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-31853',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
where personid in('38a5cdfb-2afd-459f-a953-2750f56c62d1','e0ae966e-f85e-446b-8dac-9d83807c6eac')
		)
	and activeflag = 1;


