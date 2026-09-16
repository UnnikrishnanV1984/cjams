-- CDM-28272 - Need to remove other persons based on the screenshot
/*
-- Issue Description: 

	231020316524: added the wrong last name to this case for Colton Becker. 
	This child does not exist and should be deleted from the system.
	
	case: 231020316524
	person: Colton S Clark
	CJAMS PID: 201026388 is in HOUSE HOLD is the original 

	person: Colton Clark
	CJAMS PID: 201026388 is in OTHERS is the duplicate
	Person in OTHERS TAB is a duplicate and has to be removed 

	CPS-AR : 231020316524
	"personid":"b603f5ed-853b-4af6-976c-1089255400df"
	"intakeserviceid":"be90a430-edf5-4608-a03a-3881c82dc8c1"
	-- Colton Clark

*/

-- Delete Program Assignment(s)
select programkey, objectid, objecttypekey, activeflag, updatedby, updatedon 
	from personprogramarea
where personid in (	'b603f5ed-853b-4af6-976c-1089255400df'
				  )
	and objectid = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-28272',
	updatedon = now()
where personid in (	'b603f5ed-853b-4af6-976c-1089255400df'
				  )
	and objectid = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid in (	'b603f5ed-853b-4af6-976c-1089255400df'
				  )
	and intakeserviceid  = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-28272',
	updatedon = now()
where personid in (	'b603f5ed-853b-4af6-976c-1089255400df'
				  )
	and intakeserviceid  = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'b603f5ed-853b-4af6-976c-1089255400df'
				   )
			and intakeserviceid  = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-28272',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'b603f5ed-853b-4af6-976c-1089255400df'
				   )
			and intakeserviceid = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid in ( 'b603f5ed-853b-4af6-976c-1089255400df'
				   )
	and intakeserviceid = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-28272',
	updatedon = now()
where personid in ( 'b603f5ed-853b-4af6-976c-1089255400df'
				   )
	and intakeserviceid = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
	and activeflag = 1 ;

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid in ( 'b603f5ed-853b-4af6-976c-1089255400df'
				   )
and intakeserviceid  = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-28272',
	updatedon = now()
where personid in ( 'b603f5ed-853b-4af6-976c-1089255400df'
				   )
and intakeserviceid  = 'be90a430-edf5-4608-a03a-3881c82dc8c1' 
	and activeflag = 1 ;