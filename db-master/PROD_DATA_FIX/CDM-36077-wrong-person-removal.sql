/*
   Issue Description: CDM-36077
   Category/ Module  : person
   Root cause: As requested by user
   Fix Privided: Did data fix to remove the requested person   
*/

select servicecaseid,intakenumber,activeflag,* from actor where personid ='47b0868c-7013-43ae-9033-198d7d606b61';

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36077'
where actorid in ('a6f25584-7c7c-4272-a410-d61f51f45bc3');

select servicecaseid,intakenumber,activeflag,* from intakeservicerequestactor where personid ='47b0868c-7013-43ae-9033-198d7d606b61';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36077'
where intakeservicerequestactorid in('6869b400-14b6-4284-ba1b-edbae0b88140', '8c4d4856-6241-47f2-817a-1286ca42acaf');

select servicecaseid,* from personrole where personid ='47b0868c-7013-43ae-9033-198d7d606b61';

select * from personrole where personroleid ='3fbad881-f18e-484b-b802-e6b535be2556';

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36077'
where personroleid in ('3fbad881-f18e-484b-b802-e6b535be2556');

select servicecaseid,intakenumber,intakeservicerequestactorid,* from actorrelationship where intakeservicerequestactorid in('8c4d4856-6241-47f2-817a-1286ca42acaf') and activeflag ='1';

select * from actorrelationship where actorrelationshipid ='77193c39-5e62-465b-bed0-09a2addb4f61';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36077'
where intakeservicerequestactorid in('6869b400-14b6-4284-ba1b-edbae0b88140', '8c4d4856-6241-47f2-817a-1286ca42acaf');

select * from personroletype 
where personroleid in ('3fbad881-f18e-484b-b802-e6b535be2556');

update cjams.personroletype
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36077'
where personroleid in ('3fbad881-f18e-484b-b802-e6b535be2556');