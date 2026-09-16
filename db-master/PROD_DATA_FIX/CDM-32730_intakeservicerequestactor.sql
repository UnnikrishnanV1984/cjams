/*
   Issue Description: CDM-32730
   Category/ Module  : Person missing from the case
   Root cause: Person role was updated from cps case isprimary got changed
   Fix Provided: Code fix has been done as part of CIDM-7358
*/

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-32730', updatedon=now(), isprimary=false 
WHERE intakeservicerequestactorid='73c9495a-67ee-4bf0-bfbb-1b9ae59ba25c' and personid='b58fe382-50fd-4105-9009-b85c20dc6986';

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-32730', updatedon=now(), isprimary=true 
WHERE intakeservicerequestactorid='69dd7e20-8ca1-471f-a98e-f6c5bcfc4ff9' and personid='b58fe382-50fd-4105-9009-b85c20dc6986';
