DO $$
<<block1>>
DECLARE
serviceCaseIdentifier UUID := 'c10467c8-c209-4109-a03d-f0e17ec999f5';

personIdentifier UUID := '23504a90-fb62-44bb-a2b6-dd4c1d456a6a';

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-13810';

BEGIN 
UPDATE
  actor
SET
  activeflag = 0,
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  servicecaseid = serviceCaseIdentifier
  AND personid = personIdentifier
  AND activeflag = 1;

UPDATE
  intakeservicerequestactor
SET
  activeflag = 0,
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  servicecaseid = serviceCaseIdentifier
  AND personid = personIdentifier
  AND activeflag = 1;

UPDATE
  personrole
SET
  activeflag = 0,
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  servicecaseid = serviceCaseIdentifier
  AND personid = personIdentifier
  AND activeflag = 1;
END block1 $$;