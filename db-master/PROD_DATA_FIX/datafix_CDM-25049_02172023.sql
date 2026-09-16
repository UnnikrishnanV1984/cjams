/*
	CDM-25049 - Wrong Cjams # entered on case see attached note
	I221010312551:Please removed CJAMS # 200952591 for this child, this number belongs to another child.ThanksKarol Alston
	
	We will proceed with the data fix to remove the Client 200952594 from both the Intake (I221010312551) and Service case (221030018433).
	
	select intakeserviceid, * from intakeservicerequest where intakenumber = 'I221010312551'

	select actorid,* from actor where 
	personid = 'cf654348-04da-4641-b186-b50a31fd3bdd' and 
	intakeserviceid = '46373af5-3563-41b8-86ff-5cd617403343' and 
	activeflag = 1;

	select intakeservicerequestactorid, * from intakeservicerequestactor where 
	personid = 'cf654348-04da-4641-b186-b50a31fd3bdd' and 
	intakeserviceid = '46373af5-3563-41b8-86ff-5cd617403343' and 
	actorid = 'e5516e3e-4388-484b-bb3c-487afdf92422' and 
	activeflag = 1;

--	intakeservicerequestactorid = 'b85ee5a2-1eb2-4b98-b93d-77948c37017c'

	select intakeserviceid,* from intakeservicerequest where servicecaseid = '9529a027-46a0-4a8c-8f2c-c380dd8cb153'
*/

-- Delete Program Assignment(s)
select programkey, objectid, objecttypekey, activeflag, updatedby, updatedon 
	from personprogramarea
where personid in (	'cf654348-04da-4641-b186-b50a31fd3bdd'
				  )
	and objectid = '46373af5-3563-41b8-86ff-5cd617403343' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-25049',
	updatedon = now()
where personid in (	'cf654348-04da-4641-b186-b50a31fd3bdd'
				  )
	and objectid = '46373af5-3563-41b8-86ff-5cd617403343' 
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid in (	'cf654348-04da-4641-b186-b50a31fd3bdd'
				  )
	and intakeserviceid  = '46373af5-3563-41b8-86ff-5cd617403343' 
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-25049',
	updatedon = now()
where personid in (	'cf654348-04da-4641-b186-b50a31fd3bdd'
				  )
	and intakeserviceid  = '46373af5-3563-41b8-86ff-5cd617403343' 
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'cf654348-04da-4641-b186-b50a31fd3bdd'
				   )
			and intakeserviceid  = '46373af5-3563-41b8-86ff-5cd617403343' 
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-25049',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'cf654348-04da-4641-b186-b50a31fd3bdd'
				   )
			and intakeserviceid = '46373af5-3563-41b8-86ff-5cd617403343' 
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid in ( 'cf654348-04da-4641-b186-b50a31fd3bdd'
				   )
	and intakeserviceid = '46373af5-3563-41b8-86ff-5cd617403343' 
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-25049',
	updatedon = now()
where personid in ( 'cf654348-04da-4641-b186-b50a31fd3bdd'
				   )
	and intakeserviceid = '46373af5-3563-41b8-86ff-5cd617403343' 
	and activeflag = 1 ;

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid in ( 'cf654348-04da-4641-b186-b50a31fd3bdd'
				   )
and intakeserviceid  = '46373af5-3563-41b8-86ff-5cd617403343' 
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-25049',
	updatedon = now()
where personid in ( 'cf654348-04da-4641-b186-b50a31fd3bdd'
				   )
and intakeserviceid  = '46373af5-3563-41b8-86ff-5cd617403343' 
	and activeflag = 1 ;	