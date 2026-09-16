/*
-- Issue Description: 
	261023613799:Person entered as "Whitney Mann" to be deleted from case.
   
client ID# 	204768727 from the CPS IR # 261023613799

-- Category/ Module: Persons
-- Root cause: user error,Person entered as "Whitney Mann" to be deleted from case 
-- Resolution: Removed a person from the persons other tab by setting active flag to 0.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea
set activeflag = 0,
	updatedby = 'CJAMS-65558',
	updatedon = now()
where personid = '96dcce49-c4b7-49e1-9285-1b6dfd294d83'
	and objectid = '704dd1e0-9041-4818-84c7-60fc049d4514' 
	and activeflag = 1 ;

    update personrole
set activeflag = 0,
	updatedby = 'CJAMS-65558',
	updatedon = now()
where personid = '96dcce49-c4b7-49e1-9285-1b6dfd294d83'
	and intakeserviceid  = '704dd1e0-9041-4818-84c7-60fc049d4514'
	and activeflag = 1 ;

    update actorrelationship	
set activeflag = 0,
	updatedby = 'CJAMS-65558',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '96dcce49-c4b7-49e1-9285-1b6dfd294d83'
	and intakeserviceid  = '704dd1e0-9041-4818-84c7-60fc049d4514'
		)
	and activeflag = 1 ;

    update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CJAMS-65558',
	updatedon = now()
where personid = '96dcce49-c4b7-49e1-9285-1b6dfd294d83'
	and intakeserviceid  = '704dd1e0-9041-4818-84c7-60fc049d4514'
	and activeflag = 1 ;

    update actor
set activeflag = 0,
	updatedby = 'CJAMS-65558',
	updatedon = now()
where personid = '96dcce49-c4b7-49e1-9285-1b6dfd294d83'
	and intakeserviceid  = '704dd1e0-9041-4818-84c7-60fc049d4514'
	and activeflag = 1 ;


update personroletype 
		set  activeflag = 0,
			 updatedby = 'CJAMS-65558',
			 updatedon = now()
		where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '96dcce49-c4b7-49e1-9285-1b6dfd294d83'
	and intakeserviceid  = '704dd1e0-9041-4818-84c7-60fc049d4514');