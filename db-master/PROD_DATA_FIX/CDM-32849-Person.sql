/*
   Issue Description: CDM-32849
   Category/ Module  :  person
   Root cause: user wants to rename the remove the persons 
    Fix Provided: Did data fix to remove persons and personprogramareas  
*/

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32849'
where actorid ='b1dd4264-c5bf-498f-b394-18c7a2c49678';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32849'
where intakeservicerequestactorid in('ce415d57-a55b-459f-8f6e-e31006e2f223','47ff24d6-7d18-41ce-af6d-7ee091a59e61') ;

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32849'
where personroleid  = '1792a2af-5a61-4a0a-ab0b-619a06c5d4bc';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32849'
where intakeservicerequestactorid in('ce415d57-a55b-459f-8f6e-e31006e2f223','47ff24d6-7d18-41ce-af6d-7ee091a59e61') ;


update cjams.personprogramarea set activeflag =0, updatedon = now(),
updatedby = 'CDM-32849'
where personprogramid ='6bcacedb-15e1-4f97-bb4f-36c917030881';



update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32849'
where actorid ='663c1328-5958-4519-b4a6-68658fac111a';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32849'
where intakeservicerequestactorid in('e0ec52f6-f57f-4775-bab5-906c332915fd') ;

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32849'
where personroleid  = '9d2dbdc4-6b87-4ace-b983-f2b7e343e479';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32849'
where actorrelationshipid in('e920ceb7-e17e-40d4-baf6-13a148385ff3') ;


update cjams.personprogramarea set activeflag =0, updatedon = now(),
updatedby = 'CDM-32849'
where personprogramid ='e6a84cd4-1f0e-4b18-a62b-98953ea88f16';