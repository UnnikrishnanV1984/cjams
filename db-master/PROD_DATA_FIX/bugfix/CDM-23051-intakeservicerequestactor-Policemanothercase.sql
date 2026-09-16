-- CDM-23051 - Policeman put as other in a case.
/*
-- Issue Description: 
   User request to remove the person Khalil Mitchell (CJAMS PID# S20220160041472) from the Service case 221030016457
  
-- Case ID: 221030016457 - c03b25b6-c3a8-455c-bfd4-7fb8e720a2ef

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon from actorrelationship
where intakeservicerequestactorid = '00d8e60c-ed44-445f-8568-5e2a3e149655' 
	and activeflag = 1;

update actorrelationship
set activeflag = 0, updatedby = 'CDM-23051', updatedon = now()
where intakeservicerequestactorid = '00d8e60c-ed44-445f-8568-5e2a3e149655' 
	and activeflag = 1 
	and person1id = '71841e00-0b68-45d4-8261-0e14190ea554';

-- Perosn Roles
select intakeservicerequestactorid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon from intakeservicerequestactor
where activeflag = 1 
	and personid = '71841e00-0b68-45d4-8261-0e14190ea554' 
	and servicecaseid = 'c67af42b-25d0-4cf5-9c3f-17e1d104ca18';


update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-23051', updatedon = now()
where intakeservicerequestactorid = '00d8e60c-ed44-445f-8568-5e2a3e149655'	
	and personid = '71841e00-0b68-45d4-8261-0e14190ea554' 
	and servicecaseid = 'c67af42b-25d0-4cf5-9c3f-17e1d104ca18'
	and activeflag = 1;
	  
select actorid, actortype, activeflag, updatedby, updatedon from actor 
where personid = '71841e00-0b68-45d4-8261-0e14190ea554' 
	and servicecaseid = 'c67af42b-25d0-4cf5-9c3f-17e1d104ca18' 
	and activeflag = 1 ;

update actor set activeflag = 0, updatedby = 'CDM-23051', updatedon = now()
where actorid = '481430ef-d88b-408e-9bf4-54f895813205'
	and personid = '71841e00-0b68-45d4-8261-0e14190ea554' 
	and servicecaseid = 'c67af42b-25d0-4cf5-9c3f-17e1d104ca18' 
	and activeflag = 1 ;

select personroleid, activeflag, updatedby, updatedon from personrole
	where personid = '71841e00-0b68-45d4-8261-0e14190ea554' 
	and servicecaseid = 'c67af42b-25d0-4cf5-9c3f-17e1d104ca18' 
	and activeflag = 1 ;

update personrole set activeflag = 0, updatedby = 'CDM-23051', updatedon = now()
where personid = '71841e00-0b68-45d4-8261-0e14190ea554' 
	and servicecaseid = 'c67af42b-25d0-4cf5-9c3f-17e1d104ca18' 
	and activeflag = 1 ;