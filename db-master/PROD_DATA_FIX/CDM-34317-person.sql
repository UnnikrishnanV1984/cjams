    /*
   Issue Description: CDM-34317
   Category/ Module  : person
   Root cause: As requested by user
   Fix Privided: Did data fix to remove the requested person   
*/
update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-34317'
where actorid ='c192d6b0-0f67-4dde-86f2-b1d6bf1bccb7';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-34317'
where intakeservicerequestactorid in('accae440-5095-4e48-bcb2-91c684c19322') ;

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-34317'
where personroleid  = '4364905f-9e83-44e3-ad2c-c6fdc2762636';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-34317'
where actorrelationshipid in('56a1b4ae-4e05-4d0a-929e-1ecf1e8a0a29');