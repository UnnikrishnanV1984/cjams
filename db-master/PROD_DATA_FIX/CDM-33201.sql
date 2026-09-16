/*
   Issue Description: CDM-33201
   Category/ Module  :Person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personrole set activeflag=0,updatedby='CDM-33201',updatedon=now() 
where personroleid='4d12998a-9767-4e35-80e2-0174b8e418e4';
update actor set activeflag=0,updatedby='CDM-33201',updatedon=now()
where
actorid='232941ec-cc42-4c0e-99c4-d4d80573e5c6';

update intakeservicerequestactor set activeflag=0,updatedby='CDM-33201',updatedon=now()
where intakeservicerequestactorid ='e4b711ae-8ebe-46c5-bbe3-ea9b89fb3bba';
update actorrelationship set activeflag=0,updatedby='CDM-33216',updatedon=now() where
intakeservicerequestactorid ='e4b711ae-8ebe-46c5-bbe3-ea9b89fb3bba';

