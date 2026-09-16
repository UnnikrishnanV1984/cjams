/*
   Issue Description: CDM-30424
   Category/ Module  : Persons tab
   Root cause: User requested to remove the kid from case which added bymistake
   Pull request# for code fix: 8711
   Reason why no related code fix: 
    requested a data fix to resolve
*/


-- Delete Program Assignment(s)
select programkey, objectid, objecttypekey, activeflag, updatedby, updatedon 
	from personprogramarea
where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
	and objectid = '967ca013-1170-4c54-ab7b-b4de006acd1b' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-30424',
	updatedon = now()
where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
	and objectid = '967ca013-1170-4c54-ab7b-b4de006acd1b' 
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
	and intakeserviceid  = '967ca013-1170-4c54-ab7b-b4de006acd1b'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-30424',
	updatedon = now()
where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
	and intakeserviceid  = '967ca013-1170-4c54-ab7b-b4de006acd1b'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
			and intakeserviceid  = '967ca013-1170-4c54-ab7b-b4de006acd1b'
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-30424',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
			and intakeserviceid = '967ca013-1170-4c54-ab7b-b4de006acd1b'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
	and intakeserviceid = '967ca013-1170-4c54-ab7b-b4de006acd1b'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-30424',
	updatedon = now()
where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
	and intakeserviceid = '967ca013-1170-4c54-ab7b-b4de006acd1b'
	and activeflag = 1 ;

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
and intakeserviceid  = '967ca013-1170-4c54-ab7b-b4de006acd1b'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-30424',
	updatedon = now()
where personid = 'edda5663-fac4-4f27-984a-df46836a29da'
and intakeserviceid  = '967ca013-1170-4c54-ab7b-b4de006acd1b'
	and activeflag = 1 ;