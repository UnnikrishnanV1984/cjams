/*
   Issue Description: CDM-21271
   Category/ Module  : Person delete  
   Root cause: User requested to delete the person from case
   Pull request# for code fix: 4201
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--select * from person where personid in ( '81acf21e-9a91-4353-bb2d-5fc7bfb12cd6', 'eef55aca-8233-4268-95b8-e6feb90082c2')
--Shannon McCahan, DOB 10/13/83. 81acf21e-9a91-4353-bb2d-5fc7bfb12cd6
-- Relationship

update actorrelationship
set activeflag = 0,
	updatedby = 'CDM-21271', 
	updatedon = now()
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = 'ab6b22f1-0aec-4cf8-8ec4-aaa88ec47181'
			and intakeserviceid = '3008ab88-224b-41c6-ae66-4d9a7131d62d'
		)	
	and activeflag = 1;	

-- Perosn Roles
	
update intakeservicerequestactor	
set activeflag = 0,
	updatedby = 'CDM-21271', 
	updatedon = now()
where personid = 'ab6b22f1-0aec-4cf8-8ec4-aaa88ec47181'
			and intakeserviceid = '3008ab88-224b-41c6-ae66-4d9a7131d62d'
	and activeflag = 1 ;
	
--actor

update actor
set activeflag = 0,
	updatedby = 'CDM-21271', 
	updatedon = now()
where personid = 'ab6b22f1-0aec-4cf8-8ec4-aaa88ec47181'
			and intakeserviceid = '3008ab88-224b-41c6-ae66-4d9a7131d62d'
	and activeflag = 1 ;

--personrole
update personrole
set activeflag = 0,
	updatedby = 'CDM-21271', 
	updatedon = now()
where personid = 'ab6b22f1-0aec-4cf8-8ec4-aaa88ec47181'
			and intakeserviceid = '3008ab88-224b-41c6-ae66-4d9a7131d62d'
	and activeflag = 1 ;
	