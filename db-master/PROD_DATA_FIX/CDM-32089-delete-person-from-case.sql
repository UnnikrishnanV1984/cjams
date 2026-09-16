/*
   Issue Description: CDM-32089
   Category/ Module  : Persons
   Root cause: User wants to delete the person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update cjams.intakeservicerequestactor  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32089'
where intakeservicerequestactorid= '9b8aca10-b5af-4340-be47-9aa43ceb6a90';

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32089'
where actorid ='476edd32-338e-4153-8860-c63dbd4e8b46';

update cjams.personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32089'
where personroleid  = '85d2d79c-9569-4664-a989-cd2fbb10ec5e';


update cjams.actorrelationship 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32089'
where intakeservicerequestactorid ='9b8aca10-b5af-4340-be47-9aa43ceb6a90';