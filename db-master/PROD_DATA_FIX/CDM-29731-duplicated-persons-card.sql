/*
   Issue Description: CDM-29731
   Category/ Module  : persons tab
   Root cause: user wants delete duplicate person form case
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update cjams.actor 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29731'
where actorid = 'f1fd355b-c663-469e-8d9d-a4677b130018';

update cjams.intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29731'
where intakeservicerequestactorid = 'fba77eb5-179c-4eef-855d-e2be7d49f400';

update cjams.personrole p  
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29731'
where personid = 'ce4cb26a-91a7-4546-bc21-14a2c81e3d85';

update cjams.actorrelationship a2 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29731'
where intakeservicerequestactorid = 'fba77eb5-179c-4eef-855d-e2be7d49f400';