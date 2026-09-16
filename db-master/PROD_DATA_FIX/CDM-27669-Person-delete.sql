/*
   Issue Description: CDM-27669
   Category/ Module  : 221020282700:Cjams is not allowing me to remove a person under person tab that is in the household. Case #221029282700, 
   Cjams ID# 200998777, Name: Jesus Deras Menjivar, DOB: 01/01/1910. This person needs to be removed from the household..
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

-- Delete Program Assignment(s)
select programkey, objectid, objecttypekey, activeflag, updatedby, updatedon 
	from personprogramarea
  where personid ='2e2149c4-4005-4818-99d9-3da2d5951c63'
	and objectid = '7bcf5384-8878-4521-83d3-fbb759c83994' 
	and activeflag = 1;
	
update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-27669',
	updatedon = now()
where personid ='2e2149c4-4005-4818-99d9-3da2d5951c63'
	and objectid = '7bcf5384-8878-4521-83d3-fbb759c83994' 
	and activeflag = 1;

  -- Delete Intakeservicerequestactor
select servicecaseid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid ='2e2149c4-4005-4818-99d9-3da2d5951c63'
	and activeflag = 1;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CIDM-27669',
	updatedon = now()
where personid ='2e2149c4-4005-4818-99d9-3da2d5951c63'
	and activeflag = 1 ;

  -- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid ='2e2149c4-4005-4818-99d9-3da2d5951c63'
and activeflag = 1;

update personrole
set activeflag = 0,
	updatedby = 'CIDM-27669',
	updatedon = now()
where personid ='2e2149c4-4005-4818-99d9-3da2d5951c63'
	and activeflag = 1;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid ='2e2149c4-4005-4818-99d9-3da2d5951c63'
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CIDM-27669',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid ='2e2149c4-4005-4818-99d9-3da2d5951c63'
		)
	and activeflag = 1;

