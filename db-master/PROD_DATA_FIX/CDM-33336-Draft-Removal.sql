/*
   Issue Description:CDM-33336
   Category/ Module  : Child removal
   Root cause: user request 
   Fix Provided: Did data fix remove draft removal 
*/


UPDATE cjams.intakeservreqchildremoval
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-33336'
WHERE intakeservreqchildremovalid='d71a5764-4c32-4abd-b09a-80310fa406b3';

UPDATE cjams.intakeservreqchildremoval_history
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-33336'
WHERE intakeservreqchildremovalid='d71a5764-4c32-4abd-b09a-80310fa406b3' and activeflag = 1;
