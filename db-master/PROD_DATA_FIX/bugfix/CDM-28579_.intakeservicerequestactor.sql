/*
   Issue Description: CDM-28579
   Category/ Module  :  Remove person from case as requested by user
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-28579', updatedon=now(), activeflag = 0
WHERE intakeservicerequestactorid='0cd4bc82-16a8-4522-9639-8c104dc01090' and personid='612767b4-4b6e-483a-a710-ffc35671a819';

UPDATE cjams.actor
SET updatedby='CDM-28579', updatedon=now(), activeflag = 0
WHERE actorid='76e9a253-a2cc-4320-9112-f14d9137a24f' and personid='612767b4-4b6e-483a-a710-ffc35671a819';

update cjams.personrole  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28579'
where personroleid = '21abf658-3ad0-4945-8cf9-41143f0c8bab';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28579'
where actorrelationshipid = '601dd464-f208-402a-a40a-02bd16877111';