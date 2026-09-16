DO $$
<<block1>>
DECLARE
intakeNums TEXT[] := ARRAY['I211010226088'];

intakeNum TEXT;

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-21916';

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
