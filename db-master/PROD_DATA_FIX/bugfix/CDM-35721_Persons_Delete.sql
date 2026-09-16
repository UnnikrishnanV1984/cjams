/*
 Issue Description: CDM-35721
 Category/ Module  : 231021293183, Cjams is not allowing me to remove a person under person tab that is in the household. Case #231021293183, 
 Cjams ID#3407860, Name: This person needs to be removed from the household.
 Root cause: Person added in error
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
--------------------------
UPDATE
	cjams.personrole
SET
	activeflag = 0,
	updatedby = 'CDM-35721',
	updatedon = now()
where
	personid = '031b73bd-f820-4e9f-a736-8e9d89706d11'
	and intakeserviceid = '7e77b1d7-6d28-4817-a331-a553d65ddb77'
	and activeflag = 1;

UPDATE
	cjams.personprogramarea
SET
	activeflag = 0,
	updatedby = 'CDM-35721',
	updatedon = now()
where
	objectid = '7e77b1d7-6d28-4817-a331-a553d65ddb77'
	and personid = '031b73bd-f820-4e9f-a736-8e9d89706d11'
	and activeflag = 1;

-- updating intakeservicerequestactor table based on actorid
UPDATE
	cjams.intakeservicerequestactor
SET
	activeflag = 0,
	updatedby = 'CDM-35721',
	updatedon = now()
where
	actorid = '031b73bd-f820-4e9f-a736-8e9d89706d11'
	and activeflag = 1;

-- Querying actor relationship and actor tables
select
	*
from
	actor
where
	actorid = '00c55763-3a88-45ed-820c-3e771ff8abeb';

select
	actorrelationshipid,
	relationshiptypekey,
	activeflag,
	updatedby,
	updatedon,
	*
from
	actorrelationship
where
	intakeservicerequestactorid in (
		select
			intakeservicerequestactorid
		from
			intakeservicerequestactor
		where
			personid = '031b73bd-f820-4e9f-a736-8e9d89706d11'
			and intakeserviceid = '7e77b1d7-6d28-4817-a331-a553d65ddb77'
	)
	and activeflag = 1;

--- Updating actorrelationship and actor tables
update
	actor
set
	activeflag = 0,
	updatedby = 'CDM-35721',
	updatedon = now()
where
	actorid = '00c55763-3a88-45ed-820c-3e771ff8abeb';

update
	actorrelationship
SET
	activeflag = 0,
	updatedby = 'CDM-35721',
	updatedon = now()
where
	intakeservicerequestactorid in (
		select
			intakeservicerequestactorid
		from
			intakeservicerequestactor
		where
			personid = '031b73bd-f820-4e9f-a736-8e9d89706d11'
			and intakeserviceid = '7e77b1d7-6d28-4817-a331-a553d65ddb77'
	)
	and activeflag = 1;

-- Query personroletype
select
	*
from
	personroletype
where
	personroleid in (
		select
			personroleid
		from
			personrole
		where
			personid = '031b73bd-f820-4e9f-a736-8e9d89706d11'
			and intakenumber = 'I231011407549'
	);

--updating personroletype
update
	personroletype
SET
	activeflag = 0,
	updatedby = 'CDM-35721',
	updatedon = now()
where
	personroleid in (
		select
			personroleid
		from
			personrole
		where
			personid = '031b73bd-f820-4e9f-a736-8e9d89706d11'
			and intakenumber = 'I231011407549'
	);

---- actorid - 00c55763-3a88-45ed-820c-3e771ff8abeb
-- intakeservicerequestactorid - 38633f7c-7abb-4e2e-b8aa-58d27eeab9d6
--"intakeserviceid": "7e77b1d7-6d28-4817-a331-a553d65ddb77",
-- "securityuserid": "42a647c0-6932-4963-8095-9d9d41f5750d"
-- intakenumber - I231011407549
-- servicecaseid - 7e77b1d7-6d28-4817-a331-a553d65ddb77
--personid = 031b73bd-f820-4e9f-a736-8e9d89706d11
-- personprogramid = 90b093c9-d659-44c7-88de-fef8e6786a33
-- objectid - 7e77b1d7-6d28-4817-a331-a553d65ddb77