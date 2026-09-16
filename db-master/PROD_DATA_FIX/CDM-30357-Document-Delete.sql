/*
   Issue Description: CDM-30357
   Category/ Module  : documents tab
   Root cause: As case is closed user wants to delete the document which was added bymistake
   Pull request# for data fix: 8651
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/

update documentproperties set activeflag = 0, updatedby = 'CDM-30357', 
updatedon = now() where documentpropertiesid in ('7a87846b-ba5a-4989-bdac-25b1e257f10d', 'baabad3c-3468-48fb-80a9-b12d541b77fe');

update documentattachment set activeflag = 0, updatedby = 'CDM-30357', 
updatedon = now() where documentpropertiesid in ('7a87846b-ba5a-4989-bdac-25b1e257f10d', 'baabad3c-3468-48fb-80a9-b12d541b77fe');