/*
   Issue Description: CDM-19017
   Category/ Module  : Persons
   Root cause: HOH change for parent in 2 roles
   Pull request# for code fix: 
   Reason why no related code fix: needs complete input to change code
   Status of the code fix if already submitted and expected prod fix date: 
*/
 
SELECT * FROM intakeservicerequestactor as iar where iar.intakenumber = 'I211010211631';

update intakeservicerequestactor 
set isprimary = false, 
updatedby='CDM-19017', updatedon=now() 
where intakeservicerequestactorid in ('c5cad6b8-dbd9-4db7-a7ef-bc7e76177d4c');

update intakeservicerequestactor 
set isprimary = true, 
updatedby='CDM-19017', updatedon=now() 
where intakeservicerequestactorid in ('9e96ea75-ce6d-4cdc-8a9f-536d87755719');
