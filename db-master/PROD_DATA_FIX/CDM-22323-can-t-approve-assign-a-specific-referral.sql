DO $$
<<block1>>
DECLARE
intakeNum TEXT := 'I221010270642';

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-22323';

intakeJson JSONB;

BEGIN
intakeJson :=(
SELECT
  jsondata
FROM
  intakedastaging
WHERE
  intakenumber = intakeNum
  AND activeflag = 1);

intakeJson := jsonb_set(intakeJson, '{DAType,DATypeDetail,0,supDisposition}', 'null');

intakeJson := jsonb_set(intakeJson, '{DAType,DATypeDetail,0,dispositioncode}', 'null');

intakeJson := jsonb_set(intakeJson, '{disposition,0,supDisposition}', 'null');

intakeJson := jsonb_set(intakeJson, '{disposition,0,dispositioncode}', 'null');

UPDATE
  intakeservicerequest
SET
  activeflag = 0,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum;

UPDATE
  intakedastaging
SET
  status = 'pending',
  ispreintake = FALSE,
  jsondata = intakeJson,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum
  AND activeflag = 1;

UPDATE
  intakedastatus
SET
  status = 1,
  ispreintake = FALSE,
  jsondata = intakeJson,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum
  AND activeflag = 1;

UPDATE
  intakesnapshot
SET
  activeflag = 0,
  jsondata = intakeJson,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum
  AND activeflag = 1;

UPDATE
  routing
SET
  routingstatustypeid = (
  SELECT
    sequencenumber
  FROM
    routingstatustype
  WHERE
    routingstatustypekey = 'New'
    AND activeflag = 1),
  activeflag = 1,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  objectid = intakeNum
  AND eventcode = 'INTR';
END block1 $$;