/*
   Issue Description: CDM-16768
   Category/ Module  : Incorrect rferal assigned to child
   Root cause: incorrect person(child) was added to the case in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
 
 
update intakeservicerequest set servicecaseid = '5d071c9a-9701-43e6-8a1c-0613fb28b43b', updatedby ='CDM-17868', updatedon= now() where intakenumber='I211010204310';

update servicecase 
set activeflag =0, updatedon =now(), updatedby ='CDM-17868'
where servicecaseid ='6a6404b9-fcb4-4dcd-abf6-206407f50944';

update intakeservicerequestactor
set activeflag =0, updatedon =now(), updatedby ='CDM-17868'
where servicecaseid ='6a6404b9-fcb4-4dcd-abf6-206407f50944';




