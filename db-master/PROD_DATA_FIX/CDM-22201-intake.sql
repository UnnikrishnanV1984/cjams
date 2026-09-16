DO $$
<<block1>>
DECLARE
intakeNums TEXT[] := ARRAY['I221010267418'];

intakeNum TEXT;

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-22201';

BEGIN
FOREACH intakeNum IN ARRAY intakeNums LOOP
UPDATE
  intakedastaging
SET
  activeflag = 0,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum;

UPDATE
  intakedastatus
SET
  activeflag = 0,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum;
END LOOP;
END block1 $$;
