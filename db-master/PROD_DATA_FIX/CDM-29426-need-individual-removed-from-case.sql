/*
   Issue Description: CDM-29426
   Category/ Module  :  Others Tab in persons
   Root cause: user wants delete duplicate person form case
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update cjams.actor 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29426'
where actorid = '44707678-266d-4370-8850-1b9a9958e362';

update cjams.intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29426'
where intakeservicerequestactorid = 'aec3af96-c9ba-4b7f-bf0b-25ebef842bd4';

update cjams.personrole p  
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29426'
where personid = '878ce1ba-2a2b-401e-9f33-6d9c95a54bfc';

update cjams.actorrelationship a2 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29426'
where intakeservicerequestactorid = 'aec3af96-c9ba-4b7f-bf0b-25ebef842bd4';