/*
   Issue Description: CDM-28460
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: User asked to delete the duplicated person
   Status of the code fix if already submitted and expected prod fix date: 
   
*/


select programkey, objectid, objecttypekey, activeflag, updatedby, updatedon 
	from personprogramarea
where personid in (	'ead38ee0-f0af-4440-94e1-d1d8b0a747a4')
	and objectid = 'ec008e66-1430-408a-a594-e17061a900a8' 
	and activeflag = 1 ;

--update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-28460',
	updatedon = now()
where personid in (	'ead38ee0-f0af-4440-94e1-d1d8b0a747a4')
	and objectid = 'ec008e66-1430-408a-a594-e17061a900a8' 
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon ,intakeserviceid
	from personrole
where personid in (	'ead38ee0-f0af-4440-94e1-d1d8b0a747a4')
	and intakeserviceid  = 'ec008e66-1430-408a-a594-e17061a900a8' 
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-28460',
	updatedon = now()
where personid in (	'ead38ee0-f0af-4440-94e1-d1d8b0a747a4')
	and intakeserviceid  = 'ec008e66-1430-408a-a594-e17061a900a8' 
	and activeflag = 1 ;


-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'ead38ee0-f0af-4440-94e1-d1d8b0a747a4')
			and intakeserviceid  = 'ec008e66-1430-408a-a594-e17061a900a8' 
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-28460',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'ead38ee0-f0af-4440-94e1-d1d8b0a747a4')
			and intakeserviceid  = 'ec008e66-1430-408a-a594-e17061a900a8' 
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid in ( 'ead38ee0-f0af-4440-94e1-d1d8b0a747a4'
				   )
	and intakeserviceid = 'ec008e66-1430-408a-a594-e17061a900a8' 
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-28460',
	updatedon = now()
where personid in ( 'ead38ee0-f0af-4440-94e1-d1d8b0a747a4'
				   )
	and intakeserviceid = 'ec008e66-1430-408a-a594-e17061a900a8' 
	and activeflag = 1 ;

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid in ( 'ead38ee0-f0af-4440-94e1-d1d8b0a747a4'
				   )
and intakeserviceid  = 'ec008e66-1430-408a-a594-e17061a900a8' 
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-28460',
	updatedon = now()
where personid in ( 'ead38ee0-f0af-4440-94e1-d1d8b0a747a4'
				   )
and intakeserviceid  = 'ec008e66-1430-408a-a594-e17061a900a8' 
	and activeflag = 1 ;

