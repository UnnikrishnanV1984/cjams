/*
   Issue Description: CDM-24294
   Category/ Module  : Sercicecase
   Root cause: Duplicate service case.

   Reason why no related code fix: User wanted to delete the duplicate service case.
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	cjams.actor 
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-24294'
where 	personid = '648afcb6-9daf-4518-9908-6b4ea4c7fe58' 
        and servicecaseid = '4ef3336a-9fe9-46fe-9bca-ab8ebe57a816' 
        and activeflag = 1;

update 	cjams.intakeservicerequestactor
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-24294'
where 	personid = '648afcb6-9daf-4518-9908-6b4ea4c7fe58' 
        and servicecaseid = '4ef3336a-9fe9-46fe-9bca-ab8ebe57a816' 
        and activeflag = 1;


update 	cjams.personrole   
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-24294'
where 	personid = '648afcb6-9daf-4518-9908-6b4ea4c7fe58' 
        and servicecaseid = '4ef3336a-9fe9-46fe-9bca-ab8ebe57a816' 
        and activeflag = 1;


update 	cjams.actorrelationship  
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-24294'
where 	activeflag = 1 
        and intakeservicerequestactorid in 
        (select i.intakeservicerequestactorid 
        from    intakeservicerequestactor i 
        where   i.personid = '648afcb6-9daf-4518-9908-6b4ea4c7fe58' 
                and i.servicecaseid = '4ef3336a-9fe9-46fe-9bca-ab8ebe57a816');

update 	cjams.servicecase 
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-24294'
where 	servicecaseid = '4ef3336a-9fe9-46fe-9bca-ab8ebe57a816' 
        and activeflag = 1;

update 	cjams.caseassignment 
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-24294'
where 	objectid = '4ef3336a-9fe9-46fe-9bca-ab8ebe57a816' 
        and activeflag = 1;
        
update 	cjams.servicecasedisposition 
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-24294'
where 	servicecaseid = '4ef3336a-9fe9-46fe-9bca-ab8ebe57a816' 
        and activeflag = 1;