/*
   Issue Description: CDM-29655
   Category/ Module  : User wants to delete the person
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-29655'
where actorid ='52e79dd7-130e-4ce6-968f-8fc0c76e8fb0';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-29655'
where intakeservicerequestactorid= '2baf7e73-fbcd-485a-8eb5-b1721ff183eb';

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-29655'
where personroleid  = '081edfb1-6405-4516-b265-b005dfe3505e';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-29655'
where actorrelationshipid ='0597eea6-08d9-43a5-8ddc-a394b865c4b6';