/*
   Issue Description: CDM-28223
   Category/ Module  :  Others Tab in persons
   Root cause: user wants delete duplicate person form case
   Pull request# for data fix: 7867
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update cjams.actor 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28223'
where actorid = 'cbbf9b9b-cc02-4422-8ae4-8282ac9d2afe';

update cjams.intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28223'
where intakeservicerequestactorid = '9f666ac8-5fa2-4958-b1ae-be5f0f2d2b1a';

update cjams.personrole p  
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28223'
where personid = '7e704e81-dcf2-400c-8859-f2118c9864fa';

update cjams.actorrelationship a2 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28223'
where intakeservicerequestactorid = '9f666ac8-5fa2-4958-b1ae-be5f0f2d2b1a';