
/*
   Issue Description: CDM-31074
   Category/ Module  : User wants to delete the person from intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31074'
where actorid ='96688094-dc07-48ec-953c-66d0de3ac878';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31074'
where intakeservicerequestactorid in('9a63c8c7-eb24-41e8-a1aa-346f21f87afd','a8407971-4350-406d-9ff0-a28bd9a62abe') ;

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31074'
where personroleid  = '89b4bfca-725a-4d8e-8b69-98f48fc21913';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31074'
where actorrelationshipid in('56edfc8e-bd6f-4907-a326-614f1693b66c','375f9cc4-ca46-44dd-9440-5f1dcab2ea9d');