/*
   Issue Description: CDM-33292
   Category/ Module  : Person missing from the case
   Root cause: Person role was updated from cps case isprimary got changed
   Fix Provided: Code fix has been done as part of CIDM-7358
*/

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-33292', updatedon=now(), isprimary=false 
WHERE intakeservicerequestactorid='83a8db53-94e4-4179-81c5-2d91c941d25c' and personid='ec232325-fe4c-434e-98ab-43aca49d1a5a';

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-33292', updatedon=now(), isprimary=true 
WHERE intakeservicerequestactorid='b918d55d-b9cd-4dde-8f36-adbf79477600' and personid='ec232325-fe4c-434e-98ab-43aca49d1a5a';
