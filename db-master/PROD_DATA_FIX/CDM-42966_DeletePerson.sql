-- CDM-42966 - Delete person
/* Issue Description: Patricia Crandell (PID: 1466066) needs to be deleted from this case as she was included in error

-- AR Case: 241022955649
--Client Id: 1466066
--Person Id: bd99f680-6803-48b4-99d3-de92b5bde77e
--Intake serviceId: 9153a2cc-f24a-40ab-a135-4a33234b0579

-- Category/ Module: Person 

-- Root cause: Patricia Crandell (PID: 1466066) needs to be deleted from this case as she was included in error
-- Fix Provided: Datafix has been provided to reomve person from the case 
-- Pull request# N/A

*/

UPDATE cjams.actor
SET activeflag = 0,
updatedby = 'CDM-42966',
updatedon = now()
WHERE actorid='892d5a4d-0a0e-45f1-87ec-71d1d31d824d'::uuid and activeflag = 1;

UPDATE cjams.intakeservicerequestactor
SET activeflag = 0,
updatedby = 'CDM-42966',
updatedon = now()
WHERE intakeservicerequestactorid in ('cc9a0335-0d61-43a2-b448-5faa99e9e84f', 'f3b979d2-21c4-498d-9261-ec819de0c51c', '8b2d40c8-2b04-4119-ae35-76b758e1efb0') and activeflag = 1;

UPDATE cjams.actorrelationship
SET activeflag = 0,
updatedby = 'CDM-42966',
updatedon = now()
WHERE intakeservicerequestactorid in ('cc9a0335-0d61-43a2-b448-5faa99e9e84f', 'f3b979d2-21c4-498d-9261-ec819de0c51c', '8b2d40c8-2b04-4119-ae35-76b758e1efb0') and activeflag = 1;

UPDATE cjams.personrole
SET activeflag = 0,
updatedby = 'CDM-42966',
updatedon = now()
WHERE personroleid='1aea5818-013c-4120-9c76-1cc693d45965'::uuid;

UPDATE cjams.personroletype
SET activeflag = 0,
updatedby = 'CDM-42966',
updatedon = now()
WHERE personroleid='1aea5818-013c-4120-9c76-1cc693d45965'::uuid and activeflag=1;

UPDATE cjams.personprogramarea
SET activeflag = 0,
updatedby = 'CDM-42966',
updatedon = now()
WHERE personprogramid='3c3c350f-9085-497c-a02e-d8bddebd5e37'::uuid;
