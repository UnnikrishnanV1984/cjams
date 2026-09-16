/*
   Issue Description:CDM-33346
   Category/ Module  : Child removal
   Root cause: user request 
   Fix Provided: Did data fix remove draft removal 
*/


UPDATE cjams.intakeservreqchildremoval
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-33346'
WHERE intakeservreqchildremovalid='7a227c58-898a-4231-a72e-5e34f441599c';

UPDATE cjams.intakeservreqchildremoval_history
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-33346'
WHERE intakeservreqchildremovalid='7a227c58-898a-4231-a72e-5e34f441599c' and activeflag = 1;