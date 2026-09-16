DO $$
<<block1>>
DECLARE
caseIdentifier UUID := 'bb36028f-aeaa-4eba-9e28-4edfc2320d96';

personIdentifier UUID := 'b04d260b-4ef4-4a14-af0e-da0374881d9b';

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-22147';

BEGIN
UPDATE
  actor
SET
  activeflag = 0,
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  intakeserviceid = caseIdentifier
  AND personid = personIdentifier
  AND activeflag = 1;

UPDATE
  intakeservicerequestactor
SET
  activeflag = 0,
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  intakeserviceid = caseIdentifier
  AND personid = personIdentifier
  AND activeflag = 1;

UPDATE
  personrole
SET
  activeflag = 0,
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  intakeserviceid = caseIdentifier
  AND personid = personIdentifier
  AND activeflag = 1;
END block1 $$;