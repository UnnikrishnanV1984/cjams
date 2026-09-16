/*
   Issue Description: CDM-28257
   Category/ Module  : Placement
   Root cause: .
   Pull request# for code fix:  
*/
UPDATE cjams.placement
SET intakeservicerequestactorid='4121461c-6307-4e06-b00e-c5f097aa2c2c',
 updatedby='CDM-28257', updatedon=now(), intakeservreqchildremovalid='36c11319-1806-4ddc-9c47-32462ab378ac'
WHERE placementid='3bc6967f-3ce8-4ab4-93a9-5396bd934f1a' and personid = 'a648c0b5-41c7-4b02-a3ca-e744e1902e08';
