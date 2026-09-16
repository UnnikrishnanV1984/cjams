/*
   Issue Description: CDM-28219
   Category/ Module  : Duplicate Person
   Root cause::There are 2 Raymond Johnsons in this case. I moved the duplicate one to others and the name is "Raymond Duplicate Johnson". The duplicate person needs to be deleted from the case.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update cjams.actor 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28219'
where actorid = '32f91d70-5eca-4ae2-a4ff-b216050e41cb';

update cjams.intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28219'
where intakeservicerequestactorid = '8ce8c6d7-769c-4d89-8fb7-6762bea5176b';

update cjams.personrole p  
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28219'
where personid = '47a10ceb-bb1d-4a2a-a2c7-a9499756c746';

update cjams.actorrelationship a2 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28219'
where intakeservicerequestactorid = '8ce8c6d7-769c-4d89-8fb7-6762bea5176b';