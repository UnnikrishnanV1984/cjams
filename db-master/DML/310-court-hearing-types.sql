UPDATE intakeservicerequestcourthearing ich
SET hearingtype = concat('["', hearingtypekey, '"]') ::json
WHERE hearingtype IS NULL AND old_id IS NULL;