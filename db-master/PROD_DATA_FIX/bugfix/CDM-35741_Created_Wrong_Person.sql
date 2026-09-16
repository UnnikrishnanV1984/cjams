/*
 Issue Description: CDM-35741
 Category/ Module  : Case>Persons
 Root cause: Person needs to be removed from intake and service cases
 Pull request# for data fix: Removed the person's connection to the cases
 Reason why no related code fix:  
 Status of the code fix if already submitted and expected prod fix date: 
 */
update
   intakeservicerequestactor
set
   activeflag = 0,
   updatedby = 'CDM-35741',
   updatedon = now()
where
   personid = '0336dfcc-de52-402b-b454-38f8b6c5481a'
   and intakenumber = 'I231011591393'
   and activeflag = 1;

update
   cjams.actor
set
   activeflag = 0,
   updatedby = 'CDM-35741',
   updatedon = now()
where
   personid = '0336dfcc-de52-402b-b454-38f8b6c5481a'
   and actorid = '15c02104-1586-4ccc-a746-ac934706936d';

update
   personrole
set
   activeflag = 0,
   updatedby = 'CDM-35741',
   updatedon = now()
where
   personroleid = 'dde31edf-6e23-4ec8-963e-0d100f79c47d';

update
   actorrelationship
set
   activeflag = 0,
   updatedby = 'CDM-35741',
   updatedon = now()
where
   intakeservicerequestactorid = '9a4103a0-c5c4-42ae-ae48-f2c0abbc797b';