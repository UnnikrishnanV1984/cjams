
/*
   Issue Description: CDM-19712
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
		where personid = '780f1d6d-3329-4aae-9881-17a28f256b21'
			and intakeserviceid = '68f7e0fd-38b2-4308-8356-ef789cb5b0db'
		)	
	and activeflag = 1;
	
update actorrelationship
set activeflag = 0,
	updatedby = 'CDM-19712', 
	updatedon = now()
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = '780f1d6d-3329-4aae-9881-17a28f256b21'
			and intakeserviceid = '68f7e0fd-38b2-4308-8356-ef789cb5b0db'
		)	
	and activeflag = 1;	

-- Perosn Roles
select intakeservicerequestactorid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon 
	from intakeservicerequestactor
where personid = '780f1d6d-3329-4aae-9881-17a28f256b21'
	and intakeserviceid = '68f7e0fd-38b2-4308-8356-ef789cb5b0db'
	and activeflag = 1 ;
	
update intakeservicerequestactor	
set activeflag = 0,
	updatedby = 'CDM-19712', 
	updatedon = now()
where personid = '780f1d6d-3329-4aae-9881-17a28f256b21'
	and intakeserviceid = '68f7e0fd-38b2-4308-8356-ef789cb5b0db'
	and activeflag = 1 ;
	
select actorid, actortype, activeflag, updatedby, updatedon 
	from actor 
where personid = '780f1d6d-3329-4aae-9881-17a28f256b21'
	and intakeserviceid = '68f7e0fd-38b2-4308-8356-ef789cb5b0db'
	and activeflag = 1 ;

update actor
set activeflag = 0,
	updatedby = 'CDM-19712', 
	updatedon = now()
where personid = '780f1d6d-3329-4aae-9881-17a28f256b21'
	and intakeserviceid = '68f7e0fd-38b2-4308-8356-ef789cb5b0db'
	and activeflag = 1 ;

select personroleid, activeflag, updatedby, updatedon
	from personrole
where personid = '780f1d6d-3329-4aae-9881-17a28f256b21'
	and intakeserviceid = '68f7e0fd-38b2-4308-8356-ef789cb5b0db'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-19712', 
	updatedon = now()
where personid = '780f1d6d-3329-4aae-9881-17a28f256b21'
	and intakeserviceid = '68f7e0fd-38b2-4308-8356-ef789cb5b0db'
	and activeflag = 1 ;
