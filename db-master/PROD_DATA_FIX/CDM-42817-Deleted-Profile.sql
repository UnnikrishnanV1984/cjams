/*
   Issue Description: CDM-42817
   Category/ Module  : Removing person from case
   Root cause: User is requested to remove client ID # 204029429 (Mis Eseosa) from the CPS Intake that has been closed on 11/19/2024.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon 
	from actorrelationship
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '02852669-d8b1-4a48-b1c8-95f9b6a38529'
			and intakenumber = 'I241013178875'
		)	
	and activeflag = 1;
	*/

update actorrelationship
set activeflag = 0,
	updatedby = 'CDM-42817', 
	updatedon = now()
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = '02852669-d8b1-4a48-b1c8-95f9b6a38529'
			and intakenumber = 'I241013178875'
		)	
	and activeflag = 1;	

-- Perosn Roles
/*select intakeservicerequestactorid,intakenumber, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon 
	from intakeservicerequestactor
where personid = '02852669-d8b1-4a48-b1c8-95f9b6a38529'
	and intakenumber = 'I241013178875'
	and activeflag = 1 ;
	*/

update intakeservicerequestactor	
set activeflag = 0,
	updatedby = 'CDM-42817', 
	updatedon = now()
where personid = '02852669-d8b1-4a48-b1c8-95f9b6a38529'
	and intakenumber = 'I241013178875'
	and activeflag = 1 ;
	
/*select actorid, actortype, activeflag, updatedby, updatedon 
	from actor 
where personid = '02852669-d8b1-4a48-b1c8-95f9b6a38529'
	and intakenumber = 'I241013178875'
	and activeflag = 1 ;*/

update actor
set activeflag = 0,
	updatedby = 'CDM-42817', 
	updatedon = now()
where personid = '02852669-d8b1-4a48-b1c8-95f9b6a38529'
	and intakenumber = 'I241013178875'
	and activeflag = 1 ;

/*select personroleid, activeflag, updatedby, updatedon
	from personrole
where personid = '02852669-d8b1-4a48-b1c8-95f9b6a38529'
	and intakenumber = 'I241013178875'
	and activeflag = 1 ;*/

update personrole
set activeflag = 0,
	updatedby = 'CDM-42817', 
	updatedon = now()
where personid = '02852669-d8b1-4a48-b1c8-95f9b6a38529'
	and intakenumber = 'I241013178875'
	and activeflag = 1 ;