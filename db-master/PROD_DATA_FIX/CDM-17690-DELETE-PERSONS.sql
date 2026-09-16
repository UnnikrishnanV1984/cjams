/*
   Issue Description: CDM-17690
         Category/ Module  : need to delete persons
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to remove
  */

  update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-17690'
where actorid in ('4d206668-d91e-449d-9f5e-403185e760f6', '4538ba22-8907-44af-9ee1-42a62689e12c');

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-17690'
where intakeservicerequestactorid in ('fa4b4a87-b539-4b13-9650-aa96c8f9815a', '5ce46657-59ef-4bc8-aaca-cde71baaf21c');

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-17690'
where personroleid in ('c3e3b45b-f090-4093-8344-dc369977036a', '1ddc2721-3545-4360-8ddb-f33ab88e60eb');

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-17690'
where actorrelationshipid in ('6bda0633-75a7-47aa-811e-69001a6dffe5', 'f620d669-3589-4010-a65d-54be16e15013');