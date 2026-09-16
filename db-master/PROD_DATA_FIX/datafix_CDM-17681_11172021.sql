-- CDM-17681 - Wrong Client
/*
-- Issue Description: 
   User request to remove the person Alexis H Wagner (CJAMS PID# 200807806) from the Service case 3211097
  
-- Case ID: 3211097 - c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef
-- Client ID: 200807806	(Alexis H Wagner) - 535161c3-531e-4e28-b315-72ba73d2ed8a

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to delete Client # 200807806 from Service Case # 3211097 
-- Relationship
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon 
	from actorrelationship
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = '535161c3-531e-4e28-b315-72ba73d2ed8a'
			and servicecaseid = 'c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef'
		)	
	and activeflag = 1;
	
update actorrelationship
set activeflag = 0,
	updatedby = 'CDM-17681', 
	updatedon = now()
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = '535161c3-531e-4e28-b315-72ba73d2ed8a'
			and servicecaseid = 'c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef'
		)	
	and activeflag = 1;	

-- Perosn Roles
select intakeservicerequestactorid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon 
	from intakeservicerequestactor
where personid = '535161c3-531e-4e28-b315-72ba73d2ed8a'
	and servicecaseid = 'c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef'
	and activeflag = 1 ;
	
update intakeservicerequestactor	
set activeflag = 0,
	updatedby = 'CDM-17681', 
	updatedon = now()
where personid = '535161c3-531e-4e28-b315-72ba73d2ed8a'
	and servicecaseid = 'c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef'
	and activeflag = 1 ;
	
select actorid, actortype, activeflag, updatedby, updatedon 
	from actor 
where personid = '535161c3-531e-4e28-b315-72ba73d2ed8a'
	and servicecaseid = 'c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef'
	and activeflag = 1 ;

update actor
set activeflag = 0,
	updatedby = 'CDM-17681', 
	updatedon = now()
where personid = '535161c3-531e-4e28-b315-72ba73d2ed8a'
	and servicecaseid = 'c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef'
	and activeflag = 1 ;

select personroleid, activeflag, updatedby, updatedon
	from personrole
where personid = '535161c3-531e-4e28-b315-72ba73d2ed8a'
	and servicecaseid = 'c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-17681', 
	updatedon = now()
where personid = '535161c3-531e-4e28-b315-72ba73d2ed8a'
	and servicecaseid = 'c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef'
	and activeflag = 1 ;
	
