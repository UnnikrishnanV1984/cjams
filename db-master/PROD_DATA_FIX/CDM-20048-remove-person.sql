/*
   Issue Description: CDM-20048
   Category/ Module  : Removing person from case
   Root cause: user requeseted to remove person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon 
	from actorrelationship
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = 'e2c77f4b-77e1-4e34-8059-b55a0ca4248b'
			and intakeserviceid = '3f11bb8b-9b2c-45f8-8a52-a697455eb01c'
		)	
	and activeflag = 1;
	
update actorrelationship
set activeflag = 0,
	updatedby = 'CDM-20048', 
	updatedon = now()
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = 'e2c77f4b-77e1-4e34-8059-b55a0ca4248b'
			and intakeserviceid = '3f11bb8b-9b2c-45f8-8a52-a697455eb01c'
		)	
	and activeflag = 1;	

-- Perosn Roles
select intakeservicerequestactorid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon 
	from intakeservicerequestactor
where personid = 'e2c77f4b-77e1-4e34-8059-b55a0ca4248b'
	and intakeserviceid = '3f11bb8b-9b2c-45f8-8a52-a697455eb01c'
	and activeflag = 1 ;
	
update intakeservicerequestactor	
set activeflag = 0,
	updatedby = 'CDM-20048', 
	updatedon = now()
where personid = 'e2c77f4b-77e1-4e34-8059-b55a0ca4248b'
	and intakeserviceid = '3f11bb8b-9b2c-45f8-8a52-a697455eb01c'
	and activeflag = 1 ;
	
select actorid, actortype, activeflag, updatedby, updatedon 
	from actor 
where personid = 'e2c77f4b-77e1-4e34-8059-b55a0ca4248b'
	and intakeserviceid = '3f11bb8b-9b2c-45f8-8a52-a697455eb01c'
	and activeflag = 1 ;

update actor
set activeflag = 0,
	updatedby = 'CDM-20048', 
	updatedon = now()
where personid = 'e2c77f4b-77e1-4e34-8059-b55a0ca4248b'
	and intakeserviceid = '3f11bb8b-9b2c-45f8-8a52-a697455eb01c'
	and activeflag = 1 ;

select personroleid, activeflag, updatedby, updatedon
	from personrole
where personid = 'e2c77f4b-77e1-4e34-8059-b55a0ca4248b'
	and intakeserviceid = '3f11bb8b-9b2c-45f8-8a52-a697455eb01c'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-20048', 
	updatedon = now()
where personid = 'e2c77f4b-77e1-4e34-8059-b55a0ca4248b'
	and intakeserviceid = '3f11bb8b-9b2c-45f8-8a52-a697455eb01c'
	and activeflag = 1 ;