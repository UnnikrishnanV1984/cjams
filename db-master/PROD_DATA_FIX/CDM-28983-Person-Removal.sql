/*
   Issue Description: CDM-28983
   Category/ Module  : Persons Tab
   Root cause: user wants to delete the person from others
   Pull request# for data fix: 8105
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
update cjams.actor set activeflag = 0,updatedon = now(),updatedby = 'CDM-28983'
where actorid = 'e65e8136-d1ae-4982-b915-972526bbae36';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28983'
where intakeservicerequestactorid = 'e65f2b6c-7c07-40de-8a94-79b32940c949';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28983'
where intakeservicerequestactorid = 'e65f2b6c-7c07-40de-8a94-79b32940c949';