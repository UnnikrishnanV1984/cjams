 /*
   Issue Description: CDM-33024
   Category/ Module  : Person
   Root cause:  User request to replace person
   Fix Provide: Did data fix to replace person in all tabs 
*/


 update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33024'
where actorid ='35235f87-4214-419b-989f-eb3bd785182c';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33024'
where intakeservicerequestactorid in('916f877a-3ddd-4df8-8171-9145185676ac') ;

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33024'
where personroleid  = '8fafdec3-6a89-4b66-ba55-14cd8b2a6149';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33024'
where intakeservicerequestactorid in('916f877a-3ddd-4df8-8171-9145185676ac') ;


update cjams.personprogramarea  set activeflag  =0, 
updatedon = now(),
updatedby = 'CDM-33024'
where personprogramid  in ('7f5b5b97-2c3e-46b9-98c5-5a2168fbfb93'); 