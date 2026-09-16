/*
   Issue Description: CDM-29321
   Category/ Module  : Investigation Findings
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.intakeservicerequestactor
SET activeflag=1, updatedon=now(), intakeservicerequestpersontypekey='AM', updatedby='CDM-29321', isprimary=true
WHERE intakeservicerequestactorid='176eb8ea-3b31-4b19-8301-f1e7c80d1999' and personid='bd795589-e9a6-449f-be21-7824fad83065';

UPDATE cjams.intakeservicerequestactor
SET activeflag=0, updatedon=now(), updatedby='CDM-29321'
WHERE intakeservicerequestactorid='07fb4c4c-379b-49f1-a2a7-60e9196d690a' and personid='bd795589-e9a6-449f-be21-7824fad83065';

update Investigationmaltreatment 
set activeflag = 0, updatedby ='CDM-29321', updatedon = now()
where maltreatmentid in ('de5982e9-fd1e-4e45-8f99-62175c2346a5','153ead5b-d040-4ef1-b73e-599dcb14bf06');

UPDATE cjams.legislative
SET isallegedvicitm=true,updatedby ='CDM-29321', updatedon = now()
WHERE legislativeid='21d8846e-2da2-49af-9477-41e233baf985' and intakeserviceid='d9b0ff32-4c3b-45c1-8bff-63a5228c8227';

