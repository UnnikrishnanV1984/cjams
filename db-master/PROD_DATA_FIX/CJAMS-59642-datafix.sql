-- CJAMS-59642 Remove Person

/*
-- Issue Description: 
	251023034467:Person entered as "Unknown Unknown" to be deleted from case due to person being entered into the system twice
   
client ID# 204119263 from the CPS IR # 251023034467

-- Category/ Module: Persons
-- Root cause: Person entered as "Unknown Unknown" to be deleted from case due to person being entered into the system twice
-- Resolution: Removed a person from the persons other tab by setting active flag to 0.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea
set activeflag = 0,
	updatedby = 'CJAMS-59642',
	updatedon = now()
where personid = '43b2e71a-21d1-44a4-921e-46d609be2d2a'
	and objectid = '74b98c96-766e-4d34-a131-1370f2fa4173' 
	and activeflag = 1 ;

    update personrole
set activeflag = 0,
	updatedby = 'CJAMS-59642',
	updatedon = now()
where personid = '43b2e71a-21d1-44a4-921e-46d609be2d2a'
	and intakeserviceid  = '74b98c96-766e-4d34-a131-1370f2fa4173'
	and activeflag = 1 ;

    update actorrelationship	
set activeflag = 0,
	updatedby = 'CJAMS-59642',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '43b2e71a-21d1-44a4-921e-46d609be2d2a'
	and intakeserviceid  = '74b98c96-766e-4d34-a131-1370f2fa4173'
		)
	and activeflag = 1 ;

    update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CJAMS-59642',
	updatedon = now()
where personid = '43b2e71a-21d1-44a4-921e-46d609be2d2a'
	and intakeserviceid  = '74b98c96-766e-4d34-a131-1370f2fa4173'
	and activeflag = 1 ;

    update actor
set activeflag = 0,
	updatedby = 'CJAMS-59642',
	updatedon = now()
where personid = '43b2e71a-21d1-44a4-921e-46d609be2d2a'
	and intakeserviceid  = '74b98c96-766e-4d34-a131-1370f2fa4173'
	and activeflag = 1 ;


update personroletype 
		set  activeflag = 0,
			 updatedby = 'CJAMS-59642',
			 updatedon = now()
		where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '43b2e71a-21d1-44a4-921e-46d609be2d2a'
	and intakeserviceid  = '74b98c96-766e-4d34-a131-1370f2fa4173');