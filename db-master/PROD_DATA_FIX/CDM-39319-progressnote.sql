/*
   Issue Description: CDM-39319
   Category/ Module : Progress Note
   Root cause: USer error
   Fix Provided: Did data fix to remove contact note from case
*/
UPDATE cjams.progressnote
SET updatedby='CDM-39319', updatedon=now(), activeflag = 0
WHERE progressnoteid='d5746dee-9d36-4390-9de5-ff5d1216fcf0'::uuid;
